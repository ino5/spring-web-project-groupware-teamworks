package com.example.sproject.service.community;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;
import com.example.sproject.model.community.BoardMember;





public interface CommunityService {


	int total();
	List<Post> listPost(Post post);
	List<Board> listBoard(Board board);
	int insert(Post post);
	void increase_p_view(int p_num, HttpSession session);
	Post read(int p_num);
	int update(Post post);
	int delete(int p_num);

	List<Reply> listReply(int p_num);

	int reply_delete(int rp_num);
	int rereply_insert(Reply reply, int p_num, int parent_rp_num);
	int reply_insert(Reply reply);
	void listPost(PostLike postLike);
	int checkLike(PostLike postLike);
	List<Post> listNoticePost(int i);
	void communityGroup(List<String> groupList, int bd_num);
	void communityDeleteGroup(List<String> groupList);
	void communityNoticeGroup(List<String> groupList);
	int board_list_total(int bd_num);
	List<Post> board_list(Post post);
	List<Board> listBoard(int i);
	void listSide(String m_id, Model model);
	List<Board> checkCommunitiesJoined(String m_id, List<Board> boardListOfCommunity);
	void listSide(String m_id, ModelAndView modelandview);
	int insert(Board board);
	int insert(BoardMember boardMember);
	Board findBoard(int bd_num);
	List<BoardMember> list_board(int bd_num);
	








	
}
