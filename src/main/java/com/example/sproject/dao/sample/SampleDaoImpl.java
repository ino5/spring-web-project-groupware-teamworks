package com.example.sproject.dao.sample;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.sample.Sample;

@Repository
public class SampleDaoImpl implements SampleDao {
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Sample> selectSample() {
		return session.selectList("com.example.sproject.dao.sample.SampleDao.selectSample");
	}

	@Override
	public int insertSample(Sample sample) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sample", sample);
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("map", map);
		return session.insert("com.example.sproject.dao.sample.SampleDao.insertSample", map2);
	}

}
