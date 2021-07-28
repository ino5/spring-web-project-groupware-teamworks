package com.example.sproject.service.drive;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.example.sproject.dao.drive.DriveDao;
import com.example.sproject.model.drive.DriveFile;

@Service
public class DriveServiceImpl implements DriveService {
	@Autowired
	DriveDao driveDao;
	
	@Override
	public String uploadFile(String originalName, byte[] fileData, String uploadPath) throws Exception {
		System.out.println("start of uploadFile method in DriveServiceImpl");
		
		//dv_id 부여
		UUID uid = UUID.randomUUID();
		String dv_id = uid.toString();
	    System.out.println("dv_id: " + dv_id);
	    
	    // Directory 생성 
	    System.out.println("uploadPath->"+uploadPath);
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}
		
		// 서버에 파일 저장
	    File target = new File(uploadPath, dv_id);
	    FileCopyUtils.copy(fileData, target);
	    

	    
	    
	    return dv_id;
	}
	
	@Override
	// DB에 파일 정보 저장
	public int insertDriveFile(DriveFile driveFile) {
	    int result = driveDao.insertDriveFile(driveFile);
		return result;
	}
	
}
