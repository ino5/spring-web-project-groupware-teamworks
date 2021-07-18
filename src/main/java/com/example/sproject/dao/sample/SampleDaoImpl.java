package com.example.sproject.dao.sample;

import java.util.List;

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
		return session.insert("com.example.sproject.dao.sample.SampleDao.insertSample",sample);
	}

}
