package com.example.sproject.dao.time;

import java.util.List;

import com.example.sproject.model.time.Time;

public interface TimeDao {

	void startTime(Time time);

	Time mainTime(String m_id);

	void endTime(Time time);

}
