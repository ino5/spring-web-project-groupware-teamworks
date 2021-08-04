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
	//SIGN 테이블
	@NonNull
	int sg_num;
	@NonNull
	String m_id;
	@NonNull
	String sgf_id;
	
	//SIGN_CONTENT 테이블에서의 Title
	String title;
	
	Timestamp sg_regdate;
}
