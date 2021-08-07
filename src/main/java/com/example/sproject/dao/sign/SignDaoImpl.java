package com.example.sproject.dao.sign;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignLine;

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
		map.put("signContentList", signContentList);
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

	@Override
	public int insertSignLines(List<SignLine> listOfSignLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listOfSignLine", listOfSignLine);
		return session.insert("insertSignLinesOfSign", map);
	}
	
//리스트 보기
	@Override
	public List<Sign> selectListSignOfProposalProcessing(String m_id) {
		return session.selectList("selectListSignOfProposalProcessing", m_id);
	}

	@Override
	public List<Sign> selectListSignOfProposalCompleted(String m_id) {
		return session.selectList("selectListSignOfProposalCompleted", m_id);
	}	
	
	@Override
	public List<Sign> selectListSignOfApprovalWaited(String m_id) {
		return session.selectList("selectListSignOfApprovalWaited", m_id);
	}	

	@Override
	public List<Sign> selectListSignOfApprovalCompleted(String m_id) {
		return session.selectList("selectListSignOfApprovalCompleted", m_id);
	}
	
	@Override
	public List<SignContent> selectListSignContent(int sg_num) {
		return session.selectList("selectListSignContentOfSign", sg_num);
	}

	@Override
	public Sign selectOneSign(int sg_num) {
		return session.selectOne("selectOneSignOfSign", sg_num);
	}

	@Override
	public List<Member> selectListMember() {
		return session.selectList("selectListMemberOfSign");
	}






	
	
}
