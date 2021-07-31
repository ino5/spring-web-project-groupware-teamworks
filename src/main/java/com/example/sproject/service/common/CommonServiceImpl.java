package com.example.sproject.service.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.common.CommonGroupDao;
import com.example.sproject.model.common.CommonGroup;

@Service
public class CommonServiceImpl implements CommonService {
	@Autowired
	CommonGroupDao commonGroupDao;
	
	@Override
	//특정 tb_code에 해당하는 CommonGroup들을 순서에 맞게 리스트 형태로 저장하는 메소드
	public List<CommonGroup> listCommonGroup(String tb_code) {
		List<CommonGroup> commonGroupList = commonGroupDao.selectList(tb_code);
		return commonGroupList;
	}

	@Override
	//tb_code, cg_ref, cg_depth를 가져와서 CommonGroup들을 리스트 형대로 가져오기
	public List<CommonGroup> listCommonGroup(String tb_code, int cg_ref, int cg_depth) {
		List<CommonGroup> commonGroupList = commonGroupDao.selectList(tb_code, cg_ref, cg_depth);
		return commonGroupList;
	}	
	
	@Override
	public int addCommonGroup(String tb_code, CommonGroup commonGroup, int parent_cg_num) {
		//tb_code 값 설정
		commonGroup.setTb_code(tb_code);
		
		//parent_cg_num 통해서 나머지 parent값 찾기
		commonGroup.setParent_cg_num(parent_cg_num);
		CommonGroup parentCommonGroup = commonGroupDao.selectOneParentCommonGroup(commonGroup);
		commonGroup.setParent_cg_ref(parentCommonGroup.getCg_ref());
		commonGroup.setParent_cg_order(parentCommonGroup.getCg_order());
		commonGroup.setParent_cg_depth(parentCommonGroup.getCg_depth());
		
		//cg_ref, cg_depth 값 설정
		commonGroup.setCg_ref(commonGroup.getParent_cg_ref());
		commonGroup.setCg_depth(commonGroup.getParent_cg_depth() + 1);
		
		//삽입될 cg_num 찾기
		int cg_num = commonGroupDao.selectOneMaxCg_num(tb_code) + 1;
		commonGroup.setCg_num(cg_num);
		
		//삽입될 cg_order 값 찾기
		int insertedCg_order = commonGroupDao.selectOneInsertedCg_order(commonGroup);
		if (insertedCg_order < 0) { //해당 ref에서 사이에 삽입되는 것이 아닌 제일 뒤에 삽입되는 경우
			insertedCg_order = commonGroupDao.selectOneMaxCg_order(commonGroup) + 1;
		}
		commonGroup.setCg_order(insertedCg_order);
		
		//기존 CommonGroup들 order 한칸씩 뒤로밀어버리기
		commonGroupDao.pushCg_order(commonGroup);
		
		//CommonGroup 삽입하기 전 null값 처리하기
		if(commonGroup.getCg_name() == null) commonGroup.setCg_name("");
		if(commonGroup.getCg_content() == null) commonGroup.setCg_content("");
		if(commonGroup.getM_id() == null) commonGroup.setM_id("");
		
		//CommonGroup 삽입하기
		return commonGroupDao.insertCommonGroup(commonGroup);
	}

	@Override
	public int deleteCommonGroup(String tb_code, int cg_num) {
		System.out.println("-- Mehthod deleteCommonGroup in Class CommonService");
		int result = 0;
		CommonGroup commonGroup = new CommonGroup();
		commonGroup.setTb_code(tb_code);
		commonGroup.setCg_num(cg_num);
		result = commonGroupDao.deleteCommonGroup(commonGroup);
		System.out.println("CommonGroup 삭제 결과: " + result);
		return result;
	}

	@Override
	public int updateCommonGroup(String tb_code, int cg_num, String cg_name) {
		System.out.println("-- Mehthod updateCommonGroup in Class CommonService");
		int result = 0;
		CommonGroup commonGroup = new CommonGroup();
		commonGroup.setTb_code(tb_code);
		commonGroup.setCg_num(cg_num);
		commonGroup.setCg_name(cg_name);
		result = commonGroupDao.updateCommonGroup(commonGroup);
		System.out.println("CommonGroup update 결과: " + result);
		return result;
	}

	@Override
	public CommonGroup selectOneCommonGroup(String tb_code, int cg_num) {
		CommonGroup commonGroup = new CommonGroup();
		commonGroup.setTb_code(tb_code);
		commonGroup.setCg_num(cg_num);
		return commonGroupDao.selectOneCommonGroup(commonGroup);
	}


	
}
