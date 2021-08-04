package com.example.sproject.service.time;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.time.TimeDao;
import com.example.sproject.model.time.Time;

@Service
public class TimeServiceImpl implements TimeService {

	@Autowired
	private TimeDao timeDao;
	
	@Override
	public void startTime(Time time) {
		timeDao.startTime(time);
	}

	@Override
	public Time mainTime(String m_id) {
		Time mainTime = timeDao.mainTime(m_id);
		return mainTime;
	}

	@Override
	public void endTime(Time time) {
		timeDao.endTime(time);
		
	}

	@Override
	public List<Time> timeList_sdate(String m_id) {
		List<Time> timeList_sdate = timeDao.timeList_sdate(m_id);
		return timeList_sdate;
	}

	@Override
	public List<Time> timeList_edate(String m_id) {
		List<Time> timeList_edate = timeDao.timeList_edate(m_id);
		return timeList_edate;
	}
}
