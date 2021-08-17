package com.example.sproject.dao.community;
import java.util.List;
import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;
import com.example.sproject.model.community.BoardMember;


public interface CommunityDao {

	int total();
	List<Post> listPost(Post post);
	List<Board> listBoard(Board board);
	int insert(Post post);
	void increase_p_view(int p_num);
	Post read(int p_num);
	int update(Post post);
	int delete(int p_num);
	List<Reply> listReply(int p_num);
	int selectOneMaxRp_num();
	int insert(Reply reply);
	int reply_delete(int rp_num);
	Reply selectOneParentReply(Reply reply);
	int selectOneMaxRp_num(int p_num);
	int selectOneInsertedRp_order(Reply reply);
	int selectOneMaxRp_order(Reply reply);
	int pushRp_order(Reply reply);
	int rereply_insert(Reply reply);
	int insertLike(PostLike postLike);
	int deleteLike(PostLike postLike);
	int checkLike(PostLike postLike);
	List<Post> listNoticePost(int p_type);
	void communityGroup(List<String> groupList, int bd_num);
	void communityDeleteGroup(List<String> groupList);
	void communityNoticeGroup(List<String> groupList);
	int board_list_total(int bd_num);
	List<Post> board_list(Post post);
	List<Board> listBoard(int bd_type);
	int insert(Board board);
	int insert(BoardMember boardMember);
	List<Board> getCommunitiesJoined(String m_id);
	Board selectOneBoard(int bd_num);
	List<BoardMember> list_board(BoardMember boardMember);
	List<BoardMember> list_board(int bd_num);
	List<BoardMember> list_community(int bd_num);
	int postLike_delete(int p_num);
	int post_replydelete(int p_num);
	



}
