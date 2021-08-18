package com.example.sproject.dao.calendar;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.calendar.Calendar_group;
import com.example.sproject.model.calendar.Color_cal;
import com.example.sproject.model.login.Member;

@Repository
public class CalendarDaoImpl implements CalendarDao {

	@Autowired
	private SqlSession session;

	@Override
	public void scheduleAdd(Calendar calendar) {
			session.insert("scheduleAddOfCalendar", calendar);
	}

	@Override
	public List<Calendar> calendarList(String m_id) {
		List<Calendar> calendarList = session.selectList("calendarListOfCalendar", m_id);
		return calendarList;
	}

	@Override
	public List<Calendar> calendarSelect(int cl_num) {
		System.out.println("CalendarDaoImpl calendarSelect Start...");
		List<Calendar> calendarSelect = session.selectList("calendarSelectOfCalendar", cl_num);
		System.out.println("calendarSelect >>>" + calendarSelect);
		return calendarSelect;
	}

	@Override
	public List<Calendar_group> calendarGroupList(String m_id) {
		System.out.println("CalendarDaoImpl calendarGroupList Start...");
		List<Calendar_group> calendarGroupList = session.selectList("calendarGroupListOfCalendar", m_id);
		return calendarGroupList;
	}

	@Override
	public void groupAdd(Calendar_group calendar_group) {
		session.insert("groupAddOfCalendar", calendar_group);
		
	}

	@Override
	public List<Color_cal> color_calList() {
		return session.selectList("color_calListOfColor_cal");
	}

	

}
