package com.example.sproject.model.board;

import lombok.Data;

@Data
public class Reply {

	private int p_num;
	private int rp_num;
	private String m_id;
	private String rp_content;
	private int rp_ref;
	private int rp_order;
	private int rp_depth;
}
