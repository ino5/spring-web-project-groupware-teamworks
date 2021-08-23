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
import com.example.sproject.model.talk.Talk_Reading;
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
	public List<Member> selectMemberList(String m_id) {
		return session.selectList("selectMemberListOfTalk", m_id);
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

	@Override
	public List<Room> selectgetGroupRoomList(String m_id) {
		return session.selectList("selectGroupRoomListOfTalk", m_id);
	}

	@Override
	public void insertTalkRoomGroup(String Total) {
		session.insert("insertMakeGroupRoomOfTalk", Total);
		return;
	}

	@Override
	public List<Member> selectJoinGroupMemberList(int tkrm_num) {
		return session.selectList("selectJoinGroupMemberListOfTalk", tkrm_num);
	}

	@Override
	public String selectTkrm_name(String m_id) {
		return session.selectOne("selectJoinMemberNameOfTalk", m_id);
	}

	@Override
	public void updateFileImage(String filePath) {
		session.update("updateFileImageOfTalk", filePath);		
	}

	@Override
	public List<String> selectgetGroupTalkerList(int tkrm_num) {
		return session.selectList("selectgetGroupTalkerListOfTalk", tkrm_num);
	}

	@Override
	public void insertReadMsg(Talk_Reading talk_Reading) {
		session.insert("talk_ReadingOfTalk", talk_Reading);	
	}

	@Override
	public void readMember(int roomNumber, String m_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomNumber", roomNumber);
		map.put("m_id", m_id);
		session.update("readMemberOfTalk", map);		
	}

	@Override
	public int readNumber(int roomNumber, int tk_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomNumber", roomNumber);
		map.put("tk_num", tk_num);
		return session.selectOne("readNumberOfTalk", map);
	}
}
