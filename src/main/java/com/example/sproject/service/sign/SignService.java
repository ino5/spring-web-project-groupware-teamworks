package com.example.sproject.service.sign;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignLine;

public interface SignService {

	int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req);

	int getSg_numOfNewSign(String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);

	List<SignLine> convertToListOfSignLine(int sg_num, String[] listOfm_idOfSignLine);

	//리스트 가져오기
	List<Sign> listSignOfProposalProcessing(String m_id);
	List<Sign> listSignOfApprovalWaited(String m_id);
	List<Sign> listSignOfProposalCompleted(String m_id);
	List<Sign> listSignOfApprovalCompleted(String m_id);
	
	Map<String, Object> findMapOfSignContent(int sg_num);

	Sign selectOneSign(int sg_num);



	

	

}
