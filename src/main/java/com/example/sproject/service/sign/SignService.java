package com.example.sproject.service.sign;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.example.sproject.model.sign.SignLine;

public interface SignService {

	int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req);

	int getSg_numOfNewSign(String m_id, String sgf_id);

	int insertSignLines(List<SignLine> listOfSignLine);

	List<SignLine> convertToListOfSignLine(int sg_num, String[] listOfm_idOfSignLine);

}
