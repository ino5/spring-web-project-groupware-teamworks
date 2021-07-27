package com.example.sproject.dao.talk;

import com.example.sproject.model.talk.Talk;

public interface TalkDao {

	int insertMsg(Talk talk);

	int selectOneMaxTk_num();

}
