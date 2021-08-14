package com.example.sproject.dao.mail;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailFile;
import com.example.sproject.model.mail.MailTo;

@Repository
public class MailDaoImpl implements MailDao {
	@Autowired
	private SqlSession session;
	
	@Override
	public int countMailReceived() {
		return session.selectOne("countMailReceivedOfMail");
	}

	@Override
	public int insertMail(Mail mail) {
		return session.insert("insertMailOfMail", mail);
	}

	@Override
	public int countMaxMl_num() {
		return session.selectOne("countMaxMl_numOfMail");
	}

	@Override
	public int insertMailFile(MailFile mailFile) {
		return session.insert("insertMailFileOfMail", mailFile);
	}

	@Override
	public int insertMailTo(MailTo mailTo) {
		return session.insert("insertMailToOfMail", mailTo);
	}

}
