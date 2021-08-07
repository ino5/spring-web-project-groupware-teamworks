package com.example.sproject.dao.sign;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignLine;

public interface SignDao {

	List<SignContent> selectListSignFormComponent(String sgf_id);

	int insertSignContents(List<SignContent> signContentList);

	int selectOneMaxSg_numOfSign();

	int insertSign(int sg_num, String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);
	
	//리스트 가져오기
	List<Sign> selectListSignOfProposalProcessing(String m_id);
	List<Sign> selectListSignOfApprovalWaited(String m_id);
	List<Sign> selectListSignOfProposalCompleted(String m_id);
	List<Sign> selectListSignOfApprovalCompleted(String m_id);
	
	List<SignContent> selectListSignContent(int sg_num);

	Sign selectOneSign(int sg_num);

	List<Member> selectListMember();





}
