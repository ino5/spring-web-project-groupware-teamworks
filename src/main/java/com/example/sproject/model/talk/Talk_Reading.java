package com.example.sproject.model.talk;

import lombok.Data;

@Data
public class Talk_Reading {
	
	private int tkrm_num;
	private int tk_num;
	private String m_id;
	private int tkrd_is_read;
	
	// 읽음 카운트
	private int unread_num;
}
