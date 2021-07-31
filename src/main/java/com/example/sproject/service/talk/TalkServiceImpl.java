package com.example.sproject.service.talk;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.talk.TalkDao;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.talk.Room;
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

	@Override
	public List<Talk> selectChat(int roomNumber) {
		return talkDao.selectChat(roomNumber);
	}

	@Override
	public List<Member> selectMemberList() {
		return talkDao.selectMemberList();
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
		talkDao.insertTalkRoomOneByOne();
		int roomNumber = talkDao.selectMaxRn();
		talkDao.insertTalker(roomNumber, m_id);
		talkDao.insertTalker(roomNumber, m_id2);
		return 1;
	}
}
