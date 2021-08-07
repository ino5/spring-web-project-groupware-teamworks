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
	
	//이름, 부서코드, 부서명, 직위코드, 직위명
	String m_name;
	String dpt_code;
	String dpt_name;
	String pt_code;
	String pt_name;
}
