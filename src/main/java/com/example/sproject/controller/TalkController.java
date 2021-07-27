package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.talk.Room;

@Controller
@RequestMapping("talk")
public class TalkController {
	@RequestMapping("")
	public String index(Model model) {
		return "index";
	}
	
	List<Room> roomList = new ArrayList<Room>();
	static int roomNumber = 0; // 메모리에 한번 할당되어 프로그램이 종료될 때 해제되는 것을 의미
	
	@RequestMapping("/talker")
	public ModelAndView chat() {
		System.out.println("SocketController talker Start...");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("talk/talk");
		return mv;
	}
	
	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("/room")
	public ModelAndView room() {
		System.out.println("SocketController room Start...");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("talk/room");
		return mv;
	}
	// Model -> model.addAttribute를 사용하여 데이터만 저장
	// ModelAndView -> 데이터와 이동하고자 하는 View Page를 같이 저장
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom")
	public 
	@ResponseBody 
	List<Room> createRoom(@RequestParam HashMap<Object, Object> params){ // 메소드의 파라미터값으로 @RequestParam을 넣어주면된다
		System.out.println("SocketController createroom Start...");
		String roomName = (String) params.get("roomName");
		if(roomName != null && !roomName.trim().equals("")) {
			Room room = new Room();
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			roomList.add(room);
		}
		//이건 확실하지 않지만, TALK_ROOM테이블과 TALKER테이블에 값 입력을 이 때 해야될 것 같습니다. 정민희 토크팀 팀장님
		return roomList;
	}
	
	/**
	 * 방 정보가져오기
	 * @param params
	 * @return
	 */
	@RequestMapping("/getRoom")
	public 
	@ResponseBody
	List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
		System.out.println("SocketController getRoom Start...");
		System.out.println("roomList: " + roomList);
		return roomList;
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params, Principal principal) {
		System.out.println("SocketController moveChating Start...");
		//세션 아이디 출력
		String m_id = null;
		if(principal != null) {
			m_id = principal.getName();
		}
		System.out.println("m_id: " + m_id);
		
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		// 컬렉션의 저장 요소를 하나씩 참조해서 람다식으로 처리할 수 있도록 해주는 반복자
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.addObject("m_id", m_id);
			
			//List<Talk> talkList 해서 해당 방번호에 대한 talk들을 List로 가져오는거야.
			//그리고 이걸 addObject하는 거야
			//그다음 jsp에서 그냥 뿌려주는거야. foreach로  보여주면서 c:if로 나와 나아닌거 구분
			
			mv.setViewName("talk/talk");
		}else {
			mv.setViewName("talk/room");
		}
		return mv;
	}
}
