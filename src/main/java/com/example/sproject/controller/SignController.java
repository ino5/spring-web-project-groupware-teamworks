package com.example.sproject.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.sign.SignService;

@Controller
@RequestMapping("sign")
public class SignController {
	@Autowired
	private SignService	signService;
	
	@RequestMapping("")
	public String index(Model model) {
		return "sign/signMain";
	}
	
	@RequestMapping(value= "form", method = {RequestMethod.GET, RequestMethod.POST})
	public String form(int cg_num, Model model) {
		System.out.println("cg_num: " + cg_num);
		String sgf_id = "draft";
		return "sign/form/"+sgf_id;
	}
	
	//전자결재문서 내용 DB에 등록하기
	@RequestMapping(value= "insert", method = {RequestMethod.GET, RequestMethod.POST})
	public String insert(String sgf_id, HttpServletRequest req, @AuthenticationPrincipal Member sessionMember, Model model) {
		System.out.println("-- com.example.sproject.controller.SignController.insert(String, HttpServletRequest, Member, Model)");
		
		//전자결재문서(SIGN 테이블) insert 하고 해당 sg_num 가져오기
		int sg_num = signService.getSg_numOfNewSign(sessionMember.getM_id(), sgf_id); //임시 테스트용
		
		//전자결재문서내용(SIGN_CONTENT 테이블) insert
		signService.insertSignContents(sg_num, sgf_id, req);
		
		
		//결재라인(SIGN_LINE) insert
		
		
		return null;
	}
}
