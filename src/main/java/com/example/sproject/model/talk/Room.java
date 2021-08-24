package com.example.sproject.model.talk;

import java.util.List;

import lombok.Data;

@Data
public class Room {
	//Room
	int tkrm_num;
	String tkrm_name;
	int tkrm_type;

	// toString : 객체가 가지고 있는 정보나 값들을 문자열로 만들어 리턴하는 메소드
	// toString() 메서드를 이용해서 출력값을 주소값에서 내가 원하는 값을 나타낼 수 있도록 바꿀 수 있음. 이렇게 주소값을 String형의 결과값으로 변환할수 있는 것이 toString()메서드의 역할

	//Talker
	String m_id;
	
	List<String> talkerList;
	
	int rnUnreadNum;
}
