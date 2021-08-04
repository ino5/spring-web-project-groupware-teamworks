package com.example.sproject.service.time;


import com.example.sproject.model.time.Time;

public interface TimeService {

	void startTime(Time time);

	Time mainTime(String m_id);

	void endTime(Time time);

}
