package com.example.sproject.dao.calendar;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CalendarDaoImpl implements CalendarDao {

	@Autowired
	private SqlSession session;
	

}
