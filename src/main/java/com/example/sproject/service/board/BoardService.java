package com.example.sproject.service.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;


public interface BoardService {

	List<Post> listPost(Post post);
	int total();
	int insert(Post post);
	Post read(int p_num);
	void increase_p_view(int p_num, HttpSession session);
	int update(Post post);
	int delete(int p_num);
	List<Board> listBoard(Board board);
	List<Reply> listReply(int p_num);
	int insert(Reply reply);
	int reply_delete(int rp_num);
	int rereply_insert(Reply reply, int p_num, int parent_rp_num);
	List<Board> listBoard(int i);
	void like(PostLike postLike);
	int checkLike(PostLike postLike);
	int board_list_total(int bd_num);
	List<Post> board_list(Post post);
	List<Post> listNoticePost(int i);
	int listSide(Model model);
	int listSide(ModelAndView modelAndView);


	
}
