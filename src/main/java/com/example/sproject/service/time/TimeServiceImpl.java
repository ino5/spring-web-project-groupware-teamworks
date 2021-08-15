package com.example.sproject.service.time;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.time.TimeDao;
import com.example.sproject.model.address.Department;
import com.example.sproject.model.login.Member;
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

	@Override
	public List<Department> listDeptGroup() {
		List<Department> listDeptGroup = timeDao.listDeptGroup();
		return listDeptGroup;
	}

	@Override
	public int totalDept(String dpt_code) {
		int totalDept = timeDao.totalDept(dpt_code);
		return totalDept;
	}

	@Override
	public List<Member> listDeptGroupMember(Member member) {
		List<Member> listDeptGroupMember = timeDao.listDeptGroupMember(member);
		return listDeptGroupMember;
	}

	@Override
	public List<Member> listDeptGroupTime(Member member) {	
		List<Member> listDeptGroupTime = timeDao.listDeptGroupTime(member);
		return listDeptGroupTime;
	}
}
