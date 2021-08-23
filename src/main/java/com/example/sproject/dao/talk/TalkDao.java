package com.example.sproject.dao.talk;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.model.talk.Talk_Reading;

public interface TalkDao {

	int insertMsg(Talk talk);

	int selectOneMaxTk_num(int tkrm_num);

	List<Talk> selectChat(int roomNumber);

	List<Member> selectMemberList(String m_id);

	int insertTalkRoomOneByOne();
	
	int selectRnOfOneByOne(String m_id, String m_id2);

	int insertTalker(int roomNumber, String m_id);

	Room selectRoom(int roomNumber);

	int selectMaxRn();

	List<Room> selectgetGroupRoomList(String m_id);

	void insertTalkRoomGroup(String Total);

	List<Member> selectJoinGroupMemberList(int tkrm_num);

	String selectTkrm_name(String m_id);

	void updateFileImage(String filePath);

	List<String> selectgetGroupTalkerList(int tkrm_num);

	void insertReadMsg(Talk_Reading talk_Reading);

	void readMember(int roomNumber, String m_id);	

	List<Talk_Reading> selectTk_numList(int roomNumber);

	List<Talk_Reading> unreadCount(int roomNumber);



}
