package com.example.sproject.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.dao.sample.SampleDao;
import com.example.sproject.model.common.CommonGroup;
import com.example.sproject.model.globals.GlobalsOfTb_code;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.sample.Sample;
import com.example.sproject.service.common.CommonPaging;
import com.example.sproject.service.common.CommonService;
import com.example.sproject.service.login.LoginService;
import com.example.sproject.service.sample.EmailReader;
import com.example.sproject.service.sample.SampleService;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

import java.io.*;
import java.net.InetAddress;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Date;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.search.AndTerm;
import javax.mail.search.ComparisonTerm;
import javax.mail.search.ReceivedDateTerm;
import javax.mail.search.SearchTerm;

import com.sun.mail.smtp.*;

//import cn.easyproject.easyocr.EasyOCR;

@Controller
@RequestMapping("sample")
public class SampleController {
	@Value("${project-value.mailgun.api-key}")
	String API_KEY;
	@Value("${project-value.improvmx.smtp-password}")
	String SMTP_PASSWORD;
	String YOUR_DOMAIN_NAME = "teamworksgroupware.shop";
	
	@Autowired
	private SampleService sampleService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private SessionRegistry sessionRegistry;
	
	@Autowired
	private SampleDao sampleDao;
	
	@RequestMapping("")
	public String sample(Model model) {
		System.out.println("sample in Class SampleController");
		return "sample/sample";
	}
	
	@RequestMapping("main")
	public String sampleMain(Model model) {
		System.out.println("sampleMain in Class SampleController");
		return "sample/sampleMain";
	}
	
	@RequestMapping("list")
	public String sampleList(Model model) {
		System.out.println("Method sampleList in Class SampleController");
		List<Sample> sampleList = sampleService.listSample();
		model.addAttribute("sampleList", sampleList);
		return "sample/sampleList";
	}
	
	@RequestMapping("insert")
	public String sampleInsert(Sample sample, Model model) {
		System.out.println("Method sampleInsert in Class SampleController");
		sampleService.insertSample(sample);
		return "redirect:/sample/list";
	}
	
	@GetMapping("ajaxTest")
	public String ajaxTest (Model model) {
		return "sample/sampleAjax";
	}
	
	@PostMapping("ajaxTest")
	@ResponseBody
	public String ajaxTestPost(String data_content, Model model) {
		System.out.println("data_content: " + data_content);
		return "result value: test";
	}
	
	@PostMapping("upload")
	public String upload(Principal principal) throws Exception {
		System.out.println("upload method in SampleController Starts");
		System.out.println("principal.getName: " + principal.getName());
	    return "redirect:/drive";
	  }
	
	////
	//common_group 테스트 페이지
	////
	
	//특정 테이블 관련 그룹 리스트 가져오기
	//필요한 parameter: tb_code
	@RequestMapping(value = "test/cg", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cg(String tb_code, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		return commonService.listCommonGroup(tb_code);
	}

	//특정 테이블 관련 그룹에서 특정cg_ref에 대한 자식 그룹 리스트 가져오기
	//필요한 parameter: tb_code, cg_ref
	@RequestMapping(value = "test/cg2", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cg2(String tb_code, int cg_ref, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		return commonService.listCommonGroup(tb_code, cg_ref);
	}
	
	//특정 테이블 관련 그룹에서 특정cg_ref, 특정 depth에 대한 자식 그룹 리스트 가져오기 (cg_depth까지 지정)
	//필요한 parameter: tb_code, cg_ref, cg_depth
	@RequestMapping(value = "test/cg3", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cg3(String tb_code, int cg_ref, int cg_depth, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		return commonService.listCommonGroup(tb_code, cg_ref, cg_depth);
	}
	
	//자식 그룹 추가하기
	//필요한 parameter: tb_code, cg_name, parent_cg_num(부모 그룹의 cg_num)
	@RequestMapping(value = "test/cg/insert", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cgInsert(String tb_code, CommonGroup commonGroup, int parent_cg_num, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		commonService.addCommonGroup(tb_code, commonGroup, parent_cg_num);
		return commonService.listCommonGroup(tb_code);
	}
	
	//자식 그룹 삭제하기
	//필요한 parameter: tb_code, cg_num
	@RequestMapping(value = "test/cg/delete", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cgDelete(String tb_code, int cg_num, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		commonService.deleteCommonGroup(tb_code, cg_num);
		return commonService.listCommonGroup(tb_code);
	}
	
	//그룹명 변경하기
	@RequestMapping(value = "test/cg/update", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	//필요한 parameter: tb_code, cg_num, cg_name
	public List<CommonGroup> cgUpdate(String tb_code, int cg_num, String cg_name, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		commonService.updateCommonGroup(tb_code, cg_num, cg_name);
		return commonService.listCommonGroup(tb_code);
	}
	
	//그룹 1개 정보 가져오기
	//필요한 parameter: tb_code, cg_num
	@RequestMapping(value = "test/cg/selectOne", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public CommonGroup cgSelectOne(String tb_code, int cg_num, Model model) {
		if(tb_code == null) tb_code = GlobalsOfTb_code.POST;
		return commonService.selectOneCommonGroup(tb_code, cg_num);
	}
	
	
	
	
	//세션 유저 리스트 가져오기 테스트
	@RequestMapping(value = "test/sessionList", method = {RequestMethod.GET, RequestMethod.POST})
	public String sessionList(HttpServletRequest req, HttpSession session, Principal principal) {
		List<Object> list = sessionRegistry.getAllPrincipals();
		System.out.println(list);
		for (Object member : list ) {
			if(member instanceof Member) {
				System.out.println("Member");
				System.out.println(((Member) member).getM_id());
			}
			System.out.println(member.getClass());
			System.out.println("session");
			System.out.println(req.getSession().getId());
			System.out.println(session.getId());
		}
		return null;
	}
	
	//페이징 테스트
	@RequestMapping(value = "test/paging", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String testPaging(int total, Integer currentPage) {
		CommonPaging commonPaging = new CommonPaging(total, currentPage);
		System.out.println(commonPaging);
		return commonPaging.toString();
	}
	
	//회원 사진 테스트 페이지
	@RequestMapping(value = "test/memberPhoto/{m_id:.+}", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberPhoto(@PathVariable String m_id, Model model) {
		Member member = (Member) loginService.loadUserByUsername(m_id); // m_id로 멤버 정보 가져오기
		member.setM_password(null); // 비밀번호 정보 삭제하기
		model.addAttribute("member", member);
		return "sample/sampleMemberPhoto";
	}
	
	// 회원 사진 업데이트 페이지
	@RequestMapping(value = "test/memberPhoto/updateForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberPhotoInsertForm() {
		return "sample/sampleMemberPhotoUpdateForm";
	}
	
	// 회원 사진 업데이트 하기
	@RequestMapping(value = "test/memberPhoto/update", method= {RequestMethod.GET, RequestMethod.POST})
	public String memberPhotoUpdate(MultipartFile multipartFile, Principal principal) {
		
		loginService.updateMemberPhoto(principal.getName(), multipartFile);
		
		
		return "redirect:/sample/test/memberPhoto/" + principal.getName(); 
	}
	
	
	// 메일 보내기 테스트 (mailgun)
	@RequestMapping(value ="mail/send", method= {RequestMethod.GET, RequestMethod.POST})
	public String mailSend() throws UnirestException, MessagingException {
		System.out.println(API_KEY);
		System.out.println(SMTP_PASSWORD);
		sendMail();
//		System.out.println(sendSimpleMessage());
		return null;
	}
	
    public void sendMail() throws MessagingException {
        Properties props = System.getProperties();
        props.put("mail.smtps.host", "smtp.improvmx.com");
//        props.put("mail.smtps.host", "smtp.mailgun.org");
        props.put("mail.smtps.auth", "true");
        
        //임의설정
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true");
        
        
        Session session = Session.getInstance(props, null);
        Message msg = new MimeMessage(session);
//        msg.setFrom(new InternetAddress("postmasterasd@teamworksgroup.shop"));
        msg.setFrom(new InternetAddress("\"abc\" <postmasterasd@teamworksgroup.shop>"));

        InternetAddress[] addrs = InternetAddress.parse("chero77@naver.com lalala225257@gmail.com", false);
        msg.setRecipients(Message.RecipientType.TO, addrs);

        msg.setSubject("Hello");
        msg.setText("Testing some Mailgun awesomness");
        msg.setSentDate(new Date());

        SMTPTransport t = (SMTPTransport) session.getTransport("smtps");
        System.out.println("SMTP_PASSWORD: " + SMTP_PASSWORD);
        t.connect("smtp.improvmx.com", "postmaster@teamworksgroup.shop", SMTP_PASSWORD);
//        t.connect("smtp.mailgun.org", "postmaster@teamworksgroupware.shop", "df2bc287de015d79f37d3f8697fc4257-9776af14-e332c25c");
        t.sendMessage(msg, msg.getAllRecipients());

        System.out.println("Response: " + t.getLastServerResponse());

        t.close();
    }
    
    


    /**
     * pop3 서버이용에 필요한 계정정보
     * @throws MessagingException 
     * @throws ParseException 
     */
    @RequestMapping(value ="mail/read", method= {RequestMethod.GET, RequestMethod.POST})
    public String mailRead() throws MessagingException, ParseException {
    	System.out.println("mailRead");
        String userName = "ino210714@gmail.com";
        String password = "dprls896321!";
        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2021-07-14");
        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse("2021-08-15");
        String saveDirectory = "C:/mail";

        EmailReader receiver = new EmailReader();
        receiver.setSaveDirectory(saveDirectory);
        receiver.receiveMailAttachedFile(userName, password, startDate, endDate);
        
        return null;
    }
 
    @RequestMapping(value ="chat", method= {RequestMethod.GET, RequestMethod.POST})
    public String chat() {
    	return "sample/sampleChat";
    }
    
    
//    // OCR 테스트
//    @RequestMapping(value ="ocr/test", method= {RequestMethod.GET, RequestMethod.POST})
//    public String ocrTest(String path) {
//    	EasyOCR e=new EasyOCR();
////    	e.setTesseractOptions("-l kor");
//    	e.setTesseractPath("C:\\Users\\user\\Tesseract-OCR");
//    	System.out.println(e.discern("C:\\Users\\user\\Tesseract-OCR\\ocr_test.png"));     
//    	
////    	File file = new File(WebMvcConfig.RESOURCE_PATH + "/ocr" + "/ocr_test.png");
////    	System.out.println(file.length());
////    	System.out.println(e.discern(file));
//    	return null;
//    }
    
    
    @RequestMapping(value ="finalTest/insertForm", method= {RequestMethod.GET, RequestMethod.POST})
    public String finalTestInsertForm() {
    	return "sample/finalTestInsertForm";
    }    
    
    @RequestMapping(value ="finalTest/insert", method= {RequestMethod.GET, RequestMethod.POST})
    public String finalTestInsert(String name, String password, String message) {
    	sampleDao.insertFinalTest(name, password, message);
    	return "sample/finalTestInsertSuccess";
    }        
    
    @RequestMapping(value ="listTest")
    @ResponseBody
    public String listTest(Member listOfMember) {
    	System.out.println("--listTest");
    	for (Member member : listOfMember.getMembers()) {
    		System.out.println(member);
    	}
    	return "ok";
    }
    
    
}
