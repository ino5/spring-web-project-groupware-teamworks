package com.example.sproject.model.talk;

import lombok.Data;

@Data
public class Talk {
	private int tkrm_num;
	private int tk_num;
	private int tk_type;
	private String m_id;
	private String tk_content;
	private String tk_time_sent;
	private String tk_file_name;
}
