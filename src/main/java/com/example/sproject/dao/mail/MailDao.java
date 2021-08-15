package com.example.sproject.dao.mail;

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

	List<Mail> selectListMail(Mail mail);

	Mail selectMail(int ml_num);

	List<MailTo> selectListMailTo(int ml_num);

	List<DriveFileInfo> selectListDriveFileInofo(int ml_num);

	int insertAllMailTo(int ml_num, List<String> listOfAddressTo);

	int insertAllMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo);

}
