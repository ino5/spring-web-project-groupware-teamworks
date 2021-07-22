package com.example.sproject.dao.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.board.Post;

@Repository
public class PostDaoImpl implements PostDao {
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Post> listPost(Post post) {
		List<Post> postList = null;
		System.out.println("PostDaoImpl listpost Start...");
		System.out.println("before try");
		try {
			System.out.println("before selectList");
			postList = session.selectList("selectListPostOfBoard", post);
			System.out.println("postList.size() in PostDaoImpl: " + postList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl listpost Exception->"+e.getMessage());
		}
		return postList;
	}

	@Override
	public int total() {
		int tot = 0;
		System.out.println("PostDaoImpl Start total...");
		try {
			tot = session.selectOne("PostTotalOfBoard");
			System.out.println("PostDaoImpl Start total...");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl total Exception->"+e.getMessage());
		}
		return tot;
	}
	//게시글 작성
	@Override
    public int insert(Post post) {
       // return session.insert("PostInsertOfBoard", post);
		int tot = 0;
		System.out.println("PostDaoImpl Start insert...");
		try {
			tot = session.insert("PostInsertOfBoard1", post);
			System.out.println("PostDaoImpl Start insert...");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl insert Exception->"+e.getMessage());
		}
		return tot;
    }

}
