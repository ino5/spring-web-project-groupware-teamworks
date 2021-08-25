package com.example.sproject.service.sample;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.sample.SampleDao;
import com.example.sproject.model.sample.Sample;

@Service
public class SampleServiceImpl implements SampleService {

	@Autowired
	private SampleDao sampleDao;
	
	@Override
	public List<Sample> listSample() {
		System.out.println("Method listSample in Class SampleServiceImpl");
		List<Sample> sampleList = sampleDao.selectSample();
		for(Sample sample : sampleList) {
//			System.out.println("sample: "+ sample.getNum() + " " + sample.getName() + " " + (sample.getNum() == 0) + " " + (sample.getName() == null) + " " + ("".equals(sample.getName())));
		}
		return sampleList;
	}

	@Override
	public int insertSample(Sample sample) {
		System.out.println("Method insertSample in Class SampleServiceImpl");
		int result = sampleDao.insertSample(sample);
		System.out.println("result: "+ result);
		return result;
	}
	
}
