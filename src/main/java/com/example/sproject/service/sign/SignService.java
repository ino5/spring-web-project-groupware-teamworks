package com.example.sproject.service.sign;

import javax.servlet.http.HttpServletRequest;

public interface SignService {

	int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req);

	int getSg_numOfNewSign(String m_id, String sgf_id);

}
