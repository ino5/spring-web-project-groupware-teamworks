package com.example.sproject.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.dao.board.BoardDao;
import com.example.sproject.model.board.Board;
import com.example.sproject.model.board.Post;
import com.example.sproject.model.board.PostLike;
import com.example.sproject.model.board.Reply;
import com.example.sproject.service.board.Paging;
import com.example.sproject.service.board.BoardService;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
//게시글 리스트, 페이징
	@RequestMapping(value = "")
	public String board(Post post, String currentPage, Model model, Board board) {
		System.out.println("BoardController Start2 List..");

		System.out.println("BoardController Start List..");
		int total = boardService.total();
		System.out.println("BoardController total=>"+total);
		
		//입력받은 currentpage가 null일 때 1로 바꿔주기
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
	
		Paging pg = new Paging(total, currentPage);
		post.setStart(pg.getStart());
		post.setEnd(pg.getEnd());
		//모든글
		List<Post> listPost = boardService.listPost(post);
		//공지
		List<Post> listNoticePost = boardService.listNoticePost(1);
		//공지아닌글
		List<Post> listNoneNoticePost = boardService.listNoticePost(2);
		model.addAttribute("total", total);
		model.addAttribute("listPost", listPost);
		model.addAttribute("listNoticePost", listNoticePost);
		model.addAttribute("pg",pg);
//		model.addAttribute("p_num", p_num);
		boardService.listSide(model);
		return "board/board";
	}
	@RequestMapping(value = "sideboard_list")
	public String board_list(Post post, String currentPage, Model model, Board board, int bd_num) {
		
		List<Board> boardListOfAll = boardService.listBoard(1);
		List<Board> boardListOfDept = boardService.listBoard(2);
		int total = boardService.board_list_total(bd_num);
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		Paging pg = new Paging(total, currentPage);
		post.setStart(pg.getStart());
		post.setEnd(pg.getEnd());
		List<Post> board_list = boardService.board_list(post);
		model.addAttribute("total", total);
		model.addAttribute("board_list", board_list);
		model.addAttribute("boardListOfAll", boardListOfAll);
		model.addAttribute("boardListOfDept", boardListOfDept);
		model.addAttribute("pg",pg);
		boardService.listSide(model);
		return "board/test";
	}

	//게시글 작성화면
	//@RequestMapping(value = "write", method=RequestMethod.POST)
	@GetMapping(value = "write")
	public String write(Model model, Board board) {
		List<Board> listBoard = boardService.listBoard(board);
		List<Board> boardListOfAll = boardService.listBoard(1);
		List<Board> boardListOfDept = boardService.listBoard(2);
	
		model.addAttribute("listBoard", listBoard);
		System.out.println("BoardController Start write..");
		boardService.listSide(model);
		return "board/write";
	}

	@PostMapping(value = "insert")
	public String insert(Post post, Model model, Board board ) throws Exception {
		System.out.println("BoardController Start insert..");
		List<Board> listBoard = boardService.listBoard(board);
		model.addAttribute("listBoard", listBoard);
		boardService.insert(post);
		boardService.listSide(model);
		return "redirect:/board";
	}
	// 게시글 상세내용 조회, 게시글 조회수 증가 처리
    @RequestMapping(value="view", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView view(@RequestParam int p_num, HttpSession session, Principal principal, Reply reply) throws Exception{
        // 조회수 증가 처리
      boardService.increase_p_view(p_num, session);
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView modelandview = new ModelAndView();
        // 뷰의 이름
        modelandview.setViewName("board/view");
        // 뷰에 전달할 데이터
        Post post = boardService.read(p_num);
       // String loginId = (String) session.getAttribute("m_id");
        if(principal != null) {
        	post.setLoginId(principal.getName());
        }
        System.out.println("!!!!!!!"+ post.getLoginId());
        modelandview.addObject("view", post);
        
        // toString
        
//        System.out.println("post.bd_num: " + post.getBd_num());
//        Sysout 결과
//        Post(p_num=4, bd_num=0, m_id=null, p_name=안녕하세요, p_content=반가워요, p_filename=null, p_regdate=Thu Jul 22 00:00:00 KST 2021, p_view=3, p_type=0, p_is_del=0, search=null, keyword=null, pageNum=null, start=0, end=0)

        //댓글 가져오기
		List<Reply> listReply = boardService.listReply(p_num);
		modelandview.addObject("listReply", listReply);
//		model.addAttribute("p_num", p_num);
//		System.out.println("in listReply: " + listReply.get(0).getRp_num());
		
		//좋아요 상태 가져오기
		PostLike postLike = new PostLike();
		if(principal != null) {
			postLike.setM_id(principal.getName());
			postLike.setP_num(p_num);
			int statusOfLike = boardService.checkLike(postLike);
			modelandview.addObject("statusOfLike", statusOfLike);
		}
		
		
		boardService.listSide(modelandview);	
        return modelandview;
    }
    
 // 게시글 수정
    // 폼에서 입력한 내용들은 post로 전달됨
    @PostMapping(value="update")
    public String update(Post post) throws Exception{
    	System.out.println("BoardController Start update..");
        boardService.update(post);
        return "redirect:/board";
    }

	@RequestMapping(value="delete")
	public String delete(int p_num, Model model) {
		System.out.println("EmpController Start delete...");
		System.out.println("p_num"+p_num);
		boardService.delete(p_num);
		boardService.listSide(model);
		return  "redirect:/board";
	}
	
	//파일 업로드
	   @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	    @ResponseBody
	    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		   System.out.println("uploadSummernoteImageFile");
	        JsonObject jsonObject = new JsonObject();

	        String fileRoot = "C:\\summernote_image\\";	//저장될 파일 경로
	        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
	        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자

	        // 랜덤 UUID+확장자로 저장될 savedFileName
	        String savedFileName = UUID.randomUUID() + extension;	
	        
	        File targetFile = new File(fileRoot + savedFileName);

	        try {
	            InputStream fileStream = multipartFile.getInputStream();
	            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
	            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
	            jsonObject.addProperty("responseCode", "success");

	        } catch (IOException e) {
	            FileUtils.deleteQuietly(targetFile);	// 실패시 저장된 파일 삭제
	            jsonObject.addProperty("responseCode", "error");
	            e.printStackTrace();
	        }

	        return jsonObject;
	    }
	
	  //게시판 리스트 띄우기 
		@RequestMapping(value = "board_list")
		public String board(Board board, Model model) {
			System.out.println("BoardController Start board_list..");		
			List<Board> listBoard = boardService.listBoard(board);
			model.addAttribute("listBoard", listBoard);
			System.out.println("in listBoard: " + listBoard.get(0).getBd_name());
			return "board/board";
		}
		//댓글작성하기
		@PostMapping(value ="reply_insert")
		public String insert(Reply reply, Model model, Principal principal) throws Exception {
			System.out.println("BoardController Start Replyinsert..");

			if(principal != null) {
				reply.setM_id(principal.getName());
			}
			
			int p_num = reply.getP_num();
			boardService.insert(reply);
			return "redirect:/board/view?p_num=" + p_num;
		}	
		//댓글 삭제하기		
		//@ResponseBody
		//@RequestParam
		//@RequestBody
		@PostMapping(value="reply_delete")
		@ResponseBody
		public String reply_delete( int rp_num, Model model) {
			System.out.println("EmpController Start reply_delete...");
			System.out.println("rp_num"+ rp_num);
			//postService.delete(p_num);
			boardService.reply_delete(rp_num);
			//여기서의 리턴값은  success : function(data) 여기서의 data -- > "!!!!!!!!!!!"
			return  "이제된다";
		}
		//대댓글	
		@PostMapping(value = "rereply_insert")
		public String rereply_insert(Reply reply, Model model, Principal principal, int parent_rp_num ) throws Exception {
			System.out.println("BoardController Start Rereplyinsert..");

			if(principal != null) {
				reply.setM_id(principal.getName());
			}
			int p_num = reply.getP_num();
			boardService.rereply_insert(reply, p_num, parent_rp_num );
			return  "redirect:/board/view?p_num=" + p_num;
		}	
//		//대댓글
//		@ResponseBody
//		@PostMapping(value = "rereply_insert")
//		public String rereply_insert(int p_num, int rp_num, Model model, Principal principal ) throws Exception {
//			System.out.println("BoardController Start Rereplyinsert..");
//			Reply reply = null;
//
//			if(principal != null) {
//				reply.setM_id(principal.getName());
//			}
//			reply.setP_num(p_num);
//			reply.setRp_num(rp_num);
//			reply.setParent_rp_num(rp_num);
//			boardService.rereply_insert(reply, p_num);
//			return  "성공" ;
//		}	
		// 게시물 좋아요 기능
		@RequestMapping(value = "recommend")
		public String like(int p_num, Model model, PostLike postLike, Principal principal) {
			
		        if(principal != null) {
		        	postLike.setM_id(principal.getName());
		        	postLike.setP_num(p_num);
		        	boardService.like(postLike);
		        }

		    return "redirect:/board/view?p_num=" + p_num;
		}
	
}


