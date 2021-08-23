package com.example.sproject.dao.mail;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Mail> selectListMailReceived(Mail mail) {
		return session.selectList("selectListMailReceivedOfMail", mail);
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

	@Override
	public int insertAllMailTo(int ml_num, List<String> listOfAddressTo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ml_num", ml_num);
		map.put("listOfAddressTo", listOfAddressTo);
		return session.insert("insertAllMailToOfMail", map);
	}

	@Override
	public int insertAllMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ml_num", ml_num);
		map.put("listOfDriveFileInfo", listOfDriveFileInfo);
		return session.insert("insertAllMailFileOfMail", map);
	}

	@Override
	public int countTotalMailReceived(Mail mail) {
		return session.selectOne("countTotalMailReceivedOfMail", mail);
	}

	@Override
	public int updateMailRead(int ml_num) {
		return session.update("updateMailReadOfMail", ml_num);
	}

	@Override
	public int deleteMail(int ml_num) {
		return session.update("deleteMailOfMail", ml_num);
	}

	@Override
	public int countTotalMailSent(Mail mail) {
		return session.selectOne("countTotalMailSentOfMail", mail);
	}

	@Override
	public List<Mail> selectListMailSent(Mail mail) {
		return session.selectList("selectListMailSentOfMail", mail);
	}

	@Override
	public int updateMl_rcvdate(Timestamp nowTime) {
		return session.update("updateMl_rcvdateOfMail", nowTime);
	}

	@Override
	public Timestamp findUpdateDateOfDb() {
		return session.selectOne("findUpdateDateOfDbOfMail");
	}

}
