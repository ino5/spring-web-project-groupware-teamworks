package com.example.sproject.model.talk;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Talk {
	private int tkrm_num;
	private int tk_num;
	private int tk_type;
	private String m_id;
	private String tk_content;
	private Timestamp tk_time_sent;
	private String tk_file_name;
}
