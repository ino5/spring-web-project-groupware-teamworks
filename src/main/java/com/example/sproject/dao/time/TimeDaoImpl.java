package com.example.sproject.dao.time;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.address.Department;
import com.example.sproject.model.login.Member;
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

	@Override
	public List<Time> timeList_sdate(String m_id) {
		List<Time> timeList_sdate = session.selectList("timeList_sdateOfTime", m_id);
		return timeList_sdate;
	}
	
	@Override
	public List<Time> timeList_edate(String m_id) {
		List<Time> timeList_edate = session.selectList("timeList_edateOfTime", m_id);
		return timeList_edate;
	}

	@Override
	public List<Department> listDeptGroup() {
		List<Department> listDeptGroup = session.selectList("DepartmentOfTime");
		return listDeptGroup;
	}

	@Override
	public int totalDept(String dpt_code) {
		int totalDept = session.selectOne("totalDeptOfTime", dpt_code);
		return totalDept;
	}

	@Override
	public List<Member> listDeptGroupMember(Member member) {
		List<Member> listDeptGroupMember = session.selectList("listDeptGroupMemberOfTime", member);
		return listDeptGroupMember;
	}

	@Override
	public List<Member> listDeptGroupTime(Member member) {
		List<Member> listDeptGroupTime = session.selectList("listDeptGroupTimeOfTime", member);
		return listDeptGroupTime;
	}

}
