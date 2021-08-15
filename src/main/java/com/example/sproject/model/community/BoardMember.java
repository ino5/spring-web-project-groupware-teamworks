package com.example.sproject.model.community;

import lombok.Data;

@Data
public class BoardMember {
	private int bd_num;
	private String m_id;
	private int cmm_type;
	private String administrator;
	private String m_name;
}
