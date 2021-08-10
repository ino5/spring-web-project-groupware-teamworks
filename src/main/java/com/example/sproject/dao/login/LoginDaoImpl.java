package com.example.sproject.dao.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.login.Member;

@Repository
public class LoginDaoImpl implements LoginDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public Member getUserById(String m_id) {
		System.out.println("Method getUserById in Class LoginDaoImpl");
		System.out.println("m_id: " + m_id);
		return session.selectOne("selectOneMemberOfLogin", m_id);
	}

	@Override
	public int insertMember(Member member) {
		//think about try
		return session.insert("insertMemberOfLogin", member);
	}

	@Override
	public List<String> listAuthorities(String m_id) {
		return session.selectList("selectListAuthoritiesOfLogin", m_id);
	}

	@Override
	public int updateLastdateOfMember(String m_id) {
		return session.update("updateLastdateOfMember", m_id);
	}

	@Override
	public int updateMemberPhoto(String m_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", m_id);
		map.put("m_photo", "resource/member/photo/" + m_id);
		return session.update("updateMemberPhotoOfLogin", map);
	}

}
