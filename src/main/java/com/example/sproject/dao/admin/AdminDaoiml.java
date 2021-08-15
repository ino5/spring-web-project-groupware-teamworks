package com.example.sproject.dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.admin.AdminService;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoiml implements AdminDao {

	@Autowired
	private SqlSession session;

	
	@Override
	public List<Member> listMember(Member member) {
		List<Member> memberList = null;
		try {
		memberList = session.selectList("memberListOfAdmin", member);
		} catch (Exception e) {
			System.out.println("AdminDaoiml listMember Exception->"+e.getMessage());
		}
		return memberList;
	}
	@Override
	public int tot() {
		System.out.println("adminConrollrer tot Start");
		int tot = session.selectOne("memberCntOfAdmin");
		return tot;
	}
	@Override
	public void adminGroup(List<String> groupList,String pt_code) {
		System.out.println("adminGroup method");
		for(int i = 0; i < groupList.size(); i++) {
			String m_id = groupList.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", m_id);
			map.put("pt_code",pt_code);
			System.out.println("m_id / pt_code");
			System.out.println(m_id + "/" + pt_code);
			session.update("selectAdminGroupOfAdmin", map);
		}
		
	}
	
	@Override
	public void adminPassWordChangeGroup(List<String> groupList, Member member) {
		for(int i = 0; i < groupList.size(); i++) {
			String m_id = groupList.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", m_id);
			map.put("m_password",member.getM_password());
	
			session.update("adminPassWordChangeGroupOfAdmin", map);
		
		}
		
	}
	@Override
	public void admindDeleteGroup(List<String> groupList) {
		for(int i = 0; i < groupList.size(); i++) {
			String m_id = groupList.get(i);
			session.delete("DeleteBoardGroupOfAdmin", m_id);
		}
	}
	@Override
	public int checkID(String m_id) {
		int result = session.selectOne("checkedIDMemberOfAdmin", m_id);
		return result;
	}

}
