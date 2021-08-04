package com.example.sproject.dao.drive;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.drive.DriveFileInfo;

@Repository
public class DriveDaoImpl implements DriveDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertDriveFileInfo(DriveFileInfo driveFile) {
		return session.insert("insertDriveFileOfDrive", driveFile);
	}

	@Override
	public DriveFileInfo selectOneDriveFileInfo(String dv_id) {
		return session.selectOne("selectOneDriveFileInfoOfDrive", dv_id);
	}

	@Override
	public List<DriveFileInfo> selectListDriveFileInfo(DriveFileInfo driveFileInfo) {
		return session.selectList("selectListDriveFileInfoOfDrive", driveFileInfo);
	}

	@Override
	public int deleteFileInfo(DriveFileInfo driveFileInfo) {
		return session.delete("deleteFileInfoOfDrive", driveFileInfo);
	}

}
