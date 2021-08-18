package com.example.sproject.service.calendar;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.calendar.CalendarDao;
import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.calendar.Calendar_group;
import com.example.sproject.model.calendar.Color_cal;
import com.example.sproject.model.login.Member;

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

	@Override
	public List<Calendar> calendarSelect(int cl_num) {
		List<Calendar> calendarSelect = calDao.calendarSelect(cl_num);
		return calendarSelect;
	}

	@Override
	public List<Calendar_group> calendarGroupList(String m_id) {
		List<Calendar_group> calendarGroupList = calDao.calendarGroupList(m_id);
		return calendarGroupList;
	}

	@Override
	public void groupAdd(Calendar_group calendar_group) {
		calDao.groupAdd(calendar_group);
		
	}

	@Override
	public List<Color_cal> color_calList() {
		return calDao.color_calList();
	}

}
