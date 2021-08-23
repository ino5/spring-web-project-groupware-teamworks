package com.example.sproject.service.talk;

import java.util.List;

import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.model.talk.Talk_Reading;

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

	List<String> selectgetGroupTalkerList(int tkrm_num);

	void insertReadMsg(int tk_num, Talk_Reading talk_Reading);
	
	/**
	 * 해당 방번호와 해당 아이디에 대한 모든 TALK_READING의 데이터에서 읽은 여부(tkrd_is_read)를 1로 만들기
	 * @param roomNumber
	 * @param m_id
	 */
	void readMember(int roomNumber, String m_id);

	List<Talk_Reading> unreadCount(int roomNumber);

	int selectAllUnreadCount(String m_id);

	List<String> selectRnUnreadNum(int tkrm_num, String m_id);
	
	
}

