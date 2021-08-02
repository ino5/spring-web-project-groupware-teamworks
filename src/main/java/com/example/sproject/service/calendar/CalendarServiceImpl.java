package com.example.sproject.service.calendar;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.calendar.CalendarDao;
import com.example.sproject.model.calendar.Calendar;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDao calDao;

	@Override
	public void scheduleAdd(Calendar calendar) {
		calDao.scheduleAdd(calendar);
	}

	@Override
	public List<Calendar> calendarList(String m_id) {
		List<Calendar> calendarList = calDao.calendarList(m_id);
		return calendarList;
	}

}
