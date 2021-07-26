package com.example.sproject.dao.common;

import java.util.List;

import com.example.sproject.model.common.CommonGroup;

public interface CommonGroupDao {
	List<CommonGroup> selectList(String tb_code);

	int selectOneInsertedCg_order(CommonGroup commonGroup);

	int selectOneMaxCg_order(CommonGroup commonGroup);

	int pushCg_order(CommonGroup commonGroup);

	int insertCommonGroup(CommonGroup commonGroup);

	int selectOneMaxCg_num(String tb_code);

	CommonGroup selectOneParentCommonGroup(CommonGroup commonGroup);
}
