package com.example.sproject.model.drive;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class DriveFile {
	String dv_id;
	String m_id;
	String dv_filename;
	Timestamp dv_regdate;
	int cg_num;
}
