package com.example.sproject.model.globals;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Mail 관련 전역변수
 * @author ino5
 *
 */
@Component
public class GlobalsOfMail {
	public static final String MAIL_DOMAIN = "teamworksgroup.shop";
	public static final String MAIL_DOMAIN_FOR_MAILGUN = "teamworksgroupware.shop";
	public static String API_KEY;
	@Value("${project-value.mailgun.api-key}")	
	public void setAPI_KEY(String value) {
		API_KEY = value;
	}
	
	public static String SMTP_PASSWORD;
	@Value("${project-value.mailgun.smtp-password}")
	public void setSMTP_PASSWORD(String value) {
		SMTP_PASSWORD = value;
	}
		
	public static String MAIL_ID;
	@Value("${project-value.mail.id}")
	public void setMAIL_ID(String value) {
		MAIL_ID = value;
	}	

	public static String MAIL_PASSWORD;	
	@Value("${project-value.mail.password}")
	public void setMAIL_PASSWORD(String value) {
		MAIL_PASSWORD = value;
	}
}
