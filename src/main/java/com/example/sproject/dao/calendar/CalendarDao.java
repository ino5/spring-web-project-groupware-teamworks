package com.example.sproject.dao.calendar;

import java.util.List;

import com.example.sproject.model.calendar.Calendar;

public interface CalendarDao {

	void scheduleAdd(Calendar calendar);

	List<Calendar> calendarList(String m_id);


}
