package com.example.sproject.model.talk;

import lombok.Data;

@Data
public class Room {
	int roomNumber;
	String roomName;

	@Override
	public String toString() {
		return "Room [roomNumber=" + roomNumber + ", roomName=" + "]";
	}
	
}
