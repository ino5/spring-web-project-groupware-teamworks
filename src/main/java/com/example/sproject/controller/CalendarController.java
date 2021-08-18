package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.calendar.Calendar_group;
import com.example.sproject.model.calendar.Color_cal;
import com.example.sproject.model.login.Member;
import com.example.sproject.service.calendar.CalendarService;

@Controller
@RequestMapping("calendar")
public class CalendarController {
	
	@Autowired
	private CalendarService cals;
	
	@RequestMapping("")
	public String index(Principal principal, Calendar calendar, Model model) {
		String m_id = principal.getName();
		List<Calendar> calendarList = cals.calendarList(m_id);
		List<Calendar_group> calendarGroupList = cals.calendarGroupList(m_id);
		List<Color_cal> color_cal = cals.color_calList();
		model.addAttribute("calendarList", calendarList);
		model.addAttribute("calendarGroupList", calendarGroupList);
		model.addAttribute("color_cal", color_cal);
		return "calendar/calendar";
	}
	
	@RequestMapping("scheduleAdd")
	public String scheduleAdd(Principal principal,Calendar calendar, Model model) {
		String m_id = principal.getName();
		calendar.setM_id(m_id);
		cals.scheduleAdd(calendar);
		return "redirect:/calendar";
	}
	
	@RequestMapping("groupAdd")
	public String groupAdd(Principal principal,Calendar_group calendar_group, Model model) {
		String m_id = principal.getName();
		calendar_group.setM_id(m_id);
		cals.groupAdd(calendar_group);
		return "redirect:/calendar";
	}
	
//	@RequestMapping("calendarSelect")
//	public String calendarSelect(Principal principal,Calendar calendar, Model model, int cl_num) {
//		String m_id = principal.getName();
//		calendar.setM_id(m_id);
//		List<Calendar> calendarSelect = cals.calendarSelect(cl_num);
//		model.addAttribute("calendarSelect", calendarSelect);
//		return "redirect:/calendar";
//	}
	
	@PostMapping(value="calendarSelect")
	@ResponseBody
	public List<Calendar> calendarSelect(int cl_num){
		List<Calendar> calendarSelect = cals.calendarSelect(cl_num);
		return calendarSelect;
	}
	
}
