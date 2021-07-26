package com.example.sproject.model.board;

import java.util.Date;

import lombok.Data;

@Data
public class Post {

	private int p_num;
	private int bd_num;
	private String m_id;
	private String p_name;
	private String p_content;
	private String p_filename;
	private Date p_regdate;
	private int p_view;
	private int p_type;
	private int p_is_del;
	private String loginId;
	
	// 조회용
	private String search;		private String keyword;
	private String pageNum;
	private int start;			private int end; 

}
