package com.example.sproject.dao.login;

import com.example.sproject.model.login.Member;

public interface LoginDao {
	Member getUserById(String m_id);
	int insertMember(Member member);
}
