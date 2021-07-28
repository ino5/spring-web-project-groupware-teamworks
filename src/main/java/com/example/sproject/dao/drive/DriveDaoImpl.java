package com.example.sproject.dao.drive;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.drive.DriveFile;

@Repository
public class DriveDaoImpl implements DriveDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int insertDriveFile(DriveFile driveFile) {
		return session.insert("insertDriveFileOfDrive", driveFile);
	}

}
