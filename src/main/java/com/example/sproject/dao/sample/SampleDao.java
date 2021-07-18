package com.example.sproject.dao.sample;

import java.util.List;

import com.example.sproject.model.sample.Sample;

public interface SampleDao {
	List<Sample> selectSample();
	int insertSample(Sample sample);
}
