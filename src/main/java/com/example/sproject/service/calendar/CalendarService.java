package com.example.sproject.service.calendar;

import java.util.List;

import com.example.sproject.model.calendar.Calendar;

public interface CalendarService {

	void scheduleAdd(Calendar calendar);

	List<Calendar> calendarList(String m_id);


}
