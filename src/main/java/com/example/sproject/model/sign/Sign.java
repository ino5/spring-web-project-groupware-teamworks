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
	
	// SIGN_CONTENT 테이블에서의 Title
	String title;
	
	// DB 페이징처리 rownum
	int rn_start;
	int rn_end;
	
}
