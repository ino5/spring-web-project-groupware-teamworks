package com.example.sproject.service.sign;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.sign.SignDao;
import com.example.sproject.model.sign.SignContent;

@Service
public class SignServiceImpl implements SignService {
	@Autowired
	private SignDao signDao;
	
	
	@Override
	public int insertSignContents(int sg_num, String sgf_id, HttpServletRequest req) {
		System.out.println("--Method insertSignContents in Class SignServiceImpl");
		
		//SIGN_FORM_COMPONENT 테이블로부터 각각의 sgfc_id에 대한 SignContent 객체 리스트 만들기
		List<SignContent> signContentList = signDao.selectListSignFormComponent(sgf_id);
		
		//signContent에 sgfc_id 값 제외한 나머지 값들 넣기
		for(SignContent signContent : signContentList) {
			signContent.setSg_num(sg_num);
			signContent.setSgf_id(sgf_id);
			signContent.setSgc_content(req.getParameter(signContent.getSgfc_id()) != null ? req.getParameter(signContent.getSgfc_id()) : "");
			System.out.println(signContent); //콘솔 확인
		}
		
		//SIGN_CONTENT 테이블에 insert all 하기
		signDao.insertSignContents(signContentList);
		
		return 1;
	}


	@Override
	public int getSg_numOfNewSign(String m_id, String sgf_id) {
		System.out.println("-- com.example.sproject.service.sign.SignServiceImpl.getSg_numOfNewSign(String, String)");
		
		//max sg_num 찾기
		int sg_num = 1 + signDao.selectOneMaxSg_numOfSign();
		
		//SIGN 테이블에 insert하기
		signDao.insertSign(sg_num, m_id, sgf_id);
		
		//sg_num 리턴하기
		return sg_num;
	}

}
