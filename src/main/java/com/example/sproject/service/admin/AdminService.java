package com.example.sproject.service.admin;

import java.util.List;

import com.example.sproject.model.login.Member;

public interface AdminService {

	int total();

	List<Member> listMember(Member member);

	void adminGroup(List<String> groupList, String pt_code);

	void adminPassWordChangeGroup(List<String> groupList, Member member );

	void admindDeleteGroup(List<String> groupList);

	int checkID(String m_id);
	
	List<Member> memberAllList();

	List<Member> timeList();

	List<Member> member_PositionList(Member member);

}
