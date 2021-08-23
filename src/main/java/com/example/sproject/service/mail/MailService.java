package com.example.sproject.service.mail;

import java.sql.Timestamp;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.stereotype.Service;

import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailTo;


public interface MailService {

	int updateMailDB();
	
	/**
	 * 메일 보내기
	 * @param m_id
	 * @param mail
	 * @param addressTo
	 * @return
	 * @throws MessagingException
	 */
	int sendMail(Member principal, Mail mail, String addressTo, List<DriveFileInfo> listOfDriveFileInfo) throws MessagingException;
	
	/**
	 * 텍스트에서 <> 안에 있는 email 주소 뽑아내기 
	 * @param text
	 * @return
	 */
	String extractEmailAddress(String text);

	/**
	 * 메일 목록 가져오기
	 * @param mail (rn_start, rn_end, m_id)
	 * @return
	 */
	List<Mail> listMailReceived(Mail mail);
	
	int countTotalMailReceived(Mail mail);

	void replaceStringForHtml(List list);
	void replaceStringForHtml(Mail mail);
	void replaceStringForHtml(MailTo mailTo);
	String replaceStringForHtml(String str);

	Mail selectMail(int ml_num);

	List<MailTo> listMailTo(int ml_num);

	List<DriveFileInfo> listDriveFileInfo(int ml_num);

	int insertMailSent(Mail mail);

	int insertMailTo(int ml_num, String addressTo);

	int insertMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo);

	int updateMailRead(int ml_num);

	int deleteMail(String m_id, List<Integer> listOfMl_num);
	
	String m_idToMl_emailForLike(String m_id);

	int countTotalMailSent(Mail mail);

	List<Mail> listMailSent(Mail mail);

	/**
	 * mail db 업데이트 시간 가져오기
	 * @return
	 */
	Timestamp findUpdateDateOfDb();
	
}
