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
	@NonNull
	int sg_num;
	@NonNull
	String m_id;
	@NonNull
	String sgf_id;
	
	Timestamp sg_regdate;
}
