package com.example.sproject.service.drive;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.example.sproject.dao.drive.DriveDao;
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfCg_num;

@Service
public class DriveServiceImpl implements DriveService {
	@Autowired
	DriveDao driveDao;
	
	@Override
	//drive에 저장된 파일 리스트 출력
	public List<DriveFileInfo> selectListDriveFileInfo(int cg_num, String m_id) {
		DriveFileInfo driveFileInfo = new DriveFileInfo();
		driveFileInfo.setCg_num(cg_num);
		
		//전사자료실을 제외한 경우에만, WHERE 조건에 m_id를 추가할 수 있도록
		if(cg_num != GlobalsOfCg_num.DRIVE_ENTERPRISE) driveFileInfo.setM_id(m_id);
		
		List<DriveFileInfo> driveFileInfoList = driveDao.selectListDriveFileInfo(driveFileInfo);
		return driveFileInfoList;
	}
	
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
	public int insertDriveFileInfo(DriveFileInfo driveFileInfo) {
	    int result = driveDao.insertDriveFileInfo(driveFileInfo);
		return result;
	}

	@Override
	public DriveFileInfo selectOneDriveFileInfo(String dv_id) {
		DriveFileInfo driveFileInfo = driveDao.selectOneDriveFileInfo(dv_id);
		return driveFileInfo;
	}



	@Override
	public int deleteFile(String fileNameWithPath) {
		System.out.println("Method 'deleteFile' in Class 'DriveServiceImpl'");
		int result = 0;
		File file = new File(fileNameWithPath);
		if(file.exists()) {
			if(file.delete()) {
				result = 1;
			} else {
				result = 0;
			}
		}
		System.out.println("result of deleteFile: " + result);
		return result;
	}

	@Override
	public int deleteFileInfo(DriveFileInfo driveFileInfo) {
		int result = driveDao.deleteFileInfo(driveFileInfo);
		return result;
	}
	
}
