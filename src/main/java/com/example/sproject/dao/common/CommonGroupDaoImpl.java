package com.example.sproject.dao.common;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.common.CommonGroup;

@Repository
public class CommonGroupDaoImpl implements CommonGroupDao {
	@Autowired
	SqlSession session;
	
	@Override
	public List<CommonGroup> selectList(String tb_code) {
		return session.selectList("selectListOfCommonGroup", tb_code);
	}

	@Override
	public int selectOneInsertedCg_order(CommonGroup commonGroup) {
		return session.selectOne("selectOneInsertedCg_orderOfCommonGroup", commonGroup);
	}

	@Override
	public int selectOneMaxCg_order(CommonGroup commonGroup) {
		return session.selectOne("selectOneMaxCg_orderOfCommonGroup", commonGroup);
	}

	@Override
	public int pushCg_order(CommonGroup commonGroup) {
		return session.update("pushCg_orderOfCommonGroup", commonGroup);
	}

	@Override
	public int insertCommonGroup(CommonGroup commonGroup) {
		return session.insert("insertCommonGroupOfCommonGroup", commonGroup);
	}

	@Override
	public int selectOneMaxCg_num(String tb_code) {
		return session.selectOne("selectOneMaxCg_numOfCommonGroup", tb_code);
	}

	@Override
	public CommonGroup selectOneParentCommonGroup(CommonGroup commonGroup) {
		return session.selectOne("selectOneParentOfCommonGroup", commonGroup);
	}

}
