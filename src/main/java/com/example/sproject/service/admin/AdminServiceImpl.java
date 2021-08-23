package com.example.sproject.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.sproject.model.login.Member;
import com.example.sproject.dao.admin.AdminDao;
@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private AdminDao admindao;
	
	@Override
	public int total() {
	int totCnt = admindao.tot();
		return totCnt;
	}

	@Override
	public List<Member> listMember(Member member) {
		List<Member> memberList = null;
		memberList = admindao.listMember(member);
		return memberList;
	}

	@Override
	public void adminGroup(List<String> groupList, String pt_code) {
	
		admindao.adminGroup(groupList, pt_code);
		return;
		
	}

	@Override
	public void adminPassWordChangeGroup(List<String> groupList, Member member) {
		member.setM_password(passwordEncoder.encode("1234"));
		admindao.adminPassWordChangeGroup(groupList, member );
		
	}

	@Override
	public void admindDeleteGroup(List<String> groupList) {
		admindao.admindDeleteGroup(groupList);
		
	}

	@Override
	public int checkID(String m_id) {
		int result = admindao.checkID(m_id);
		return result;
	}
	@Override
	public List<Member> memberAllList() {
		List<Member> memberList = null;
		memberList = admindao.memberAllList();
		return memberList;
	}

	@Override
	public List<Member> timeList() {
		List<Member> timeList = null;
		timeList = admindao.timeList();
		return timeList;
	}
	
	
}
