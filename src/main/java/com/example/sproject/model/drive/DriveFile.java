package com.example.sproject.model.drive;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DriveFile {
	String dv_id;
	String m_id;
	String dv_filename;
	Timestamp dv_regdate;
	int cg_num;
}
