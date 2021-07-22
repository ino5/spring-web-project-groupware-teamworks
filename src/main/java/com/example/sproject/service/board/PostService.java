package com.example.sproject.service.board;

import java.util.List;

import com.example.sproject.model.board.Post;


public interface PostService {

	List<Post> listPost(Post post);
	int total();
	int insert(Post post);

}
