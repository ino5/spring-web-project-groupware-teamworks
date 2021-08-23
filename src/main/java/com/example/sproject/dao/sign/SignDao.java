package com.example.sproject.dao.sign;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignForm;
import com.example.sproject.model.sign.SignLine;

public interface SignDao {

	List<SignContent> selectListSignFormComponent(String sgf_id);

	int insertSignContents(List<SignContent> signContentList);

	int selectOneMaxSg_numOfSign();

	int insertSign(int sg_num, String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);
	
	//리스트 가져오기
	List<Sign> selectListSignOfProposalProcessing(Sign sign);
	List<Sign> selectListSignOfApprovalWaited(Sign sign);
	List<Sign> selectListSignOfProposalCompleted(Sign sign);
	List<Sign> selectListSignOfApprovalCompleted(Sign sign);
	int selectCountSignOfProposalProcessing(Sign sign);
	int selectCountSignOfApprovalWaited(Sign sign);
	int selectCountSignOfProposalCompleted(Sign sign);
	int selectCountSignOfApprovalCompleted(Sign sign);
	
	
	List<SignContent> selectListSignContent(int sg_num);

	Sign selectOneSign(int sg_num);

	List<Member> selectListMember();

	List<SignLine> selectListSignLine(int sg_num);

	int approveSign(SignLine signLine);

	List<SignForm> selectListSignForm();
	/**
	 * 전자결재 상태 업데이트하기
	 * @param sg_status
	 * @return
	 */
	int updateSignStatus(int sg_num, int sg_status);




}
