package com.example.sproject.dao.time;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.time.Time;

@Repository
public class TimeDaoImpl implements TimeDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void startTime(Time time) {
		session.insert("startTimeOfTime", time);	
	}

	@Override
	public Time mainTime(String m_id) {
		Time mainTime = session.selectOne("mainTimeOfTime",m_id);
		return mainTime;
	}

	@Override
	public void endTime(Time time) {
		session.update("endTimeOfTime", time);	
		
	}

}
