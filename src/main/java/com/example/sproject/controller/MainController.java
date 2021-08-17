package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.main.Main;
import com.example.sproject.model.time.Time;
import com.example.sproject.service.calendar.CalendarService;
import com.example.sproject.service.main.MainService;
import com.example.sproject.service.time.TimeService;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private TimeService timeService;
	
	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping(value = {"main",""})
	public String mainList(@AuthenticationPrincipal Member sessionMember, Model model, Main mainMember) {
		
		String m_id = null;
		String m_name = null;
		if(sessionMember != null) {
			System.out.println("sessionMember: " + sessionMember);
			m_id = sessionMember.getM_id();
			m_name = sessionMember.getM_name();
			
			mainMember = mainService.getMemberInfo(m_id);
			
			Time mainTime = timeService.mainTime(m_id);
			
			List<Calendar> calendarList = calendarService.calendarList(m_id);
			
			model.addAttribute("m_id", m_id);
			model.addAttribute("m_name", m_name);
			model.addAttribute("mainMember", mainMember);
			model.addAttribute("pt_name", mainMember.getPt_name());
			model.addAttribute("m_birth", mainMember.getM_birth());
			model.addAttribute("mainTime", mainTime);
			model.addAttribute("calendarList", calendarList);
		}
		return "main/mainTest";
	}
	
	@RequestMapping(value="startTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void startTime(Principal principal, Time time) {
		System.out.println("TimeController Start startTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		timeService.startTime(time);
		
	}
	
	@RequestMapping(value="endTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void endTime(Principal principal, Time time) {
		System.out.println("TimeController Start endTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		timeService.endTime(time);
	}
	
}
