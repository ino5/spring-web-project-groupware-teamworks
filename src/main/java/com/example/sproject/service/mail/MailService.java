package com.example.sproject.service.mail;

import javax.mail.MessagingException;

import org.springframework.stereotype.Service;


public interface MailService {

	int updateMailDB();
	
	int sendMail() throws MessagingException;

}
