package com.example.sproject.dao.sign;

import java.util.List;

import com.example.sproject.model.sign.SignContent;

public interface SignDao {

	List<SignContent> selectListSignFormComponent(String sgf_id);

	int insertSignContents(List<SignContent> signContentList);

	int selectOneMaxSg_numOfSign();

	int insertSign(int sg_num, String m_id, String sgf_id);

}
