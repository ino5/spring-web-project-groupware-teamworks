package com.example.sproject.model.sign;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class SignLine {
	int sg_num;
	String m_id;
	int sgl_type;
	int sgl_status;
	int sgl_order;
	Timestamp sgl_regdate;
}
