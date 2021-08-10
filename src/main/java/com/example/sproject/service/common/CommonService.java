package com.example.sproject.service.common;

import java.util.List;

import com.example.sproject.model.common.CommonGroup;

public interface CommonService {
	List<CommonGroup> listCommonGroup(String tb_code);
	List<CommonGroup> listCommonGroup(String tb_code, int cg_ref, int cg_depth);
	int addCommonGroup(String tb_code, CommonGroup commonGroup, int parent_cg_num);
	int deleteCommonGroup(String tb_code, int cg_num);
	int updateCommonGroup(String tb_code, int cg_num, String cg_name);
	CommonGroup selectOneCommonGroup(String tb_code, int cg_num);
	List<CommonGroup> listCommonGroup(String tb_code, int cg_ref);
}
