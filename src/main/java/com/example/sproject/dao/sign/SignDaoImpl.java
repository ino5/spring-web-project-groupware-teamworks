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
import com.example.sproject.model.sign.SignForm;
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
	public List<Sign> selectListSignOfProposalProcessing(Sign sign) {
		return session.selectList("selectListSignOfProposalProcessing", sign);
	}

	@Override
	public List<Sign> selectListSignOfProposalCompleted(Sign sign) {
		return session.selectList("selectListSignOfProposalCompleted", sign);
	}	
	
	@Override
	public List<Sign> selectListSignOfApprovalWaited(Sign sign) {
		return session.selectList("selectListSignOfApprovalWaited", sign);
	}	

	@Override
	public List<Sign> selectListSignOfApprovalCompleted(Sign sign) {
		return session.selectList("selectListSignOfApprovalCompleted", sign);
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

	@Override
	public List<SignLine> selectListSignLine(int sg_num) {
		return session.selectList("selectListSignLineOfSign", sg_num);
	}

	@Override
	public int selectCountSignOfProposalProcessing(Sign sign) {
		return session.selectOne("selectCountSignOfProposalProcessing", sign);
	}

	@Override
	public int selectCountSignOfApprovalWaited(Sign sign) {
		// TODO Auto-generated method stub
		return session.selectOne("selectCountSignOfApprovalWaited", sign);
	}

	@Override
	public int selectCountSignOfProposalCompleted(Sign sign) {
		// TODO Auto-generated method stub
		return session.selectOne("selectCountSignOfProposalCompleted", sign);
	}

	@Override
	public int selectCountSignOfApprovalCompleted(Sign sign) {
		// TODO Auto-generated method stub
		return session.selectOne("selectCountSignOfApprovalCompleted", sign);
	}

	@Override
	public int approveSign(SignLine signLine) {
		System.out.println("approveSign");
		System.out.println("signLine: " + signLine);
		return session.update("approveSign", signLine);
	}

	@Override
	public List<SignForm> selectListSignForm() {
		return session.selectList("selectListSignForm");
	}

	@Override
	public int updateSignStatus(int sg_num, int sg_status) {
		Sign sign = new Sign();
		sign.setSg_num(sg_num);
		sign.setSg_status(sg_status);
		return session.update("updateSignStatusOfSign", sign);
	}





	
	
}
