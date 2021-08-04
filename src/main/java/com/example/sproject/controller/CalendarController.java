package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.calendar.Calendar;
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
		model.addAttribute("calendarList", calendarList);
		return "calendar/calendar";
	}
	
	@RequestMapping("scheduleAdd")
	public String scheduleAdd(Principal principal,Calendar calendar, Model model) {
		String m_id = principal.getName();
		calendar.setM_id(m_id);
		cals.scheduleAdd(calendar);
		return "redirect:/calendar";
	}
	
	@RequestMapping("calendarSelect")
	public String calendarSelect(Principal principal,Calendar calendar, Model model, int cl_num) {
		String m_id = principal.getName();
		calendar.setM_id(m_id);
		List<Calendar> calendarSelect = cals.calendarSelect(cl_num);
		model.addAttribute("calendarSelect", calendarSelect);
		return "redirect:/calendar";
	}
}
