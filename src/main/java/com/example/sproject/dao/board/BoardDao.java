package com.example.sproject.dao.board;
import java.util.List;

import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.Reply;
import com.example.sproject.model.common.CommonGroup;

public interface BoardDao {
	List<Post>		listPost(Post post);
	int total();
	int insert(Post post);
    Post read(int p_num);
	void increase_p_view(int p_num);
	int update(Post post);
	int delete(int p_num);
	
	int likeDelete(int p_num);
	List<Board>		listBoard(Board board);
	List<Reply>      listReply(int p_num);
    int  insert(Reply reply);
	int selectOneMaxRp_num(int p_num);
	int reply_delete(int p_num);
	
	int selectOneInsertedRp_order(Reply reply);
	int selectOneMaxRp_order(Reply reply);
	int selectOneMaxRp_num();
	int pushRp_order(Reply reply);
	int rereply_insert(Reply reply);
	Reply selectOneParentReply(Reply reply);



}
