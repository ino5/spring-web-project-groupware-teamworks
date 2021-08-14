package com.example.sproject.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.service.mail.MailService;
import com.example.sproject.service.sample.EmailReader;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.sun.mail.smtp.SMTPTransport;

@Controller
@RequestMapping("mail")
public class MailController {
	@Value("${project-value.mailgun.api-key}")
	String API_KEY;
	@Value("${project-value.mailgun.smtp-password}")
	String SMTP_PASSWORD;
	@Value("${project-value.mail.id}")
	String MAIL_ID;
	@Value("${project-value.mail.id}")
	String MAIL_PASSWORD;
	
	
	@Autowired
	EmailReader emailReader;
	
	@Autowired
	MailService mailService;
	
	@RequestMapping("")
	public String index(Model model) {
		return "index";
	}
	// 메일 보내기 테스트 (mailgun)
	@RequestMapping(value ="send", method= {RequestMethod.GET, RequestMethod.POST})
	public String mailSend() throws UnirestException, MessagingException {
		System.out.println(API_KEY);
		System.out.println(SMTP_PASSWORD);
		mailService.sendMail();
//		System.out.println(sendSimpleMessage());
		return null;
	}
	

    
    


    /**
     * pop3 서버이용에 필요한 계정정보
     * @throws MessagingException 
     * @throws ParseException 
     */
    @RequestMapping(value ="read", method= {RequestMethod.GET, RequestMethod.POST})
    public String mailRead() throws MessagingException, ParseException {
//    	System.out.println("mailRead");
//        String userName = "ino210714@gmail.com";
//        String password = "dprls896321!";
//        Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse("2021-08-13");
//        Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse("2021-08-15");
//        System.out.println("startDate: " + startDate);
//        System.out.println("endDate: " + endDate);
//        String saveDirectory = "C:/mail";
//
//        emailReader.setSaveDirectory(saveDirectory);
//        emailReader.receiveMailAttachedFile(userName, password, startDate, endDate);
        
    	mailService.updateMailDB();
    	
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
