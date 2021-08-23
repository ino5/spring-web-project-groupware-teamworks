package com.example.sproject.service.talk;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.talk.TalkDao;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
import com.example.sproject.model.talk.Talk;
import com.example.sproject.model.talk.Talk_Reading;
@Service
public class TalkServiceImpl implements TalkService {

	@Autowired
	TalkDao talkDao;
	
	@Override
	public int insertMsg(Talk talk) {
		int tk_num = 1 + talkDao.selectOneMaxTk_num(talk.getTkrm_num());
		talk.setTk_num(tk_num);
		talkDao.insertMsg(talk);
		return tk_num;
	}

	@Override
	public List<Talk> selectChat(int roomNumber) {
		return talkDao.selectChat(roomNumber);
	}

	@Override
	public List<Member> selectMemberList(String m_id) {
		return talkDao.selectMemberList(m_id);
	}

	@Override
	public Room getRoomOfOneByOne(String m_id, String m_id2) {
		System.out.println("getRoomOfOneByOne");
		int roomNumber = 0;
		roomNumber = talkDao.selectRnOfOneByOne(m_id, m_id2);
		System.out.println("before if, roomNumber: " + roomNumber);
			if(roomNumber > 0) {
				return talkDao.selectRoom(roomNumber);
			} else {
				System.out.println("else");
				makeRoomOfOneByOne(m_id, m_id2);
				return getRoomOfOneByOne(m_id, m_id2);
			}
		
		//1대1방 있는지 확인
		//있으면 그 방 리턴
		//없으면 방만들고 그 방 리턴 (방에 대한 DB(TALK_ROOM)도 넣고, 참가자에 대한 DB도 넣고(TALKER)
	}

	@Override
	public int makeRoomOfOneByOne(String m_id, String m_id2) {
	
		String m_id1 = talkDao.selectTkrm_name(m_id);
		String m_id3 = talkDao.selectTkrm_name(m_id2);
		String tkrm_name = m_id3 + ", " + m_id1;
		talkDao.insertTalkRoomOneByOne(tkrm_name);
		int roomNumber = talkDao.selectMaxRn();
		talkDao.insertTalker(roomNumber, m_id);
		talkDao.insertTalker(roomNumber, m_id2);
		return 1;
	}

	@Override
	public List<Room> selectgetGroupRoomList(String m_id) {
		return talkDao.selectgetGroupRoomList(m_id);
	}

	@Override
	public Room getRoom(int tkrm_num) {
		return talkDao.selectRoom(tkrm_num);
	}

	@Override
	public Room MakeGroupGetRoom(List<String> groupList, String m_id) {		
		String tkrm_name = null;
		String Total = "";
		for(int i = 0; i < groupList.size(); i++) {
			tkrm_name = talkDao.selectTkrm_name(groupList.get(i));
			Total = tkrm_name + ", " + Total;
		} 
		Total = Total + talkDao.selectTkrm_name(m_id);
		talkDao.insertTalkRoomGroup(Total);
		int roomNumber = talkDao.selectMaxRn();
		talkDao.insertTalker(roomNumber, m_id);
		for(int i = 0; i < groupList.size(); i++) {
			talkDao.insertTalker(roomNumber, groupList.get(i));
		}
		return talkDao.selectRoom(roomNumber);
	}

	@Override
	public List<Member> selectJoinGroupMemberList(int tkrm_num) {
		return talkDao.selectJoinGroupMemberList(tkrm_num);
	}

	@Override
	public void updateFileImage(String filePath) {
		talkDao.updateFileImage(filePath);
	}

	@Override
	public List<String> selectgetGroupTalkerList(int tkrm_num) {
		return talkDao.selectgetGroupTalkerList(tkrm_num);
	}

	@Override
	public void insertReadMsg(int tk_num, Talk_Reading talk_Reading) {
		talk_Reading.setTk_num(tk_num);
		List<String> GroupTalkerList = talkDao.selectgetGroupTalkerList(talk_Reading.getTkrm_num());
		for (int i=0; i<GroupTalkerList.size(); i++) {
				talk_Reading.setM_id(GroupTalkerList.get(i));	
				talkDao.insertReadMsg(talk_Reading);
		}
	}

	@Override
	public void readMember(int roomNumber, String m_id) {
		talkDao.readMember(roomNumber, m_id);
		
	}

	@Override
	public List<Talk_Reading> unreadCount(int roomNumber) {
		return talkDao.unreadCount(roomNumber);
	}

}
