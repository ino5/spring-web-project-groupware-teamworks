package com.example.sproject.model.common;

import lombok.Data;

@Data
public class CommonGroup {
	//COMMON_GROUP 테이블 칼럼
	String tb_code;
	int cg_num;
	String cg_name;
	String cg_content;
	String m_id;
	int cg_ref;
	int cg_order;
	int cg_depth;
	
	//group 추가 시 저장할 부모 group 정보
	int parent_cg_num;
	int parent_cg_ref;
	int parent_cg_order;
	int parent_cg_depth;
}
