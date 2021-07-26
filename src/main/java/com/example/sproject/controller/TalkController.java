package com.example.sproject.controller;

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
	static int roomNumber = 0;
	
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
	
	/**
	 * 방 생성하기
	 * @param params
	 * @return
	 */
	@RequestMapping("/createRoom")
	public 
	@ResponseBody 
	List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
		System.out.println("SocketController createroom Start...");
		String roomName = (String) params.get("roomName");
		if(roomName != null && !roomName.trim().equals("")) {
			Room room = new Room();
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			roomList.add(room);
		}
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
		return roomList;
	}
	
	/**
	 * 채팅방
	 * @return
	 */
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
		System.out.println("SocketController moveChating Start...");
		ModelAndView mv = new ModelAndView();
		int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
		List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("roomName", params.get("roomName"));
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.setViewName("talk/talk");
		}else {
			mv.setViewName("talk/room");
		}
		return mv;
	}
}
