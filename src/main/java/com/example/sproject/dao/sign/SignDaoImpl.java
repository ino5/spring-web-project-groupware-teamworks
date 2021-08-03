package com.example.sproject.dao.sign;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;

@Repository
public class SignDaoImpl implements SignDao {
	@Autowired
	private SqlSession session;

	@Override
	public List<SignContent> selectListSignFormComponent(String sgf_id) {
		System.out.println("-- com.example.sproject.dao.sign.SignDaoImpl.selectListSignFormComponent(String)");
		return session.selectList("selectListSignFormComponentOfSign", sgf_id);
	}

	@Override
	public int insertSignContents(List<SignContent> signContentList) {
		System.out.println("-- com.example.sproject.dao.sign.SignDaoImpl.insertSignContents(List<SignContent>)");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("signContentList",signContentList);
		return session.insert("insertSignContentsOfSign", map);
	}

	@Override
	public int selectOneMaxSg_numOfSign() {
		return session.selectOne("selectOneMaxSg_numOfSignOfSign");
	}

	@Override
	public int insertSign(int sg_num, String m_id, String sgf_id) {
		Sign sign = new Sign(sg_num, m_id, sgf_id);
		return session.insert("insertSignOfSign", sign);
	}
	
	
}
