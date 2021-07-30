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
	//1대1 채팅방 가져오기
	public Room getRoomOfOneByOne(String m_id, String m_id2) {
		System.out.println("getRoomOfOneByOne");
		int roomNumber = 0;
		//DB에서 특정 두 멤버 간의 1대1 채팅방 번호 가져오기 
		roomNumber = talkDao.selectRnOfOneByOne(m_id, m_id2);
		System.out.println("before if, roomNumber: " + roomNumber);
			if(roomNumber > 0) { //DB에 해당 1대1 채팅방이 있다면 그대로 해당 방 리턴
				return talkDao.selectRoom(roomNumber);
			} else { //DB에 해당 1대1 채팅방이 없다면
				System.out.println("else");
				makeRoomOfOneByOne(m_id, m_id2); //1대1 채팅방 만들기
				return getRoomOfOneByOne(m_id, m_id2); //1대1 채팅방 가져오기
			}
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
