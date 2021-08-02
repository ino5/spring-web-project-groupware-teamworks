package com.example.sproject.dao.talk;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.model.talk.Talker;
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

	@Override
	public List<Member> selectMemberList() {
		return session.selectList("selectMemberListOfTalk");
	}

	@Override
	public int insertTalkRoomOneByOne() {
		return session.insert("insertTalkRoomOneByOneOfTalk");
	}

	@Override
	public int selectRnOfOneByOne(String m_id, String m_id2) {
		int roomNumber = 0;
		Map<String, Object> map = new HashMap<String, Object>();  
		map.put("m_id", m_id);
		map.put("m_id2", m_id2);
		Room room = session.selectOne("selectRnOfOneByOneOfTalk", map);
		if(room!= null) roomNumber = room.getTkrm_num();
		return roomNumber;
	}
	
	@Override
	public int insertTalker(int roomNumber, String m_id) {
		System.out.println("insertTalker");
		System.out.println("roomNumber: " + roomNumber);
		System.out.println("m_id: " + m_id);
		Talker talker = new Talker();
		talker.setTkrm_num(roomNumber);
		talker.setM_id(m_id);
		return session.insert("insertTalkerOfTalk", talker);
	}

	@Override
	public Room selectRoom(int roomNumber) {
		return session.selectOne("selectRoomOfTalk", roomNumber);
	}

	@Override
	public int selectMaxRn() {
		return session.selectOne("selectMaxRnOfTalk");
	}

}
