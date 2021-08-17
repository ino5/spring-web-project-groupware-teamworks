package com.example.sproject.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.main.MainDao;
import com.example.sproject.model.main.Main;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainDao mainDao;

	@Override
	public Main getMemberInfo(String m_id) {
		return mainDao.getMemberInfo(m_id) ;
	}

}
