package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.time.Time;
import com.example.sproject.service.time.TimeService;

@Controller
@RequestMapping("time")
public class TimeController {
	
	@Autowired
	private TimeService times;
	
	@RequestMapping("")
	public String index(Principal principal, Model model) {
		System.out.println("TimeController Start index..." );
		String m_id = principal.getName();
		Time mainTime = times.mainTime(m_id);
		List<Time> timeList_sdate = times.timeList_sdate(m_id);
		List<Time> timeList_edate = times.timeList_edate(m_id);
		model.addAttribute("mainTime", mainTime);
		model.addAttribute("timeList_sdate", timeList_sdate);
		model.addAttribute("timeList_edate", timeList_edate);
		return "time/time";
	}
	@RequestMapping("123")
	public String asd() {
		return "time/123";
	}
	
	@RequestMapping(value="startTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void startTime(Principal principal, Time time) {
		System.out.println("TimeController Start startTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		times.startTime(time);
		
	}
	
	@RequestMapping(value="endTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void endTime(Principal principal, Time time) {
		System.out.println("TimeController Start endTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		times.endTime(time);
		
	}
}
