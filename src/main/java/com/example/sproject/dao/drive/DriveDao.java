package com.example.sproject.dao.drive;

import java.util.List;

import com.example.sproject.model.drive.DriveFileInfo;

public interface DriveDao {

	int insertDriveFileInfo(DriveFileInfo driveFile);

	DriveFileInfo selectOneDriveFileInfo(String dv_id);

	List<DriveFileInfo> selectListDriveFileInfo(DriveFileInfo driveFileInfo);

	int deleteFileInfo(DriveFileInfo driveFileInfo);

}
