package com.example.sproject.dao.mail;

import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailFile;
import com.example.sproject.model.mail.MailTo;

public interface MailDao {

	int countMailReceived();

	int insertMail(Mail mail);

	int countMaxMl_num();

	int insertMailFile(MailFile mailFile);

	int insertMailTo(MailTo mailTo);

}
