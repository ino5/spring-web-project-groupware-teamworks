package com.example.sproject.service.sample;

import java.util.List;

import com.example.sproject.model.sample.Sample;

public interface SampleService {
	List<Sample> listSample();
	int insertSample(Sample sample);
}
