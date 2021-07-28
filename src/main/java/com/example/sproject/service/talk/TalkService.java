package com.example.sproject.service.talk;

import java.util.List;

import com.example.sproject.model.talk.Talk;

public interface TalkService {

	int insertMsg(Talk talk);

	List<Talk> selectChat(int roomNumber);

}
