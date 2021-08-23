package com.example.sproject.dao.mail;

import java.sql.Timestamp;
import java.util.List;

import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailFile;
import com.example.sproject.model.mail.MailTo;

public interface MailDao {

	int countMailReceived();

	int insertMail(Mail mail);

	int countMaxMl_num();

	int insertMailFile(MailFile mailFile);

	int insertMailTo(MailTo mailTo);

	List<Mail> selectListMailReceived(Mail mail);

	Mail selectMail(int ml_num);

	List<MailTo> selectListMailTo(int ml_num);

	List<DriveFileInfo> selectListDriveFileInofo(int ml_num);

	int insertAllMailTo(int ml_num, List<String> listOfAddressTo);

	int insertAllMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo);

	int countTotalMailReceived(Mail mail);

	int updateMailRead(int ml_num);

	int deleteMail(int ml_num);

	int countTotalMailSent(Mail mail);

	List<Mail> selectListMailSent(Mail mail);
	
	/**
	 * 메일 서버에서 불러온 시간 업데이트하기 (ml_num=1 일 때의 ml_rcvdate 갱신)
	 * @param nowTime
	 * @return
	 */
	int updateMl_rcvdate(Timestamp nowTime);

	Timestamp findUpdateDateOfDb();

}
