package com.example.sproject.service.sign;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignLine;

public interface SignService {

	int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req);

	int getSg_numOfNewSign(String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);
	
	//결재선 받은 input 리스트들 하나의 SignLine 객체 리스트로 바꾸기
	List<SignLine> convertToListOfSignLine(int sg_num, String[] listOfm_idOfSignLine, int[] listOfSgl_typeOfSignLine);

	//리스트 가져오기
	List<Sign> listSignOfProposalProcessing(String m_id);
	List<Sign> listSignOfApprovalWaited(String m_id);
	List<Sign> listSignOfProposalCompleted(String m_id);
	List<Sign> listSignOfApprovalCompleted(String m_id);
	
	Map<String, Object> findMapOfSignContent(int sg_num);

	Sign selectOneSign(int sg_num);

	List<Member> listMember();



	

	

}
