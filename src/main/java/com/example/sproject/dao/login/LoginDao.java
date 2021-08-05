package com.example.sproject.dao.login;

import java.util.List;

import com.example.sproject.model.login.Member;

public interface LoginDao {
	Member getUserById(String m_id);
	int insertMember(Member member);
	List<String> listAuthorities(String m_id);
	int updateLastdateOfMember(String m_id);
}
