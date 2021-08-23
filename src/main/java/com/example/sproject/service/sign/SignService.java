package com.example.sproject.service.sign;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignForm;
import com.example.sproject.model.sign.SignLine;

public interface SignService {

	int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req);

	int getSg_numOfNewSign(String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);
	
	//결재선 받은 input 리스트들 하나의 SignLine 객체 리스트로 바꾸기
	List<SignLine> convertToListOfSignLine(int sg_num, String[] listOfm_idOfSignLine, int[] listOfSgl_typeOfSignLine);

	//리스트 가져오기
	List<Sign> listSignOfProposalProcessing(Sign sign);
	List<Sign> listSignOfApprovalWaited(Sign sign);
	List<Sign> listSignOfProposalCompleted(Sign sign);
	List<Sign> listSignOfApprovalCompleted(Sign sign);
	int countSignOfProposalProcessing(Sign sign);
	int countSignOfApprovalWaited(Sign sign);
	int countSignOfProposalCompleted(Sign sign);
	int countSignOfApprovalCompleted(Sign sign);
	
	Map<String, Object> findMapOfSignContent(int sg_num);

	Sign selectOneSign(int sg_num);

	List<Member> listMember();

	List<SignLine> findListOfSignLine(int sg_num);

	int approveSign(SignLine signLine);

	List<SignForm> listSignForm();
	
	/**
	 *  서명 이후 문서 상태 업데이트 하기
	 * @param sg_num
	 * @return
	 */
	int updateSignStatus(int sg_num);



	

	

}
