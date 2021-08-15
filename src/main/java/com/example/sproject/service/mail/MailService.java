package com.example.sproject.service.mail;

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
	List<Mail> listMail(Mail mail);

	void replaceStringForHtml(List<Mail> listOfMail);
	void replaceStringForHtml(Mail mail);

	Mail selectMail(int ml_num);

	List<MailTo> listMailTo(int ml_num);

	List<DriveFileInfo> listDriveFileInfo(int ml_num);

	int insertMailSent(Mail mail);

	int insertMailTo(int ml_num, String addressTo);

	int insertMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo);
}
