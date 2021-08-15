package com.example.sproject.model.board;

import lombok.Data;

@Data
public class Reply {

	private int p_num;
	private int rp_num;
	private String m_id;
	private String m_name;
	private String pt_name;
	private String rp_content;
	private int rp_ref;
	private int rp_order;
	private int rp_depth;
	
	int parent_rp_ref;
	int parent_rp_num;
	int parent_rp_order;
	int parent_rp_depth;
	}

