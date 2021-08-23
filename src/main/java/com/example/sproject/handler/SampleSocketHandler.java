package com.example.sproject.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component("sampleSocketHandler")
public class SampleSocketHandler extends TextWebSocketHandler {
	
	Map<String, WebSocketSession> sessionMap = new HashMap<>();
	Map<String, String> m_idToSessionIdMap = new HashMap<>();
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("--handleTextMessage in SampleSocketHandler");
		String msg = message.getPayload();
		JSONObject obj = jsonToObjectParser(msg);
		String msgType = (String) obj.get("type");
		if (msgType.equals("m_id")) {
			String m_id = (String) obj.get("m_id");
			m_idToSessionIdMap.put(m_id, session.getId());
			System.out.println("m_id");
			System.out.println("m_id: " + m_id);
			System.out.println("session.getId() " + session.getId());
		}
	}	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("--afterConnectionEstablished Of SampleSocketHandler");
		sessionMap.put(session.getId(), session);
		System.out.println((WebSocketSession)sessionMap.get(session .getId()));
	}


	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionMap.remove(session.getId());
		super.afterConnectionClosed(session, status);
		System.out.println("--afterConnectionClosed Of SampleSocketHandler");
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
	
	public void sendTalkMessage(String m_id, JSONObject JsonObject) {
		System.out.println("sendTalkMessage");
		String sessionId = m_idToSessionIdMap.get(m_id);
		WebSocketSession wss = (WebSocketSession)sessionMap.get(sessionId);
		System.out.println("sessionId: " + sessionId);
		System.out.println("wss: " + wss);
		if(wss != null) {
			try {
				System.out.println("wss != null");
				wss.sendMessage(new TextMessage(JsonObject.toJSONString()));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}		
	}
}
