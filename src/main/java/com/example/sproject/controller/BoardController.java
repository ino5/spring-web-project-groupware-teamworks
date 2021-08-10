package com.example.sproject.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
	public String board(Post post, String currentPage, Model model, Board board, Principal principal) {
		System.out.println("BoardController Start2 List..");

		System.out.println("BoardController Start List..");
		int total = boardService.total();
		System.out.println("BoardController total=>"+total);
		
		//입력받은 currentpage가 null일 때 1로 바꿔주기
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
	    model.addAttribute("sessionId", principal.getName());
		Paging pg = new Paging(total, currentPage);
		post.setStart(pg.getStart());
		post.setEnd(pg.getEnd());
		//모든글
		List<Post> listPost = boardService.listPost(post);
		//공지
		List<Post> listNoticePost = boardService.listNoticePost(1);
	
		model.addAttribute("total", total);
		model.addAttribute("listPost", listPost);
		model.addAttribute("listNoticePost", listNoticePost);
		model.addAttribute("pg",pg);
//		model.addAttribute("p_num", p_num);
		//사이드바 리스트 
		boardService.listSide(model);
		return "board/board";
	}
	@RequestMapping(value = "sideboard_list")
	public String board_list(Post post, String currentPage, Model model, Board board, int bd_num, Principal principal) {
		//bd_num jsp에 넘기기
		model.addAttribute("bd_num", bd_num);
		
		
		List<Board> boardListOfAll = boardService.listBoard(1);
		List<Board> boardListOfDept = boardService.listBoard(2);
		int total = boardService.board_list_total(bd_num);
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		model.addAttribute("sessionId",principal.getName());
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
		model.addAttribute("listBoard", listBoard);
		boardService.listSide(model);
		return "board/write";
	}

	@PostMapping(value = "insert")
	public String insert(Post post, Model model, Board board, Principal principal ) throws Exception {
		System.out.println("BoardController Start insert..");
		List<Board> listBoard = boardService.listBoard(board);
		model.addAttribute("listBoard", listBoard);
//		model.addAttribute("sessionId", principal.getName());
		post.setM_id(principal.getName());
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
//게시글삭제
	@RequestMapping(value="delete")
	public String delete(int p_num, Model model) {
		System.out.println("EmpController Start delete...");
		System.out.println("p_num"+p_num);
		boardService.PostLike_Delete(p_num);
		boardService.post_replydelete(p_num);
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
		
		// 이동하기
		   @RequestMapping(value="boardGroup", method= {RequestMethod.GET, RequestMethod.POST})
		   @ResponseBody
		   public void boardGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model, int bd_num) {
//		        Ajax를 통해 Array로 받은 "deleteList"를 하나씩 빼내어 ArrayList에 넣음 
		       ArrayList<String> GroupArray = new ArrayList<String>();
		       for(int i=0;i<groupList.size();i++){
		          GroupArray.add(groupList.get(i));
		       }
		       boardService.boardGroup(groupList, bd_num);
		   }
			// 삭제
		   @RequestMapping(value="boardDeleteGroup", method= {RequestMethod.GET, RequestMethod.POST})
		   @ResponseBody
		   public void boardDeleteGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model) {
		       ArrayList<String> GroupArray = new ArrayList<String>();
		       for(int i=0;i<groupList.size();i++){
		          GroupArray.add(groupList.get(i));
		       }
		       boardService.boardDeleteGroup(groupList);
		   }
			// 공지로등록
		   @RequestMapping(value="boardNoticeGroup", method= {RequestMethod.GET, RequestMethod.POST})
		   @ResponseBody
		   public void boardNoticeGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model) {
			   System.out.println("boardNoticeGroup Start");
		       ArrayList<String> GroupArray = new ArrayList<String>();
		       for(int i=0;i<groupList.size();i++){
		          GroupArray.add(groupList.get(i));
		       }
		       boardService.boardNoticeGroup(groupList);
		   }
		   //검색하기 
		   @RequestMapping("BoardSearchList")
		 //@RequestParam(defaultValue="") ==> 기본값 할당
		 public ModelAndView BoardSearchList(@RequestParam(defaultValue="m_id") String searchOption,
		                      @RequestParam(defaultValue="") String keyword) throws Exception{
			   System.out.println("board/BoardSearchList");
			   System.out.println("searchOption: " + searchOption);
			   System.out.println("keyword: " + keyword);
			  List<Post> list = boardService.listAll(searchOption, keyword);
			  System.out.println("list.size: "+ list.size());
			  // 레코드의 갯수
			  int count = boardService.countArticle(searchOption, keyword);
			  System.out.println("count: " + count);
			  // ModelAndView - 모델과 뷰
			  ModelAndView mav = new ModelAndView();
			  /*mav.addObject("list", list); // 데이터를 저장
			  mav.addObject("count", count);
			  mav.addObject("searchOption", searchOption);
			  mav.addObject("keyword", keyword);*/
			  // 데이터를 맵에 저장
			  Map<String, Object> map = new HashMap<String, Object>();
			  map.put("list", list); // list
			  map.put("count", count); // 레코드의 갯수
			  map.put("searchOption", searchOption); // 검색옵션
			  map.put("keyword", keyword); // 검색키워드
			  mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
			  mav.addObject("listPost", list); // 맵에 저장된 데이터를 mav에 저장
			  mav.setViewName("board/board");
			  return mav; 
			}
}



