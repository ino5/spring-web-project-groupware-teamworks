package com.example.sproject.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.board.PostDao;
import com.example.sproject.model.board.Post;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostDao pd;
	
	@Override
	public List<Post> listPost(Post post) {
	List<Post> postList = null;
	System.out.println("PostServiceImpl listPost Start...");
	postList =pd.listEmp(post);
		return postList;
	}

	@Override
	public int total() {
		System.out.println("PostServiceImpl Start total...");
		int totCnt = pd.total();
		System.out.println("PostServiceImpl total totCnt->"+totCnt);
		return totCnt;
	}

}
