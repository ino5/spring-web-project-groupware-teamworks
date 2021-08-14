package com.example.sproject.dao.mail;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.drive.DriveFileInfo;
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

	@Override
	public List<Mail> selectListMail(Mail mail) {
		return session.selectList("selectListMailOfMail", mail);
	}

	@Override
	public Mail selectMail(int ml_num) {
		return session.selectOne("selectMailOfMail", ml_num);
	}

	@Override
	public List<MailTo> selectListMailTo(int ml_num) {
		return session.selectList("selectListMailToOfMail", ml_num);
	}

	@Override
	public List<DriveFileInfo> selectListDriveFileInofo(int ml_num) {
		return session.selectList("selectListDriveFileInofoOfMail", ml_num);
	}

}
