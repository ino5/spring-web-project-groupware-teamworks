package com.example.sproject.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfCg_num;
import com.example.sproject.model.globals.GlobalsOfMail;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailTo;
import com.example.sproject.service.drive.DriveService;
import com.example.sproject.service.mail.MailService;
import com.example.sproject.service.sample.EmailReader;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.sun.mail.smtp.SMTPTransport;

@Controller
@RequestMapping("mail")
public class MailController {
	
	static final String MAIL_DOMAIN = "@teamworksgroup.shop";
	
	@Autowired
	EmailReader emailReader;
	@Autowired
	MailService mailService;
	@Autowired
	DriveService driveService;
	
    /**
     * 메일 읽기
     * @throws MessagingException 
     * @throws ParseException 
     */
    @RequestMapping(value ="", method= {RequestMethod.GET, RequestMethod.POST})
    public String index(@AuthenticationPrincipal Member principal, Model model) throws MessagingException, ParseException {
    	mailService.updateMailDB();
    	
    	Mail mail = new Mail();
    	mail.setMl_type(1);
    	mail.setM_id(principal.getM_id());
    	mail.setRn_start(1);
    	mail.setRn_end(10);
    	List<Mail> listOfMail = mailService.listMail(mail);    	
    	for (Mail m : listOfMail) {
    		System.out.println(m);
    	}
    	mailService.replaceStringForHtml(listOfMail);
    	model.addAttribute("listOfMail", listOfMail);
    	
        return "mail/mailMain";
    }
    
    /**
     * 메일 내용 읽기
     * @param ml_num
     * @param principal
     * @param model
     * @return
     */
    @RequestMapping(value ="view/{ml_num:.+}", method= {RequestMethod.GET, RequestMethod.POST})
    public String view(@PathVariable int ml_num, @AuthenticationPrincipal Member principal, Model model ) {
    	// 메일 정보 가져오기
    	Mail mail = mailService.selectMail(ml_num);
    	mailService.replaceStringForHtml(mail);
    	model.addAttribute("mail", mail);
    	
    	// 받는 사람 목록 가져오기
    	List<MailTo> listOfMailTo = mailService.listMailTo(ml_num);
    	model.addAttribute("listOfMailTo", listOfMailTo);
    	
    	// 첨부파일 목록 가져오기
    	List<DriveFileInfo> listOfDriveFileInfo = mailService.listDriveFileInfo(ml_num);
    	model.addAttribute("listOfDriveFileInfo", listOfDriveFileInfo);
    	
    	// 메일 읽을 권한 있는지 체크
    	boolean isAuthorized = false;
    	for (MailTo mailTo : listOfMailTo) {
    		if (mailTo.getMl_email().equals(principal.getM_id() + "@" + GlobalsOfMail.MAIL_DOMAIN)) {
    			isAuthorized = true;
    			break;
    		}
    	}
    	if (!isAuthorized) {
    		return "login/denied";
    	}
    	
    	return "mail/mailView";
    }
    
    /**
     * 메일 작성 페이지 이동
     * @return
     */
    @RequestMapping(value ="writeForm", method= {RequestMethod.GET, RequestMethod.POST})
    public String writeForm() {
    	
    	return "mail/mailWriteForm";
    }
    
    
    
	/**
	 * 메일 보내기
	 * @return
	 * @throws Exception 
	 * @throws IOException 
	 */
	@RequestMapping(value ="send", method= {RequestMethod.POST})
	public String mailSend(Mail mail, String addressTo, @RequestParam("multipartFile") List<MultipartFile> listOfMultipartFile, @AuthenticationPrincipal Member principal, Model model) throws IOException, Exception {
		// 파일 서버에 올리고 db에 정보 등록하기
		List<DriveFileInfo> listOfDriveFileInfo = new ArrayList<DriveFileInfo>();
		for (MultipartFile multipartFile : listOfMultipartFile) {
			if (multipartFile.getSize() > 0) {
				// 파일 서버에 업로드
				String uploadPath = WebMvcConfig.RESOURCE_PATH + "/drive";
			    String dv_id = driveService.uploadFile(multipartFile.getOriginalFilename(), multipartFile.getBytes(), uploadPath);
			    
			    // DRIVE 테이블에 파일 정보 저장 
			    DriveFileInfo driveFile = new DriveFileInfo(dv_id, principal.getM_id(), multipartFile.getOriginalFilename(), null, GlobalsOfCg_num.DRIVE_SIGN);
			    driveService.insertDriveFileInfo(driveFile);
			    
				// 리스트에 추가
			    listOfDriveFileInfo.add(driveService.selectOneDriveFileInfo(dv_id));
			}			
		}
		
		// 메일 보내기
		mailService.sendMail(principal, mail, addressTo, listOfDriveFileInfo);
		
		// 메일 정보 db에 등록하기
		mailService.insertMailSent(mail);
		mailService.insertMailTo(mail.getMl_num(), addressTo);
		mailService.insertMailFile(mail.getMl_num(),listOfDriveFileInfo);

		return "redirect:/mail";
	}
	

    
    



    // 이메일 추출하기 테스트
    @RequestMapping(value="test", method= {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String test(String text) {
    	System.out.println("text: " + text);
    	Matcher matcher = Pattern.compile("\\<[^\\<\\>]+\\>").matcher(text);
    	String textMatched = new String();
    	if (matcher.find()) {
    		textMatched = text.substring(matcher.start()+1, matcher.end()-1);
    	} else {
    		textMatched = text;
    	}
    	return textMatched;
    }
}
