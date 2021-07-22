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
	postList =pd.listPost(post);
		return postList;
	}

	@Override
	public int total() {
		System.out.println("PostServiceImpl Start total...");
		int totCnt = pd.total();
		System.out.println("PostServiceImpl total totCnt->"+totCnt);
		return totCnt;
	}
	// p_num, p_name, p_content, p_regdate, p_view
	@Override
	public int insert(Post post) {
	
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
        
        return pd.insert(post);

}
}