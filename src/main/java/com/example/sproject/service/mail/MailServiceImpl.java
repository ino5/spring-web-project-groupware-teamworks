package com.example.sproject.service.mail;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.UUID;

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
import com.example.sproject.model.mail.Mail;
import com.example.sproject.model.mail.MailFile;
import com.example.sproject.model.mail.MailTo;
import com.example.sproject.service.drive.DriveService;
import com.sun.mail.smtp.SMTPTransport;

@Service
public class MailServiceImpl implements MailService {
	@Value("${project-value.mailgun.smtp-password}")
	String SMTP_PASSWORD;
	@Value("${project-value.mail.id}")
	String MAIL_ID;
	@Value("${project-value.mail.password}")
	String MAIL_PASSWORD;
	
	@Autowired
	MailDao mailDao;
	
	@Autowired
	DriveService driveService;

	@Override
	public int updateMailDB() {
		Properties props = System.getProperties();
        props.setProperty("mail.store.protocol", "imaps");
        try {
        	System.out.println("in try");
            Session session = Session.getDefaultInstance(props, null);
            Store store = session.getStore("imaps");
            store.connect("imap.gmail.com", MAIL_ID, MAIL_PASSWORD);
            
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
                            messageContent = part.getContent().toString();
                        	// 위에가 샘플 코드인데 MimeMultipart 객체를 가져와서 임시방편으로 아래처럼 해서 해결했다.
                        	System.out.println("part.getContent()");
                        	if(part.getContent() instanceof MimeMultipart) {
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
                } else if (contentType.contains("text/plain") || contentType.contains("text/html")) {
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
    public int sendMail() throws MessagingException {
        Properties props = System.getProperties();
        props.put("mail.smtps.host", "smtp.mailgun.org");
        props.put("mail.smtps.auth", "true");

        Session session = Session.getInstance(props, null);
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress("이름 <iin140@teamworksgroup.shop>"));

        InternetAddress[] addrs = InternetAddress.parse("iin141@teamworksgroup.shop", false);
        msg.setRecipients(Message.RecipientType.TO, addrs);

        msg.setSubject("Hello");
        msg.setText("Testing some Mailgun awesomness");
        msg.setSentDate(new Date());

        SMTPTransport t = (SMTPTransport) session.getTransport("smtps");
        t.connect("smtp.mailgun.org", "postmaster@teamworksgroupware.shop", SMTP_PASSWORD);
        t.sendMessage(msg, msg.getAllRecipients());

        System.out.println("Response: " + t.getLastServerResponse());

        t.close();
        
        //db 저장하기
        
        return 1;
    }	
}
