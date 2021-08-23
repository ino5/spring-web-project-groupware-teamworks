package com.example.sproject.dao.calendar;

import java.util.List;

import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.calendar.Calendar_group;
import com.example.sproject.model.calendar.Color_cal;
import com.example.sproject.model.login.Member;

public interface CalendarDao {

	void scheduleAdd(Calendar calendar);

	List<Calendar> calendarList(String m_id);

	List<Calendar> calendarSelect(int cl_num);

	List<Calendar_group> calendarGroupList(String m_id);

	void groupAdd(Calendar_group calendar_group);

	List<Color_cal> color_calList();


}
