package com.example.sproject.service.talk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.talk.TalkDao;
import com.example.sproject.model.talk.Talk;
@Service
public class TalkServiceImpl implements TalkService {

	@Autowired
	TalkDao talkDao;
	
	@Override
	public int insertMsg(Talk talk) {
		int tk_num = 1 + talkDao.selectOneMaxTk_num();
		talk.setTk_num(tk_num);
		return talkDao.insertMsg(talk);
	}

}
