package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignLine;
import com.example.sproject.service.sign.SignService;

@Controller
@RequestMapping("sign")
public class SignController {
	@Autowired
	private SignService signService;
	
	//전자결재 메인
	@RequestMapping("")
	public String index(Principal principal, Model model) {
		//목록 가져오기 : 기안 진행 중인 문서
		List<Sign> listOfSignOfProposalProcessing = signService.listSignOfProposalProcessing(principal.getName());
		model.addAttribute("listOfSignOfProposalProcessing", listOfSignOfProposalProcessing);
		
		//목록 가져오기 : 기안 완료 문서
		List<Sign> listOfSignOfProposalCompleted = signService.listSignOfProposalCompleted(principal.getName());
		model.addAttribute("listOfSignOfProposalCompleted", listOfSignOfProposalCompleted);
		
		//목록 가져오기 : 결재 대기 문서
		List<Sign> listOfSignOfApprovalWaited = signService.listSignOfApprovalWaited(principal.getName());
		model.addAttribute("listOfSignOfApprovalWaited", listOfSignOfApprovalWaited);
		
		//목록 가져오기 : 결제 처리 문서
		List<Sign> listOfSignOfApprovalCompleted = signService.listSignOfApprovalCompleted(principal.getName());
		model.addAttribute("listOfSignOfApprovalCompleted", listOfSignOfApprovalCompleted);
		
		return "sign/signMain";
	}

	//전자결재문서 입력창
	@RequestMapping(value = "form", method = { RequestMethod.GET, RequestMethod.POST })
	public String form(int cg_num, Model model) {
		System.out.println("-- com.example.sproject.controller.SignController.form(int, Model)");
		System.out.println("cg_num: " + cg_num);
		String sgf_id = "draft";
		model.addAttribute("jspType", "w");
		
		//멤버 목록 가져오기
		List<Member> listOfMember = signService.listMember();
		System.out.println("listOfMember.size(): "+ listOfMember.size());
		model.addAttribute("listOfMember", listOfMember);
		return "sign/form/" + sgf_id;
	}

	//전자결재문서 내용 DB에 등록하기
	@RequestMapping(value = "insert", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert(@RequestParam(value = "sgl_m_id") String[] listOfM_idOfSignLine, @RequestParam(value = "sgl_type") int[] listOfSgl_typeOfSignLine, String sgf_id, MultipartFile file1, 
			HttpServletRequest req, @AuthenticationPrincipal Member sessionMember, Model model) {
		System.out.println("-- com.example.sproject.controller.SignController.insert(String, HttpServletRequest, Member, Model)");
		
		//결재라인 m_id 콘솔 확인
		System.out.println("listOfM_idOfSignLine.length: " + listOfM_idOfSignLine.length);
		for(String string : listOfM_idOfSignLine) {
			System.out.println("m_id of sign: " + string);
		}
		
		//전자결재문서(SIGN 테이블) insert 하고 해당 sg_num 가져오기
		int sg_num = signService.getSg_numOfNewSign(sessionMember.getM_id(), sgf_id); // 임시 테스트용

		
		//파일 저장하기
		System.out.println(file1);
		
		//전자결재문서내용(SIGN_CONTENT 테이블) insert
		signService.insertSignContents(sg_num, sgf_id, req);

		//결재라인(SIGN_LINE) insert
		List<SignLine> listOfSignLine = signService.convertToListOfSignLine(sg_num, listOfM_idOfSignLine, listOfSgl_typeOfSignLine);
		signService.insertSignLines(listOfSignLine);
		return "redirect:/sign";
	}
	
	//전자결재문서 내용 읽기
	@RequestMapping(value = "view/{sgf_id:.+}/{sg_num:.+}", method = { RequestMethod.GET })
	public String view(@PathVariable("sg_num") int sg_num, @PathVariable("sgf_id") String sgf_id, Model model) {
		Sign sign = signService.selectOneSign(sg_num);
		//전자결재문서 입력내용들 Map형태로 가져오기
		Map<String, Object> mapOfSignContent = signService.findMapOfSignContent(sg_num);
		
		model.addAttribute("sign", sign);
		model.addAttribute("mapOfsignContent", mapOfSignContent);
		model.addAttribute("jspType", "r");
		return "sign/form/" + sgf_id;
	}
}
