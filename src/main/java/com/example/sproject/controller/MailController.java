package com.example.sproject.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfMail;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailTo;
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
	
    /**
     * 메일 읽기
     * @throws MessagingException 
     * @throws ParseException 
     */
    @RequestMapping(value ="", method= {RequestMethod.GET, RequestMethod.POST})
    public String index(@AuthenticationPrincipal Member principal, Model model) throws MessagingException, ParseException {
    	mailService.updateMailDB();
    	
    	Mail mail = new Mail();
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
    	boolean is_authorized = false;
    	for (MailTo mailTo : listOfMailTo) {
    		if (mailTo.getMl_email().equals(principal.getM_id() + "@" + GlobalsOfMail.MAIL_DOMAIN)) {
    			is_authorized = true;
    			break;
    		}
    	}
    	if (!is_authorized) {
    		return "login/denied";
    	}
    	
    	return "mail/mailView";
    }
    
    
	// 메일 보내기 테스트 (mailgun)
	@RequestMapping(value ="send", method= {RequestMethod.GET, RequestMethod.POST})
	public String mailSend() throws UnirestException, MessagingException {
		System.out.println(GlobalsOfMail.API_KEY);
		System.out.println(GlobalsOfMail.SMTP_PASSWORD);
		mailService.sendMail();
//		System.out.println(sendSimpleMessage());
		return null;
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
