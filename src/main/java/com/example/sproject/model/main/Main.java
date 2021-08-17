package com.example.sproject.model.main;

import java.sql.Date;

import lombok.Data;

@Data
public class Main {
	// Member 테이블
	private String m_id;
	private String m_name;
	private String m_birth;
	private int    m_empnum;
	private String m_phone;
	private String m_email;
	private String m_photo;
	private String dpt_code;
	private String pt_code;
	private Date   m_lastdate;
	private int    m_status;
	
	// postion 테이블
	private String pt_name;
	private int    pt_order;

}
