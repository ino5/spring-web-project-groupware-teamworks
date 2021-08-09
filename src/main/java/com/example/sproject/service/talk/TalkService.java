package com.example.sproject.service.talk;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;

public interface TalkService {

	int insertMsg(Talk talk);

	List<Talk> selectChat(int roomNumber);

	List<Member> selectMemberList(String m_id);

	Room getRoomOfOneByOne(String m_id, String m_id2);
	
	int makeRoomOfOneByOne(String m_id, String m_id2);

	List<Room> selectgetGroupRoomList(String m_id);

	Room getRoom(int tkrm_num);

	Room MakeGroupGetRoom(List<String> groupList, String m_id);

	List<Member> selectJoinGroupMemberList(int tkrm_num);

	void updateFileImage(String filePath);

	
	
}

