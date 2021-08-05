package com.example.sproject.dao.talk;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;

public interface TalkDao {

	int insertMsg(Talk talk);

	int selectOneMaxTk_num();

	List<Talk> selectChat(int roomNumber);

	List<Member> selectMemberList(String m_id);

	int insertTalkRoomOneByOne();
	
	int selectRnOfOneByOne(String m_id, String m_id2);

	int insertTalker(int roomNumber, String m_id);

	Room selectRoom(int roomNumber);

	int selectMaxRn();

	List<Room> selectgetGroupRoomList(String m_id);


}
