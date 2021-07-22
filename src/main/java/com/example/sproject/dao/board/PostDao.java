package com.example.sproject.dao.board;
import java.util.List;

import com.example.sproject.model.board.Post;

public interface PostDao {
	List<Post>		listPost(Post post);
	int total();
	int insert(Post post);
    Post read(int p_num);
	int increase_p_view(int p_num);
}
