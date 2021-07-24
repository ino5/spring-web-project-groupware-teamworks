package com.example.sproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.sproject.service.calendar.CalendarService;

@Controller
@RequestMapping("calendar")
public class CalendarController {
	
	@Autowired
	private CalendarService cals;
	
	@RequestMapping("")
	public String index(Model model) {
		return "calendar/calendar";
	}
}
