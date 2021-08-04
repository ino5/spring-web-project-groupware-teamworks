package com.example.sproject.service.time;


import java.util.List;

import com.example.sproject.model.time.Time;

public interface TimeService {

	void startTime(Time time);

	Time mainTime(String m_id);

	void endTime(Time time);

	List<Time> timeList_sdate(String m_id);

	List<Time> timeList_edate(String m_id);

}
