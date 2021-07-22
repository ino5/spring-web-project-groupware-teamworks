package com.example.sproject.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.board.Post;
import com.example.sproject.service.board.Paging;
import com.example.sproject.service.board.PostService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private PostService postService;
//게시글 리스트, 페이징
	@RequestMapping(value = "board")
	public String board(Post Post, String currentPage, Model model) {
		System.out.println("BoardController Start List..");
		int total = postService.total();
		System.out.println("BoardController total=>"+total);
		
		//입력받은 currentpage가 null일 때 1로 바꿔주기
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		System.out.println("currentPage=>" + currentPage);

		Paging pg = new Paging(total, currentPage);
		Post.setStart(pg.getStart());
		Post.setEnd(pg.getEnd());
		List<Post> listPost = postService.listPost(Post);
		model.addAttribute("listPost", listPost);
		model.addAttribute("total", total);
		model.addAttribute("listPost", listPost);
		model.addAttribute("pg",pg);
		return "board/board";
	}
	
	//게시글 작성화면
	//@RequestMapping(value = "write", method=RequestMethod.POST)
	@GetMapping(value = "write")
	public String write(Model model) {
		System.out.println("BoardController Start write..");
		return "board/write";
	}
	//
	
	@PostMapping(value = "insert")
	public String insert(Post Post, Model model ) throws Exception {
		System.out.println("BoardController Start insert..");
		postService.insert(Post);
		return "redirect:/board/board";
	}
	// 03. 게시글 상세내용 조회, 게시글 조회수 증가 처리
    // @RequestParam : get/post방식으로 전달된 변수 1개
    // HttpSession 세션객체
	
    @GetMapping(value="view") //무조건 값을 받아야함
    public ModelAndView view(@RequestParam int p_num, HttpSession session) throws Exception{
        // 조회수 증가 처리
      postService.increase_p_view(p_num, session);
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView modelandview = new ModelAndView();
        // 뷰의 이름
        modelandview.setViewName("board/view");
        // 뷰에 전달할 데이터
        Post post = postService.read(p_num);
        modelandview.addObject("view", post);
        // toString
        System.out.println(post.toString());
//        System.out.println("post.bd_num: " + post.getBd_num());
//        Sysout 결과
//        Post(p_num=4, bd_num=0, m_id=null, p_name=안녕하세요, p_content=반가워요, p_filename=null, p_regdate=Thu Jul 22 00:00:00 KST 2021, p_view=3, p_type=0, p_is_del=0, search=null, keyword=null, pageNum=null, start=0, end=0)

        
        return modelandview;
    }
}
