package com.example.sproject.dao.calendar;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.calendar.Calendar;

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
	

}
