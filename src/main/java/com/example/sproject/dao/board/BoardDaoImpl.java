package com.example.sproject.dao.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;

@Repository
public class BoardDaoImpl implements BoardDao {
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
			System.out.println("PostDaoImpl listpost Exception->" + e.getMessage());
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
			System.out.println("PostDaoImpl total Exception->" + e.getMessage());
		}
		return tot;
	}

	// 게시글 작성
	@Override
	public int insert(Post post) {
		// return session.insert("PostInsertOfBoard", post);
		int tot = 0;
		System.out.println("PostDaoImpl Start insert...");
		try {
			tot = session.insert("PostInsertOfBoard", post);
			System.out.println("PostDaoImpl Start insert...");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl insert Exception->" + e.getMessage());
		}
		return tot;
	}

	@Override
	public Post read(int p_num) {
		Post post = null;
		System.out.println("PostDaoImpl Start read...");
		try {
			post = session.selectOne("PostReadOfBoard", p_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl read Exception->" + e.getMessage());
		}
		return post;
	}

	@Override
	public void increase_p_view(int p_num) {

		System.out.println("PostDaoImpl Start increaseViewcnt...");
		session.update("PostincreaseViewcntOfBoard", p_num);
	}

	@Override
	public int update(Post post) {
		System.out.println("PostDaoImpl Start update...");
		int result = 0;
		try {
			System.out.println("post: " + post.toString());
			System.out.println("m_id: " + post.getM_id());
			result = session.update("PostUpdateOfBoard",post);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl update Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public int delete(int p_num) {
		System.out.println("PostDaoImpl Start delete...");
		int result = 0;
		try {
			result = session.delete("PostDeleteOfBoard",p_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl delete Exception->"+e.getMessage());
		}
		return result;
	}
	
//	@Override
//	public int likeDelete(int p_num) {
//		//해당 스크랩 제거 추후  postLikeDao 생성후 수정하게
//		System.out.println("PostDaoImpl Start delete...");
//		int result = 0;
//		try {
//			result = session.delete("PostLikeDeleteOfBoard",p_num);
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("PostDaoImpl LikeDelete Exception->"+e.getMessage());
//		}
//		return result;
//	}

	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("PostDaoImpl boardList Start...");
		try {
			boardList = session.selectList("selectListBoardofBoard",board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}
	@Override
	public List<Reply> listReply(int p_num) {
		List<Reply> replyList = null;
		System.out.println("PostDaoImpl replyList Start...");
		try {
			replyList = session.selectList("ReplyListofBoard",p_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}

	@Override
	public int insert(Reply reply) {
	 int tot = 0;
	 System.out.println("PostDaoImpl Start replyinsert...");
		try {
			tot = session.insert("ReplyInsertOfBoard", reply);
			System.out.println("PostDaoImpl Start replyinsert...");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl replyinsert Exception->" + e.getMessage());
		}
		return tot;

	}

	@Override
	public int selectOneMaxRp_num() {
		return session.selectOne("selectOneMaxRp_num");
	}

	@Override
	public int reply_delete(int rp_num) {
		System.out.println("PostDaoImpl Start reply_delete...");
		int result = 0;
		try {
			result = session.delete("Reply_DeleteOfBoard",rp_num);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("PostDaoImpl reply_delete Exception->"+e.getMessage());
		}
		return result;
	}


	@Override
	public int pushRp_order(Reply reply) {
		return session.selectOne("selectpushRp_orderOfBoard",reply);
	}

	@Override
	public int rereply_insert(Reply reply) {
		return session.insert("insertRereplyOfBoard", reply);
	}

	@Override
	public int selectOneMaxRp_num(int p_num) {
		return session.selectOne("selectOneMaxRp_num",p_num);
	}

	@Override
	public int selectOneInsertedRp_order(Reply reply) {
		return session.insert("pushRp_orderOfBoard", reply);
	}

	@Override
	public Reply selectOneParentReply(Reply reply) {
		return session.selectOne("selectListParentOfBoard", reply);
	}

	@Override
	public int selectOneMaxRp_order(Reply reply) {
		return session.selectOne("selectOneMaxRp_orderOfBoard", reply);
	}

	@Override
	public List<Board> listBoard(int bd_type) {
	
		return session.selectList("selectListTypedofBoard",bd_type);
	}

	@Override
	public int checkLike(PostLike postLike) {

		return session.selectOne("checkLikeOfBoard", postLike);
	}

	@Override
	public int insertLike(PostLike postLike) {

		return session.insert("insertLikeOfBoard", postLike);
	}

	@Override
	public int deleteLike(PostLike postLike) {
		
		return session.delete("deleteLikeOfBoard", postLike);
	}

	}
	
	
