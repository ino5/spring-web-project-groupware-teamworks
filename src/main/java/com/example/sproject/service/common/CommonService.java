package com.example.sproject.service.common;

import java.util.List;

import com.example.sproject.model.common.CommonGroup;

public interface CommonService {
	List<CommonGroup> listCommonGroup(String tb_code);
	int addCommonGroup(String tb_code, CommonGroup commonGroup, int parent_cg_num);
}
