package com.example.sproject.dao.main;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.main.Main;

@Repository
public class MainDaoImpl implements MainDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public Main getMemberInfo(String m_id) {
		return session.selectOne("getMemberInfoOfMain", m_id);
	}

}
