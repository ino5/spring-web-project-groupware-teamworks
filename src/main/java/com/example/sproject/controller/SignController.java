package com.example.sproject.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.model.common.CommonGroup;
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfCg_num;
import com.example.sproject.model.globals.GlobalsOfTb_code;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.sign.SignContent;
import com.example.sproject.model.sign.SignForm;
import com.example.sproject.model.sign.SignLine;
import com.example.sproject.service.common.CommonPaging;
import com.example.sproject.service.common.CommonService;
import com.example.sproject.service.drive.DriveService;
import com.example.sproject.service.login.LoginService;
import com.example.sproject.service.sign.SignService;

@Controller
@RequestMapping("sign")
public class SignController {
	@Autowired
	private SignService signService;
	@Autowired
	private DriveService driveService;
	@Autowired
	private CommonService commonService;
	
	// 전자결재 메인
	@RequestMapping(value = "", method = { RequestMethod.GET, RequestMethod.POST })
	public String index(@AuthenticationPrincipal Member principal, Model model) {
		Sign sign = new Sign();
		sign.setM_id(principal.getM_id());
		sign.setRn_start(1);
		sign.setRn_end(5);
		
		// 목록 가져오기 : 기안 진행 중 문서
		List<Sign> listOfSignOfProposalProcessing = signService.listSignOfProposalProcessing(sign);
		model.addAttribute("listOfSignOfProposalProcessing", listOfSignOfProposalProcessing);
		
		// 목록 가져오기 : 기안 완료 문서
		List<Sign> listOfSignOfProposalCompleted = signService.listSignOfProposalCompleted(sign);
		model.addAttribute("listOfSignOfProposalCompleted", listOfSignOfProposalCompleted);
		
		// 목록 가져오기 : 결재 대기 문서
		List<Sign> listOfSignOfApprovalWaited = signService.listSignOfApprovalWaited(sign);
		model.addAttribute("listOfSignOfApprovalWaited", listOfSignOfApprovalWaited);
		
		// 목록 가져오기 : 결제 처리 문서
		List<Sign> listOfSignOfApprovalCompleted = signService.listSignOfApprovalCompleted(sign);
		model.addAttribute("listOfSignOfApprovalCompleted", listOfSignOfApprovalCompleted);
		
		return "sign/signMain";
	}
	
	// 전자결재 리스트
	@RequestMapping(value = "list/{listType:.+}", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(@PathVariable String listType, @RequestParam(required = false) Integer currentPage, @AuthenticationPrincipal Member principal, Model model) {
		Sign sign = new Sign();
		sign.setM_id(principal.getM_id());

		// 목록 가져오기 : 기안 진행 중 문서
		if (listType.equals("proposalProcessing")) {
			CommonPaging commonPaging = new CommonPaging(signService.countSignOfProposalProcessing(sign), currentPage);
			sign.setRn_start(commonPaging.getStart());
			sign.setRn_end(commonPaging.getEnd());
			List<Sign> listOfSignOfProposalProcessing = signService.listSignOfProposalProcessing(sign);
			model.addAttribute("listOfSign", listOfSignOfProposalProcessing);
			model.addAttribute("paging", commonPaging);
		}
		
		// 목록 가져오기 : 기안 완료 문서
		else if (listType.equals("proposalCompleted")) {
			CommonPaging commonPaging = new CommonPaging(signService.countSignOfProposalCompleted(sign), currentPage);
			sign.setRn_start(commonPaging.getStart());
			sign.setRn_end(commonPaging.getEnd());
			List<Sign> listOfSignOfProposalCompleted = signService.listSignOfProposalCompleted(sign);
			model.addAttribute("listOfSign", listOfSignOfProposalCompleted);
			model.addAttribute("paging", commonPaging);
		} 
		
		// 목록 가져오기 : 결재 대기 문서
		else if (listType.equals("approvalWaited")) {
			CommonPaging commonPaging = new CommonPaging(signService.countSignOfApprovalWaited(sign), currentPage);
			sign.setRn_start(commonPaging.getStart());
			sign.setRn_end(commonPaging.getEnd());
			List<Sign> listOfSignOfApprovalWaited = signService.listSignOfApprovalWaited(sign);
			model.addAttribute("listOfSign", listOfSignOfApprovalWaited);
			model.addAttribute("paging", commonPaging);
		} 
		
		// 목록 가져오기 : 결제 처리 문서
		else if (listType.equals("approvalCompleted")) { 
			CommonPaging commonPaging = new CommonPaging(signService.countSignOfApprovalCompleted(sign), currentPage);
			sign.setRn_start(commonPaging.getStart());
			sign.setRn_end(commonPaging.getEnd());
			List<Sign> listOfSignOfApprovalCompleted = signService.listSignOfApprovalCompleted(sign);
			model.addAttribute("listOfSign", listOfSignOfApprovalCompleted);
			model.addAttribute("paging", commonPaging);
		}
	
		return "sign/signList";
	}

	// 전자결재문서 입력창
	@RequestMapping(value = "form", method = { RequestMethod.GET, RequestMethod.POST })
	public String form(String sgf_id, Model model, @AuthenticationPrincipal Member principal) {
		System.out.println("-- com.example.sproject.controller.SignController.form(int, Model)");
		// 세션 아이디 가져오기
		System.out.println("principal: " + principal);
		model.addAttribute("principal", principal);
		
		//입력 설정
		model.addAttribute("sgf_id", sgf_id);
		model.addAttribute("jspType", "w");
		
		// 멤버 목록 가져오기
		List<Member> listOfMember = signService.listMember();
		System.out.println("listOfMember.size(): "+ listOfMember.size());
		model.addAttribute("listOfMember", listOfMember);
		return "sign/form/" + sgf_id;
	}

	// 전자결재문서 내용 DB에 등록하기
	@RequestMapping(value = "insert", method = { RequestMethod.GET, RequestMethod.POST })
	public String insert(@RequestParam(value = "sgl_m_id") String[] listOfM_idOfSignLine, @RequestParam(value = "sgl_type") int[] listOfSgl_typeOfSignLine, String sgf_id, MultipartFile multipartFile, 
			HttpServletRequest req, @AuthenticationPrincipal Member principal, Model model) throws IOException, Exception {
		System.out.println("-- com.example.sproject.controller.SignController.insert(String, HttpServletRequest, Member, Model)");
		
		// 전자결재문서(SIGN 테이블) insert 하고 해당 sg_num 가져오기
		int sg_num = signService.getSg_numOfNewSign(principal.getM_id(), sgf_id);

		// 서버에 파일 업로드
		if (multipartFile.getSize() > 0) {
			String uploadPath = WebMvcConfig.RESOURCE_PATH + "/drive";
		    String dv_id = driveService.uploadFile(multipartFile.getOriginalFilename(), multipartFile.getBytes(), uploadPath);
		    
		    // DRIVE 테이블에 파일 정보 저장 
		    DriveFileInfo driveFile = new DriveFileInfo(dv_id, principal.getM_id(), multipartFile.getOriginalFilename(), null, GlobalsOfCg_num.DRIVE_SIGN);
		    driveService.insertDriveFileInfo(driveFile);
		    
			// req에 "dv_id" 추가 (테이블에 insert하기 위해)
			req.setAttribute("dv_id", dv_id);
		}

		// 전자결재문서내용(SIGN_CONTENT 테이블) insert
		signService.insertSignContents(sg_num, sgf_id, req);

		// 결재라인(SIGN_LINE) insert
		List<SignLine> listOfSignLine = signService.convertToListOfSignLine(sg_num, listOfM_idOfSignLine, listOfSgl_typeOfSignLine);
		signService.insertSignLines(listOfSignLine);
		
		return "redirect:/sign/view/" + sgf_id + "/" + sg_num;
	}
	
	// 전자결재문서 내용 읽기
	@RequestMapping(value = "view/{sgf_id:.+}/{sg_num:.+}", method = { RequestMethod.GET, RequestMethod.POST})
	public String view(@PathVariable("sg_num") int sg_num, @PathVariable("sgf_id") String sgf_id, @AuthenticationPrincipal Member principal, Model model) {
		System.out.println("start -- com.example.sproject.controller.SignController.view(int, String, Model)");
		
		// 세션 아이디 가져오기
		model.addAttribute("principal", principal);
		
		// jsp 타입 : 문서 읽기
		model.addAttribute("jspType", "r");
		
		// 전자결재문서 정보 가져오기
		Sign sign = signService.selectOneSign(sg_num);
		System.out.println("sign: " + sign);
		model.addAttribute("sign", sign);
		
		// 전자결재문서 입력내용들 Map형태로 가져오기
		Map<String, Object> mapOfSignContent = signService.findMapOfSignContent(sg_num);
		model.addAttribute("mapOfSignContent", mapOfSignContent);
		
		// 첨부파일명 가져오기
		if (mapOfSignContent.get("dv_id") != null && !((String) mapOfSignContent.get("dv_id")).equals("")) {
			model.addAttribute("dv_filename", driveService.selectOneDriveFileInfo(((String) mapOfSignContent.get("dv_id"))).getDv_filename());
		}
		
		// 전자결재문서 결재라인 정보 가져오기 
		List<SignLine> listOfSignLine = signService.findListOfSignLine(sg_num);
		model.addAttribute("listOfSignLine", listOfSignLine);
		

		return "sign/form/" + sgf_id;
	}
	
	// 전자결재문서 결재하기 (결재 혹은 반려)
	@PostMapping("approval")
	public String approval(int sg_num, @AuthenticationPrincipal Member principal, String sgf_id, @RequestParam int sgl_status) {
		System.out.println("-- com.example.sproject.controller.SignController.approval(int, Member, String)");
		// 객체 안에  결재할 번호와 ID값, 결재 상태 넣기
		SignLine signLine = new SignLine();
		signLine.setSg_num(sg_num);
		signLine.setM_id(principal.getM_id());
		signLine.setSgl_status(sgl_status);
		
		// 결재하기
		signService.approveSign(signLine);
		
		return "redirect:/sign/view/"+ sgf_id + "/" + sg_num;
	}
	
	// 전자결재양식 리스트 보내주기
	@RequestMapping(value = "api/getListOfSignForm", method = { RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> apiGetListOfSignForm() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 문서 양식 분류 항목 가져오기
		List<CommonGroup> listOfCommonGroup = commonService.listCommonGroup(GlobalsOfTb_code.SIGN_FORM);
		map.put("listOfCommonGroup", listOfCommonGroup);
		
		// 문서 양식 가져오기
		List<SignForm> listOfSignForm = signService.listSignForm();
		map.put("listOfSignForm", listOfSignForm);
		
		return map;
	}
	
	
	// 전자결재문서 삭제하기
	/**
	* 추가할 것 : 첨부파일 있으면 첨부파일도 삭제하기... ㅜ
	**/
}
