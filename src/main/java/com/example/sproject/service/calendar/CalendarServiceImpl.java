package com.example.sproject.service.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.calendar.CalendarDao;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDao cald;

}
