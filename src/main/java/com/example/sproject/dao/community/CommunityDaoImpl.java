package com.example.sproject.dao.community;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;
import com.example.sproject.model.community.BoardMember;


@Repository
public class CommunityDaoImpl implements CommunityDao {
	@Autowired
	private SqlSession session;

	@Override
	public int total() {
		int tot = 0;
		System.out.println("CommunityDaoImpl Start total");
		try {
			tot = session.selectOne("PostTotalOfCommunity");
		} catch (Exception e) {
			e.getStackTrace();
		}
		return tot;
	}

	@Override
	public List<Post> listPost(Post post) {
		List<Post> postList = null;
		try {
			postList = session.selectList("selectListPostOfCommunity",post);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return postList;
	}

	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("CommunityDaoImpl boardList Start...");
		try {
			boardList = session.selectList("selectListBoardOfCommunity",board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}

	@Override
	public int insert(Post post) {
	int tot = 0;
	System.out.println("CommunityDaoImpl Start insert...");
	try {
		tot = session.insert("PostInsertOfCommunity",post);
		
	} catch (Exception e) {
		e.printStackTrace();
	
	}
		return tot;
	}

	@Override
	public void increase_p_view(int p_num) {

		System.out.println("CommunityDaoImpl Start increaseViewcnt...");
		session.update("PostincreaseViewcntOfCommunity", p_num);
		
	}

	@Override
	public Post read(int p_num) {
		Post post = null;
		System.out.println("CommunityDaoImpl Start read...");
		try {
			post = session.selectOne("PostReadOfCommunity", p_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("CommunityDaoImpl read Exception->" + e.getMessage());
		}
		return post;
	}

	@Override
	public int update(Post post) {
		System.out.println("CommunityDaoImpl Start delete...");
		int result = 0;
		try {
			result = session.update("PostUpdateOfCommunity",post);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("CommunityDaoImpl delete Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int delete(int p_num) {
		System.out.println("CommunityDaoImpl Start delete...");
		int result = 0;
		try {
			result = session.delete("PostDeleteOfCommunity",p_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("CommunityDaoImpl delete Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Reply> listReply(int p_num) {
		List<Reply> replyList = null;
		System.out.println("CommunityDaoImpl replyList Start...");
		try {
			replyList = session.selectList("ReplyListofCommunity",p_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}

	@Override
	public int selectOneMaxRp_num() {
		return session.selectOne("selectOneMaxRp_numOfCommunity");
	}

	@Override
	public int insert(Reply reply) {
		 int tot = 0;
		 System.out.println("CommunityDaoImpl Start replyinsert...");
			try {
				tot = session.insert("ReplyInsertOfCommunity", reply);
				System.out.println("CommunityDaoImpl Start replyinsert...");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("CommunityDaoImpl replyinsert Exception->" + e.getMessage());
			}
			return tot;
	}

	@Override
	public int reply_delete(int rp_num) {

		return session.delete("reply_deleteOfCommunity", rp_num);
	}

	@Override
	public Reply selectOneParentReply(Reply reply) {
		return session.selectOne("selectOneParentReplyOfCommunity", reply);
	}

	@Override
	public int selectOneMaxRp_num(int p_num) {
		return session.selectOne("selectOneMaxRp_numOfCommunity",p_num);
	}

	@Override
	public int selectOneInsertedRp_order(Reply reply) {
		return session.selectOne("selectOneInsertedRp_orderOfCommunity",reply);
	}

	@Override
	public int selectOneMaxRp_order(Reply reply) {
		return session.selectOne("selectOneMaxRp_orderOfCommunity", reply);
	}

	@Override
	public int pushRp_order(Reply reply) {
		return session.insert("pushRp_orderOfCommunity", reply);
		
	}

	@Override
	public int rereply_insert(Reply reply) {
		return session.insert("rereply_insertCommunity", reply);
	}

	@Override
	public int insertLike(PostLike postLike) {
		return session.insert("insertLikeOfCommunity", postLike);
	}

	@Override
	public int deleteLike(PostLike postLike) {	
		return session.delete("deleteLikeOfCommunity", postLike);
	}

	@Override
	public int checkLike(PostLike postLike) {	
		return session.selectOne("checkLikeOfCommunity", postLike);
	}

	@Override
	public List<Post> listNoticePost(int p_type) {
		return session.selectList("selectListNoticeOfCommunity",p_type);

	}

	@Override
	public void communityGroup(List<String> groupList, int bd_num) {
		for(int i = 0; i < groupList.size(); i++) {
			String p_num = groupList.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("p_num", Integer.parseInt(p_num));
			map.put("bd_num", bd_num);
			session.update("selectcommunityGroupOfCommunity", map);
		
	}
	}

	@Override
	public void communityDeleteGroup(List<String> groupList) {
		for(int i = 0; i < groupList.size(); i++) {
			String p_num = groupList.get(i);
			session.delete("CommunityDeleteGroupOfCommunity", Integer.parseInt(p_num));
		
	}
		
	}

	@Override
	public void communityNoticeGroup(List<String> groupList) {
		for(int i = 0; i < groupList.size(); i++) {
			String p_num = groupList.get(i);
			session.update("CommunityNoticeGroupOfCommunity", Integer.parseInt(p_num));
		
	}
	}

	@Override
	public int board_list_total(int bd_num) {
		int tot = 0;
		try {
			tot = session.selectOne("board_list_totalOfCommunity",bd_num);
		} catch (Exception e) {
			
		}
		return 0;
	}

	@Override
	public List<Post> board_list(Post post) {
	List<Post> board_list = null;
		
		try {
			board_list = session.selectList("selectBoard_ListCommunity",post);
			System.out.println("boardList"+ board_list);
		} catch (Exception e) {
			e.printStackTrace();
	
		}
		return board_list;
	}
	@Override
	public List<Board> listBoard(int bd_type) {
		return session.selectList("selectListTypedofCommunity", bd_type);
	}


	@Override
	public int insert(Board board) {
		int tot = 0;
		try {
			tot = session.insert("CommunityInsertOfCommunity",board);
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}
			return tot;
		}

	@Override
	public int insert(BoardMember boardMember) {
		int tot = 0;
		try {
			tot = session.insert("BoardMemberOfCommunity",boardMember);
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}
			return tot;
		}

	@Override
	public List<Board> getCommunitiesJoined(String m_id) {
		return session.selectList("getCommunitiesJoinedOfCommunity", m_id);
	}

	@Override
	public Board selectOneBoard(int bd_num) {
		return session.selectOne("selectOneBoardOfCommunity", bd_num);
	}

	@Override
	public List<BoardMember> list_board(BoardMember boardMember) {
		return session.selectList("selecList_BoardOfCommunity", boardMember);
	}

	@Override
	public List<BoardMember> list_board(int bd_num) {
		return session.selectList("selecList_BoardOfCommunity", bd_num);

	}

}





	
	
