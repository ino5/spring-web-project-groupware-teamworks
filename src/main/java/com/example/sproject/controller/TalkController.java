package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.service.talk.TalkService;

@Controller
@RequestMapping("talk")
public class TalkController {
	@Autowired
		TalkService talkService;
	
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

	@RequestMapping("/Member")
	public ModelAndView Member(@AuthenticationPrincipal Member sessionMember) {
		System.out.println("SocketController MemberList Start...");
		ModelAndView mv = new ModelAndView();
		
		String m_id = null;
		String m_name = null;
		if(sessionMember != null) {
			System.out.println("sessionMember: " + sessionMember);
			m_id = sessionMember.getM_id();
			m_name = sessionMember.getM_name();
			mv.addObject("m_id", m_id);
			mv.addObject("m_name", m_name);
		}


		List<Member> memberList = talkService.selectMemberList(m_id);
		mv.addObject("memberList", memberList);
		mv.setViewName("talk/Member");
		return mv;
	}
	
	@RequestMapping("/MemberList")
	public ModelAndView MemberList(@AuthenticationPrincipal Member sessionMember) {
		System.out.println("SocketController MemberList Start...");
		ModelAndView mv = new ModelAndView();
		
		String m_id = null;
		String m_name = null;
		if(sessionMember != null) {
			System.out.println("sessionMember: " + sessionMember);
			m_id = sessionMember.getM_id();
			m_name = sessionMember.getM_name();
			mv.addObject("m_id", m_id);
			mv.addObject("m_name", m_name);
		}


		List<Member> memberList = talkService.selectMemberList(m_id);
		mv.addObject("memberList", memberList);
		mv.setViewName("talk/MemberList");
		return mv;
	}
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
			room.setTkrm_num(++roomNumber);
			room.setTkrm_name(roomName);
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
//	@RequestMapping("/getRoom")
//	public 
//	@ResponseBody
//	List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
//		System.out.println("SocketController getRoom Start...");
//		System.out.println("roomList: " + roomList);
//		return roomList;
//	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(String m_id2, @AuthenticationPrincipal Member sessionMember) {
		System.out.println("SocketController moveChating Start...");
		ModelAndView mv = new ModelAndView();
		
		//세션 아이디 정보 가져오기
		String m_id = null;
		String m_name = null;
		if(sessionMember != null) {
			m_id = sessionMember.getM_id();
			m_name = sessionMember.getM_name();
			mv.addObject("m_id", m_id);
			mv.addObject("m_name", m_name);
		}
		System.out.println("m_id: " + m_id);
		
		//멤버리스트 가져오기
		List<Member> memberList = talkService.selectMemberList(m_id);
		mv.addObject("memberList", memberList);
		
		//일대일 채팅방 가져오기
		Room room = talkService.getRoomOfOneByOne(m_id, m_id2);
		System.out.println(room);
		mv.addObject("roomName", room.getTkrm_name());
		mv.addObject("roomNumber", room.getTkrm_num());
		
		//채팅 기록 가져오기
		List<Talk> talkList = talkService.selectChat(room.getTkrm_num());
		mv.addObject("talkList", talkList);
		mv.setViewName("talk/MemberList");
		
//		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
//		List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
//		// 컬렉션의 저장 요소를 하나씩 참조해서 람다식으로 처리할 수 있도록 해주는 반복자
//		if(new_list != null && new_list.size() > 0) {
//			mv.addObject("roomName", params.get("roomName"));
//			mv.addObject("roomNumber", params.get("roomNumber"));
//			mv.addObject("m_id", m_id);
//			List<Talk> talkList = talkService.selectChat(roomNumber);
//			mv.addObject("talkList", talkList);
//			
//			mv.setViewName("talk/talk");
//		}else {
//			mv.setViewName("talk/room");
//		}
		return mv;
	}
	
	@RequestMapping("/getMemberList")
	@ResponseBody
	public Map<String, Object> getMemberList(@AuthenticationPrincipal Member sessionMember) {
		System.out.println("SocketController getMemberList Start...");
		Map<String, Object> map = new HashMap<String, Object>();
		String m_id = sessionMember.getM_id();
		List<Member> memberList = talkService.selectMemberList(m_id);
		map.put("m_id", m_id);
		map.put("m_name", sessionMember.getM_name());
		map.put("memberList", memberList);
		System.out.println("memberList");
		for(Member member : memberList) System.out.println(member);
		return map;
	}
	
	@RequestMapping("/Test")
	public ModelAndView Test(@AuthenticationPrincipal Member sessionMember) {
		String m_id = null;
		if(sessionMember != null) {
			m_id = sessionMember.getM_id();			
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("talk/TestPage");
		return mv;
	}
	
	@RequestMapping("/getRoomOfApi")
	@ResponseBody
	public Map<String, Object> getroomNumber(String m_id2, @AuthenticationPrincipal Member sessionMember) {
		System.out.println("SocketController getMemberList Start...");
		Map<String, Object> map = new HashMap<String, Object>();
		String m_id = null;
		if(sessionMember != null) {
			m_id = sessionMember.getM_id();			
		}
		
		//일대일 채팅방 가져오기
		Room room = talkService.getRoomOfOneByOne(m_id, m_id2);
		System.out.println(room);
		
		//채팅 기록 가져오기
		List<Talk> talkList = talkService.selectChat(room.getTkrm_num());
		System.out.println("talkList");
		for(Talk talk : talkList) System.out.println(talk);
		
		//맵에 넣기
		map.put("room", room);
		map.put("talkList", talkList);

		return map;
	}
}
