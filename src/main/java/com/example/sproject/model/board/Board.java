package com.example.sproject.model.board;

import lombok.Data;

@Data
public class Board {
 private int bd_num;
 private String bd_name;
 private String bd_content;
 private String m_id;
 private int bd_type;
 private int bd_is_anon;
 private int is_joined;
 private int cm_num;
 private String m_name;
 private String pt_name;
}
