package com.example.sproject.service.drive;

import java.util.List;

import com.example.sproject.model.drive.DriveFileInfo;

public interface DriveService {
	String uploadFile(String originalName, byte[] fileData , String uploadPath) throws Exception;

	int insertDriveFileInfo(DriveFileInfo driveFileInfo);
	DriveFileInfo selectOneDriveFileInfo(String dv_id);

	List<DriveFileInfo> selectListDriveFileInfo(int cg_num, String m_id);

	int deleteFile(String fileNameWithPath);

	int deleteFileInfo(DriveFileInfo driveFileInfo);
}
