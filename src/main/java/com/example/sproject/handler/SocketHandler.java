package com.example.sproject.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.service.talk.TalkService;

@Component("socketHandler")
public class SocketHandler extends TextWebSocketHandler {
	@Autowired
	TalkService talkService;
	
	//HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵
	List<HashMap<String, Object>> rls = new ArrayList<>(); // 웹소켓 세션을 담아둘 리스트 -- roomListSessions
//	private static final String FILE_UPLOAD_PATH = "C:/test/websocket/";
	private static final String FILE_UPLOAD_PATH = WebMvcConfig.RESOURCE_PATH + "/talk";
	static int fileUploadIdx = 0;
	static String fileUploadSession  = "";
	// 메시지 발송
	
	@Override	
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		// 메세지 발송
		String msg = message.getPayload(); // JSON 형태의 String메시지를 받음
		JSONObject obj = jsonToObjectParser(msg); // JSON 데이터를 JSONObject로 파싱
		System.out.println("SocketHandler handleTextMessage msg->"+msg);
		String rN = (String) obj.get("roomNumber"); // 방 번호 받음
		String msgType = (String) obj.get("type"); // 메시지 타입 확인
		String m_id = (String) obj.get("m_id");
		String content = (String) obj.get("msg");
		System.out.println("m_id: " + m_id);
		System.out.println("content: " + content);
		
		if(msgType.equals("message")) {
			Talk talk = new Talk();
			talk.setTkrm_num(Integer.parseInt(rN));
			talk.setM_id(m_id);
			talk.setTk_content(content);
			talkService.insertMsg(talk);
		}

		//TalkMsg = dto
		//TalkMsg talkMsg = new TalkMsg();
		//talkMsg.setM_id(m_id);
		//talkMsg.setContent(content);
		//chatService.insertMsg(talkMsg);
		//ChatService 안에 insertMsg는 그냥 chatDao.insertMsg(talkMsg) 실행
		//ChatDao 안에 session.insert("insertMsgOfTalk", talkMsg);
		//xml 안에 id를 insertMsgOfTalk 이거로 해서 "insert into talk(m_id, content, regdate) values(#{m_id}, #{content}, SYSDATE)
		HashMap<String, Object> temp = new HashMap<String, Object>();
		if(rls.size() > 0) {
			for(int i=0; i < rls.size(); i++) {
				String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호 가져오기
				if(roomNumber.equals(rN)) {//같은값의 방이 존재한다면
					temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다 (hashmap이니까! number get하면 value인   object를 가져옴)
					fileUploadIdx = i;
					fileUploadSession = (String) obj.get("sessionId");
					System.out.println("fileUploadSession: " + fileUploadSession);
					break;
				}
			}
		if(!msgType.equals("fileUpload")) { //메시지의 타입이 파일업로드가 아닐때만 전송			
		// 해당 방의 세션들만 찾아서 메시지를 발송
			for(String k : temp.keySet()) {
				if(k.equals("roomNumber")) {//다만 방번호일 경우에는 건너뛴다
					continue;
				}
				
				WebSocketSession wss = (WebSocketSession)temp.get(k);
				if(wss != null) {
					try {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					} catch (IOException e) {
						e.printStackTrace();
				}
				}
			
			}
			}
		}
	}
	
	@Override
	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
		// 바이너리 메시지 발송
		System.out.println("SocketHandler handleBinaryMessage start...");
		ByteBuffer byteBuffer = message.getPayload();
		System.out.println("byteBuffer1->"+byteBuffer);
		System.out.println("message->"+message);
		System.out.println("file_upload_path->"+FILE_UPLOAD_PATH);
		
		
		// 서버 파일 저장
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + ".jpg";		
		File dir = new File(FILE_UPLOAD_PATH);
		System.out.println("dir->"+dir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(FILE_UPLOAD_PATH, fileName);
		System.out.println("fileName->"+fileName);
		System.out.println("file->"+file);
		FileOutputStream out = null;
		FileChannel outChannel = null;
		try {
			byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
			out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다
			outChannel = out.getChannel(); // 채널을 열고
			byteBuffer.compact(); // 파일을 복사
			outChannel.write(byteBuffer); // 파일을 쓴다
			System.out.println("byteBuffer2->"+byteBuffer);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(out != null) {
					out.close();
				}
				if(outChannel != null) {
					outChannel.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		byteBuffer.position(0); // 파일을 저장하면서 position 값이 변경되었으므로 0으로 초기화
		
		// db에 파일 정보 업데이트
		talkService.updateFileImage("resource/talk/" + fileName);
		
		
		// 파일쓰기가 끝나면 이미지 발송
		System.out.println("byteBuffer3->"+byteBuffer);
		HashMap<String, Object> temp = rls.get(fileUploadIdx);
		for(String k : temp.keySet()) {
			if(k.equals("roomNumber")) {
					continue;
			}
			WebSocketSession wss = (WebSocketSession) temp.get(k);
			try {
				wss.sendMessage(new BinaryMessage(byteBuffer)); // 초기화된 버퍼 발송
//				talkService.insertFile(byteBuffer);
				System.out.println("byteBuffer4->"+byteBuffer);
			} catch (IOException e) {
					e.printStackTrace();
			}
		}
	}
	
//  @SuppressWarning
//  이건 컴파일러가 일반적으로 경고하는 내용 중	"이건 하지마"하고 제외시킬 때 쓰임
//	따라서 어떤 경고를 제외시킬지 옵션
//	1. all : 모든 경고를 억제
//	2. cast : 캐스트 연산자 관련 경고 억제
//	3. dep-ann : 사용하지 말아야 할 주석 관련 경고 억제
//	4. deprecation : 사용하지 말아야 할 메소드 관련 경고 억제
//	5. fallthrough : switch문에서의 break 누락 관련 경고 억제
//	6. finally : 반환하지 않는 finally 블럭 관련 경고 억제
//	7. null : null 분석 관련 경고 억제
//	8. rawtypes : 제네릭을 사용하는 클래스 매개 변수가 불특정일 때의 경고 억제
//	9. unchecked : 검증되지 않은 연산자 관련 경고 억제
//	10. unused : 사용하지 않는 코드 관련 경고 억제

	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("SocketHandler afterConnectionEstablished start...");
		// 웹소켓 연결이 되면 동작
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String url = session.getUri().toString();
		System.out.println(url);
		String roomNumber = url.split("/taking/")[1];
		int idx = rls.size(); // 방의 사이즈 조사
		if(rls.size() > 0) {
			for(int i=0; i<rls.size(); i++) {
				String rN = (String) rls.get(i).get("roomNumber");
				if(rN.equals(roomNumber)) {
					flag = true;
					idx = i;
					break;
				}
			}
		}
		
		if(flag) {//존재하는 방이라면 세션만 추가
			HashMap<String, Object> map = rls.get(idx);
			map.put(session.getId(), session);
		}else {//최초 생성하는 방이라면 방번호, 세션 추가
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			rls.add(map);
		}
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}
	
	@Override 
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("SocketHandler afterConnectionEstablished start...");
		// 웹소켓 종료
		if(rls.size() > 0) {//소켓이 종료되면 해당 세션값들을 찾아서 지운다
			for(int i=0; i<rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
			
		}
		super.afterConnectionClosed(session, status);
	}

	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}
