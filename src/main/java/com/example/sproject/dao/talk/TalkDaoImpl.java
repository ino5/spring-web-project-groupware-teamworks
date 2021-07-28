package com.example.sproject.dao.talk;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.talk.Talk;
@Repository
public class TalkDaoImpl implements TalkDao {

	@Autowired
	SqlSession session;
	
	@Override
	public int insertMsg(Talk talk) {
		return session.insert("insertMsgOfTalk", talk);
	}

	@Override
	public int selectOneMaxTk_num() {
		return session.selectOne("selectOneMaxTk_numOfTalk");
	}

	@Override
	public List<Talk> selectChat(int roomNumber) {
		return session.selectList("selectChatOfTalk", roomNumber);
	}

}
