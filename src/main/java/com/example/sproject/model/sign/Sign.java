package com.example.sproject.model.sign;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@RequiredArgsConstructor
public class Sign {
	// SIGN 테이블
	@NonNull
	int sg_num;
	@NonNull
	String m_id;
	@NonNull
	String sgf_id;
	Timestamp sg_regdate;
	int sg_status;
	
	String m_name; // 기안자 이름 (테이블: member)
	String dpt_code; // 기안자 부서코드
	String dpt_name; // 기안자 부서명
	String pt_code; // 기안자 직위코드
	String pt_name; // 기안자 직위명 

	String sgf_name; // 문서양식 이름 (테이블: sign_form)
	String title; //  Title (테이블: sign_content)
	
	
	// DB 페이징처리 rownum
	int rn_start;
	int rn_end;
	
}
