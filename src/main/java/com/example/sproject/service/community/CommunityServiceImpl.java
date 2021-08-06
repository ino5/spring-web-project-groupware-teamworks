package com.example.sproject.service.community;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.dao.board.BoardDao;
import com.example.sproject.dao.community.CommunityDao;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;
import com.example.sproject.model.community.BoardMember;
import com.example.sproject.model.board.Board;


@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao communityDao;

	@Override
	public int total() {
		System.out.println("CommunityServiceImpl Start total...");
		int totCnt = communityDao.total();
		System.out.println("CommunityServiceImpl total totCnt -> "+totCnt);
		return totCnt;
	}
	@Override
	public List<Post> listPost(Post post) {
		List<Post> postList = null;
		System.out.println("CommunityServiceImpl Start listPost...");
		postList = communityDao.listPost(post);
		return postList;
	}
	@Override
	public List<Board> listBoard(Board board) {
		List<Board> boardList = null;
		System.out.println("CommunityServiceImpl Start listBoard");
		boardList = communityDao.listBoard(board);
		return boardList;
	}
	@Override
	public int insert(Post post) {
		System.out.println("CommunityServiceImpl Start insert");
		String m_id =post.getM_id();
		String p_name = post.getP_name();
        String p_content = post.getP_content();
        // *태그문자 처리 (< ==> &lt; > ==> &gt;)
        // replace(A, B) A를 B로 변경
        p_name = p_name.replace("<", "&lt;");
        p_name = p_name.replace("<", "&gt;");
        m_id = m_id.replace("<", "&lt;");
        m_id = m_id.replace("<", "&gt;");
        // *공백문자 처리
        p_name = p_name.replace("  ",    "&nbsp;&nbsp;");
        m_id = m_id.replace("  ",    "&nbsp;&nbsp;");
        // *줄바꿈 문자처리
        p_content = p_content.replace("\n", "<br>");
        post.setM_id(m_id);
        post.setP_name(p_name);
        post.setP_content(p_content);
        
        return communityDao.insert(post);
		
	}
	@Override
	public void increase_p_view(int p_num, HttpSession session) {
		long update_time = 0;
        if(session.getAttribute("update_time_"+p_num) != null){
                                // 세션에서 읽어오기
            update_time = (long)session.getAttribute("update_time_"+p_num);
        }
    
        long current_time = System.currentTimeMillis();
    
        System.out.println("current_time - update_time: " + (current_time - update_time));
        if(current_time - update_time > 24*60*60*1000){
        	//조회수를 증가시키는 로직
        	communityDao.increase_p_view(p_num);
            session.setAttribute("update_time_"+p_num, current_time);
         
	}
        
	}
	@Override
	public Post read(int p_num) {
		System.out.println("CommunityServiceImpl Start read...");
		return communityDao.read(p_num);
	}
	@Override
	public int update(Post post) {
		System.out.println("CommunityServiceImpl Start update...");
		int result = 0;
		result = communityDao.update(post);
		return result;
		
	}
	@Override
	public int delete(int p_num) {
		System.out.println("CommunityServiceImpl Start delete...");
		int result = 0;
		result = communityDao.delete(p_num);
		return result;
		
	}
	@Override
	public List<Reply> listReply(int p_num) {
		System.out.println("CommunityServiceImpl Start replyList...");
		List<Reply> listReply = communityDao.listReply(p_num);
		return listReply;
	}

	@Override
	public int reply_insert(Reply reply) {
		System.out.println("CommunityServiceImpl Start reply_insert...");
		int rp_num = 1 + communityDao.selectOneMaxRp_num();
		reply.setRp_num(rp_num);
		System.out.println("reply: " + reply.toString());
		return communityDao.insert(reply);
	}
	
	@Override
	public int reply_delete(int rp_num) {
		System.out.println("CommunityServiceImpl Start reply_delete...");
		int result = 0;
		result = communityDao.reply_delete(rp_num);
		return result;
	}

	@Override
	public int rereply_insert(Reply reply, int p_num, int parent_rp_num) {
		System.out.println("PostServiceImpl Start rereply_insert...");
		reply.setP_num(p_num);
		
		reply.setRp_num(parent_rp_num);
		Reply parentReply = communityDao.selectOneParentReply(reply);
		reply.setParent_rp_ref(parentReply.getRp_ref());
		reply.setParent_rp_order(parentReply.getRp_order());
		reply.setParent_rp_depth(parentReply.getRp_depth());


		
		//tRp_ref, Rp_depth 값 설정
		reply.setRp_ref(reply.getParent_rp_ref());
		reply.setRp_depth(reply.getParent_rp_depth() + 1);
		
		//삽입될 cg_num 찾기
		int rp_num = communityDao.selectOneMaxRp_num(p_num) + 1;
		reply.setRp_num(rp_num);
		//삽입될 cg_order 값 찾기
				int insertedRp_order = communityDao.selectOneInsertedRp_order(reply);
				if (insertedRp_order < 0) { //해당 ref에서 사이에 삽입되는 것이 아닌 제일 뒤에 삽입되는 경우
					insertedRp_order = communityDao.selectOneMaxRp_order(reply) + 1;
				}
				reply.setRp_order(insertedRp_order);
		//기존 reply들 order 한칸씩 뒤로밀어버리기
				communityDao.pushRp_order(reply);
				//CommonGroup 삽입하기 전 null값 처리하기
				if(reply.getM_id() ==null) reply.setM_id("");
				if(reply.getRp_content() ==null) reply.setRp_content("");
				
				return communityDao.rereply_insert(reply);
	}
	
	@Override
	public void listPost(PostLike postLike) {
		if(checkLike(postLike) == 0) {
			communityDao.insertLike(postLike);
	} else {
		communityDao.deleteLike(postLike);
	} 
	}
	@Override
	public int checkLike(PostLike postLike) {
		return  communityDao.checkLike(postLike);
	}
	@Override
	public List<Post> listNoticePost(int i) {
	
		return communityDao.listNoticePost(i);
	}
	@Override
	public void communityGroup(List<String> groupList, int bd_num) {
		communityDao.communityGroup(groupList,bd_num );
		
	}
	@Override
	public void communityDeleteGroup(List<String> groupList) {
		communityDao.communityDeleteGroup(groupList);		
	}
	@Override
	public void communityNoticeGroup(List<String> groupList) {
		communityDao.communityNoticeGroup(groupList);
		
	}

	@Override
	public int board_list_total(int bd_num) {
		int totCnt = communityDao.board_list_total(bd_num);
		return totCnt;
	}
	@Override
	public List<Post> board_list(Post post) {
		List<Post>  board_list = null;
		board_list = communityDao.board_list(post);
		return board_list;
	}
	@Override
	public List<Board> listBoard(int cm_num) {
		List<Board> listBoard = communityDao.listBoard(cm_num);
		return listBoard;
	}
	@Override
	public void listSide(String m_id, Model model) {
		List<Board> boardListOfCommunity = listBoard(3);
		boardListOfCommunity = checkCommunitiesJoined(m_id, boardListOfCommunity);
		model.addAttribute("boardListOfCommunity", boardListOfCommunity);
		
	}
	
	@Override
	public List<Board> checkCommunitiesJoined(String m_id, List<Board> boardListOfCommunity) {
		List<Board> boardListOfCommunityJoined = communityDao.getCommunitiesJoined(m_id);
		for (Board board : boardListOfCommunity) {
			for (Board boardJoined : boardListOfCommunityJoined) {
				if (board.getBd_num() == boardJoined.getBd_num()) {
					board.setIs_joined(1);
					break;
				}
			}
		}
		return boardListOfCommunity;
	}
	@Override
	//이건 나중에 바꾸기
	public void listSide(String m_id, ModelAndView modelandview) {
		List<Board> boardListOfCommunity = listBoard(3);
		modelandview.addObject("boardListOfCommunity", boardListOfCommunity);
		
	}

	@Override
	public int insert(Board board) {
		return communityDao.insert(board);
	}
	@Override
	public int insert(BoardMember boardMember) {
		return communityDao.insert(boardMember);
	}

	}



	
	


        
