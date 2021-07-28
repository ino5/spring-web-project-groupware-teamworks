package com.example.sproject.service.drive;

import com.example.sproject.model.drive.DriveFile;

public interface DriveService {
	String uploadFile(String originalName, byte[] fileData , String uploadPath) throws Exception;

	int insertDriveFile(DriveFile driveFile);
}
