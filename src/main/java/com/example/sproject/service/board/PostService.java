package com.example.sproject.service.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.example.sproject.model.board.Post;


public interface PostService {

	List<Post> listPost(Post post);
	int total();
	int insert(Post post);
	Post read(int p_num);
	void increase_p_view(int p_num, HttpSession session);

}
