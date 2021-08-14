package com.example.sproject.model.mail;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Mail {
	private int ml_num;
	private String ml_email;
	private int mlb_num;
	private String ml_title;
	private String ml_content;
	private Timestamp ml_regdate;
	private Timestamp ml_rcvdate;
	private Timestamp ml_deldate;
	private int ml_type; // 타입 -> 1: 받은 메일, 2: 보낸 메일
	
}
