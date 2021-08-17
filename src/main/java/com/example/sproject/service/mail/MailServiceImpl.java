package com.example.sproject.service.mail;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.search.AndTerm;
import javax.mail.search.ComparisonTerm;
import javax.mail.search.ReceivedDateTerm;
import javax.mail.search.SearchTerm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.dao.mail.MailDao;
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfMail;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailFile;
import com.example.sproject.model.mail.MailTo;
import com.example.sproject.service.drive.DriveService;
import com.sun.mail.smtp.SMTPTransport;

@Service
public class MailServiceImpl implements MailService {
	
	@Autowired
	MailDao mailDao;
	
	@Autowired
	DriveService driveService;
	
	/**
	 * 메일 업데이트하기 
	 */
	@Override
	public int updateMailDB() {
		Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
        	System.out.println("updateMailDB");
            Session session = Session.getDefaultInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.gmail.com", GlobalsOfMail.MAIL_ID, GlobalsOfMail.MAIL_PASSWORD);
            
            // 받은편지함을 INBOX 라고 한다.
            Folder inbox = store.getFolder("INBOX");
            inbox.open(Folder.READ_ONLY);

            // 받은 편지함에 있는 메일 모두 읽어오기
            Message[] arrayMessages = inbox.getMessages();
            
            
            
            // DB에서 받은 메일 갯수 가져오기
            int numberOfMailReceivedInDb = mailDao.countMailReceived();
            
            // 메일 1개씩 읽기
            for (int i = arrayMessages.length; i > numberOfMailReceivedInDb; i--) {
                Message msg = arrayMessages[i-1];
                Address[] fromAddress = msg.getFrom();
                Address[] toAddress = msg.getAllRecipients();
                // 메일 내용 변수에 담기
                String to = toAddress[0].toString();
                String from = fromAddress[0].toString();
                String subject = msg.getSubject();
                String sentDate = msg.getSentDate().toString();
                String receivedDate = msg.getReceivedDate().toString();
                String contentType = msg.getContentType();
                String messageContent = "";
                String attachFiles = "";

				// 첨부파일
                if (contentType.contains("multipart")) {
                    Multipart multiPart = (Multipart) msg.getContent();
                    System.out.println("multiPart.getCount(): " + multiPart.getCount());
                    int numberOfParts = multiPart.getCount();
                    for (int partCount = 0; partCount < numberOfParts; partCount++) {
                        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
                        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
                        	System.out.println("saveFile");
                            // 첨부파일 있을 경우 지정 폴더로 저장
                            String fileName = part.getFileName();
                            
                            
                    		UUID uid = UUID.randomUUID();
                    		String dv_id = uid.toString();
                            part.saveFile(WebMvcConfig.RESOURCE_PATH + "/drive/" + dv_id);
                            attachFiles += dv_id + ", ";
                            
                            // DB에 파일 정보 저장
                            DriveFileInfo driveFileInfo = new DriveFileInfo(dv_id, "", fileName, null, 88);
                            driveService.insertDriveFileInfo(driveFileInfo);
                            
                        } else {
                            // 메일 내용 저장
                        	if (part.getContentType().toLowerCase().contains("text/plain".toLowerCase()) || part.getContentType().toLowerCase().contains("text/html".toLowerCase())) {
                        		messageContent = part.getContent().toString();
                        	}
                            
                        	// MimeMultipart 객체에 대해 임시방편으로 아래와 같이 해결
                        	System.out.println("part.getContent()");
                        	System.out.println(part.getContentType());
                        	if(part.getContent() instanceof MimeMultipart) {
                        		System.out.println(((MimeMultipart) (part.getContent())).getBodyPart(0).getContentType());
                        		System.out.println(((MimeMultipart) (part.getContent())).getBodyPart(1).getContentType());
                            	System.out.println(((MimeMultipart) (part.getContent())).getBodyPart(0).getContent().toString());
                            	System.out.println(((MimeMultipart) (part.getContent())).getBodyPart(1).getContent().toString());
                                messageContent = ((MimeMultipart) (part.getContent())).getBodyPart(1).getContent().toString();                        		
                        	}
                        }
                    }
                    if (attachFiles.length() > 1) {
                        attachFiles = attachFiles.substring(0,
                                attachFiles.length() - 2);
                    }
                } else if (contentType.toLowerCase().contains("text/plain".toLowerCase()) || contentType.toLowerCase().contains("text/html".toLowerCase())) {
                    Object content = msg.getContent();
                    if (content != null) {
                        messageContent = content.toString();
                    }
                }

                // 읽어온 메일 콘솔창 출력
                System.out.println("Message #" + (i + 1) + ":");
                System.out.println("\t From: " + from);
                System.out.println("\t To: " + to);
                System.out.println("\t Subject: " + subject);
                System.out.println("\t Received: " + sentDate);
                System.out.println("\t Message: " + messageContent);
                System.out.println("\t Attachments: " + attachFiles);
                System.out.println("receivedDate: " + receivedDate);
                System.out.println("contentType: " + contentType);
                
                // DB에 mail 정보 저장
                Mail mail = new Mail();
                mail.setMl_num(1 + mailDao.countMaxMl_num());
                mail.setMl_type(1); // 받은 메일
                mail.setMl_email(from);
                mail.setMlb_num(0); // 메일함 번호 임시로 0
                mail.setMl_title(subject);
                mail.setMl_content(messageContent);
                mail.setMl_regdate(new Timestamp(msg.getSentDate().getTime()));
                mail.setMl_rcvdate(new Timestamp(msg.getReceivedDate().getTime()));
                mailDao.insertMail(mail);
                
                // 한 메일에 대한 각각의 첨부파일명 DB에 저장하기
                if(attachFiles != null && !attachFiles.equals("")) {
                    for(String attachFile : attachFiles.split(", ")) {
                    	System.out.println(attachFile);
                    	MailFile mailFile = new MailFile(mail.getMl_num(), attachFile);
                    	mailDao.insertMailFile(mailFile);
                    }
                }

                
                // 한 메일에 대한 각각의 받는사람 DB에 저장하기
                for(Address address : toAddress) {
                	System.out.println(address.toString());
                	MailTo mailTo = new MailTo(mail.getMl_num(), address.toString());
                	mailDao.insertMailTo(mailTo);
                }
                
            }

            // disconnect
            inbox.close(false);
            store.close();

        } catch (NoSuchProviderException e) {
            e.printStackTrace();
            System.exit(1);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.exit(2);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
		return 0;
	}
	
	// 메일보내기
    public int sendMail(Member principal, Mail mail, String addressTo, List<DriveFileInfo> listOfDriveFileInfo) throws MessagingException {
        Properties props = System.getProperties();
        props.put("mail.smtps.host", "smtp.mailgun.org");
        props.put("mail.smtps.auth", "true");

        Session session = Session.getInstance(props, null);
        Message msg = new MimeMessage(session);
        String ml_email = principal.getM_name() + "<" + principal.getM_id() + "@" + GlobalsOfMail.MAIL_DOMAIN + ">";
        msg.setFrom(new InternetAddress(ml_email));
        InternetAddress[] addrs = InternetAddress.parse(addressTo, false);
        msg.setRecipients(Message.RecipientType.TO, addrs);
//        msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(messageCCTo, parseStrict));
        msg.setSubject(mail.getMl_title());
        
        msg.setSentDate(new Date());
        
        Multipart multipart = new MimeMultipart();
        
        // 내용 첨부
        MimeBodyPart bodypart = new MimeBodyPart();
        bodypart.setContent(mail.getMl_content(), "text/html; charset=utf-8");
        multipart.addBodyPart(bodypart);    
        
        // 파일 첨부
        if (listOfDriveFileInfo != null && listOfDriveFileInfo.size() > 0 ) {
        	for (DriveFileInfo driveFileInfo : listOfDriveFileInfo) {
        		MimeBodyPart attachPart = new MimeBodyPart();
        		attachPart.setDataHandler(new DataHandler(new FileDataSource(new File(WebMvcConfig.RESOURCE_PATH + "/drive/" + driveFileInfo.getDv_id()))));
        		attachPart.setFileName(driveFileInfo.getDv_filename());
        		multipart.addBodyPart(attachPart);
        	}
        }

        // setContent
        msg.setContent(multipart);

        
        // 메일 보내기
        SMTPTransport t = (SMTPTransport) session.getTransport("smtps");
        t.connect("smtp.mailgun.org", "postmaster@" + GlobalsOfMail.MAIL_DOMAIN_FOR_MAILGUN, GlobalsOfMail.SMTP_PASSWORD);
        t.sendMessage(msg, msg.getAllRecipients());
        System.out.println("Response: " + t.getLastServerResponse());
        t.close();

        // mail 객체 안에 데이터 넣기
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        mail.setMl_regdate(Timestamp.valueOf(simpleDateFormat.format(msg.getSentDate()))); 
        mail.setMl_email(ml_email);
        
        return 1;
    }

	@Override
	public String extractEmailAddress(String text) {
    	Matcher matcher = Pattern.compile("\\<[^\\<\\>]+\\>").matcher(text);
    	String textMatched = new String();
    	if (matcher.find()) {
    		textMatched = text.substring(matcher.start()+1, matcher.end()-1);
    	} else {
    		textMatched = text;
    	}
    	return textMatched;
	}

	@Override
	public List<Mail> listMail(Mail mail) {
		mail.setMl_email('%' + mail.getM_id()+ '@' + GlobalsOfMail.MAIL_DOMAIN + '%');
		return mailDao.selectListMail(mail);
	}

	@Override
	public void replaceStringForHtml(List list) {
		for (Object item : list) {
			if (item instanceof Mail) {
				replaceStringForHtml((Mail) item);
			}		
			if (item instanceof MailTo) {
				replaceStringForHtml((MailTo) item);
			}
		}
	}

	@Override
	public void replaceStringForHtml(Mail mail) {
		mail.setMl_email(replaceStringForHtml(mail.getMl_email()));
	}

	@Override
	public void replaceStringForHtml(MailTo mailTo) {
		mailTo.setMl_email(replaceStringForHtml(mailTo.getMl_email()));
	}
	
	@Override
	public String replaceStringForHtml(String str) {
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		return str;
	}	
	
	
	@Override
	public Mail selectMail(int ml_num) {
		return mailDao.selectMail(ml_num);
	}

	@Override
	public List<MailTo> listMailTo(int ml_num) {
		return mailDao.selectListMailTo(ml_num);
	}

	@Override
	public List<DriveFileInfo> listDriveFileInfo(int ml_num) {
		return mailDao.selectListDriveFileInofo(ml_num);
	}

	@Override
	public int insertMailSent(Mail mail) {
		if (mail.getMl_title() == null) mail.setMl_title("");
		if (mail.getMl_content() == null) mail.setMl_content("");
		mail.setMlb_num(0); // 메일함 임시로 값 할당
		mail.setMl_type(2);
		mail.setMl_num(1 + mailDao.countMaxMl_num());
		return mailDao.insertMail(mail);
	}

	@Override
	public int insertMailTo(int ml_num, String addressTo) {
		String[] arrayOfAddressTo = addressTo.split(" ");
		List<String> listOfAddressTo = new ArrayList<String>();
		for(String str : arrayOfAddressTo) {
			listOfAddressTo.add(str);
		}
		return mailDao.insertAllMailTo(ml_num, listOfAddressTo);
	}

	@Override
	public int insertMailFile(int ml_num, List<DriveFileInfo> listOfDriveFileInfo) {
		return mailDao.insertAllMailFile(ml_num, listOfDriveFileInfo);
	}

	@Override
	public int countTotalMail(Mail mail) {
		mail.setMl_email('%' + mail.getM_id()+ '@' + GlobalsOfMail.MAIL_DOMAIN + '%');
		return mailDao.countTotalMail(mail);
	}

	@Override
	public int updateMailRead(int ml_num) {
		return mailDao.updateMailRead(ml_num);
	}


}
