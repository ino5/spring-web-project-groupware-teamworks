package com.example.sproject.dao.login;

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

}
