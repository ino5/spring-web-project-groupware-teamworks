package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.board.Post;
import com.example.sproject.model.calendar.Calendar;
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfCg_num;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.main.Main;
import com.example.sproject.model.sign.Sign;
import com.example.sproject.model.time.Time;
import com.example.sproject.service.board.BoardService;
import com.example.sproject.service.board.Paging;
import com.example.sproject.service.calendar.CalendarService;
import com.example.sproject.service.common.CommonPaging;
import com.example.sproject.service.community.CommunityService;
import com.example.sproject.service.drive.DriveService;
import com.example.sproject.service.mail.MailService;
import com.example.sproject.service.main.MainService;
import com.example.sproject.service.sign.SignService;
import com.example.sproject.service.time.TimeService;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private TimeService timeService;
	
	@Autowired
	private CalendarService calendarService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private DriveService driveService;
	
	@Autowired
	private SignService signService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private CommunityService communityService;
	
	@RequestMapping(value = {"main",""})
	public String mainList(@AuthenticationPrincipal Member sessionMember, Model model, Main mainMember, Post post, String currentPage, Integer cg_num, Integer currentPage2) {
		
		String m_id = null;
		String m_name = null;
		if(sessionMember != null) {
			System.out.println("sessionMember: " + sessionMember);
			m_id = sessionMember.getM_id();
			m_name = sessionMember.getM_name();
			
		// 멤버정보
			mainMember = mainService.getMemberInfo(m_id);
			
		// 근태
			Time mainTime = timeService.mainTime(m_id);
			
		// 캘린더
			List<Calendar> calendarList = calendarService.calendarList(m_id);
			
		// 게시판
			if(currentPage == null || "".equals(currentPage)) {
				currentPage = "1";
			}
			int total = boardService.total();
			Paging pg = new Paging(total, currentPage);
			post.setStart(pg.getStart());
			post.setEnd(pg.getEnd());
			List<Post> listPost = boardService.listPost(post);
			
		// 드라이브
			//common_group 관련 처리
			if(cg_num == null) cg_num = GlobalsOfCg_num.DRIVE_ENTERPRISE;
			//자료실 목록 가져오기
			List<DriveFileInfo> driveFileInfoListOfEnterprise = driveService.selectListDriveFileInfo(cg_num, m_id);
			
		// 전자결재
			Sign sign = new Sign();
			sign.setM_id(m_id);
			sign.setRn_start(1);
			sign.setRn_end(Integer.MAX_VALUE);
			
			// 목록 가져오기 : 기안 진행 중 문서
			List<Sign> listOfSignOfProposalProcessing = signService.listSignOfProposalProcessing(sign);
			model.addAttribute("listOfSignOfProposalProcessing", listOfSignOfProposalProcessing);
			model.addAttribute("num_processing", listOfSignOfProposalProcessing.size());
			
			// 목록 가져오기 : 기안 완료 문서
			List<Sign> listOfSignOfProposalCompleted = signService.listSignOfProposalCompleted(sign);
			model.addAttribute("listOfSignOfProposalCompleted", listOfSignOfProposalCompleted);
			model.addAttribute("num_ProposalCompleted", listOfSignOfProposalCompleted.size());
			
			// 목록 가져오기 : 결재 대기 문서
			List<Sign> listOfSignOfApprovalWaited = signService.listSignOfApprovalWaited(sign);
			model.addAttribute("listOfSignOfApprovalWaited", listOfSignOfApprovalWaited);
			model.addAttribute("num_Waited", listOfSignOfApprovalWaited.size());
			
			// 목록 가져오기 : 결제 처리 문서
			List<Sign> listOfSignOfApprovalCompleted = signService.listSignOfApprovalCompleted(sign);
			model.addAttribute("listOfSignOfApprovalCompleted", listOfSignOfApprovalCompleted);
			model.addAttribute("num_ApprovalCompleted", listOfSignOfApprovalCompleted.size());
			
		// 메일
	    	
	    	// 메일 가져오기 위한 정보 세팅
	    	Mail mail = new Mail();
	    	mail.setMl_type(1);
	    	mail.setM_id(m_id);
	    	
	    	// 페이징 처리
	    	CommonPaging commonPaging = new CommonPaging(mailService.countTotalMailReceived(mail), currentPage2, 10, 5);
	    	System.out.println("commonPaging: " + commonPaging);
	    	model.addAttribute("commonPaging", commonPaging);
	    	mail.setRn_start(commonPaging.getStart());
	    	mail.setRn_end(commonPaging.getEnd());
	    	
	    	// 페이징 처리에 맞게 메일 가져오기
	    	List<Mail> listOfMail = mailService.listMailReceived(mail);    	
	    	mailService.replaceStringForHtml(listOfMail);
	    	
	    	// 커뮤니티
	    	//모든글
			post.setTarget_m_id(m_id);
			List<Post> listPost2 = communityService.listPost(post);
			
			model.addAttribute("m_id", m_id);
			model.addAttribute("m_name", m_name);
			model.addAttribute("mainMember", mainMember);
			model.addAttribute("pt_name", mainMember.getPt_name());
			model.addAttribute("m_birth", mainMember.getM_birth());
			model.addAttribute("mainTime", mainTime);
			model.addAttribute("calendarList", calendarList);
			model.addAttribute("pg",pg);
			model.addAttribute("listPost", listPost);
			model.addAttribute("listPost2", listPost2);
			model.addAttribute("driveFileInfoListOfEnterprise", driveFileInfoListOfEnterprise);
			model.addAttribute("listOfMail", listOfMail);
		}
		return "main/mainTest";
	}
	
	@RequestMapping(value="startTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void startTime(Principal principal, Time time) {
		System.out.println("TimeController Start startTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		timeService.startTime(time);
		
	}
	
	@RequestMapping(value="endTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void endTime(Principal principal, Time time) {
		System.out.println("TimeController Start endTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		timeService.endTime(time);
	}
	
}
