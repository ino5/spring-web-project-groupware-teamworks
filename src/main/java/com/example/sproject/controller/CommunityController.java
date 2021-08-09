package com.example.sproject.controller;

import java.io.File;
import java.io.InputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
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
import com.example.sproject.model.community.BoardMember;
import com.example.sproject.service.community.CommunityService;
import com.example.sproject.service.community.Paging;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("community")
public class CommunityController {
	@Autowired
	private CommunityService communityService;
	
	//게시글 리스트 페이징
	@RequestMapping(value = "", method = {RequestMethod.GET, RequestMethod.POST})
	public String board(Model model, Post post, String currentPage, Board board,  Principal principal,BoardMember boardMember) {
		System.out.println("CommunityController Start List");
		int total = communityService.total();
		System.out.println("CommunityController total=>"+total);
		
		if (currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		model.addAttribute("sessionId",principal.getName());
		Paging pg = new Paging(total, currentPage);
		post.setStart(pg.getStart());
		post.setEnd(pg.getEnd());
		//모든글
		List<Post> listPost = communityService.listPost(post);
		for(Post post2 : listPost) {
			System.out.println(post2);
		}
		//커뮤니티 멤버 보여주기
		List<Board> boardListOfCommunity = communityService.listBoard(3);
		//공지
		List<Post> listNoticePost = communityService.listNoticePost(1);
		model.addAttribute("boardListOfCommunity", boardListOfCommunity);
		model.addAttribute("total", total);
		model.addAttribute("listPost", listPost);
		model.addAttribute("listNoticePost", listNoticePost);
		model.addAttribute("pg",pg);
		
		//사이드바 리스트 
		communityService.listSide(principal.getName(), model);
		return "community/board";
	}
	//게시글 작성화면
	@GetMapping(value = "write")
	public String write(Model model, Board board, Principal principal) {
		List<Board> listBoard = communityService.listBoard(board);
		model.addAttribute("listBoard", listBoard);
		//사이드바 리스트 
		communityService.listSide(principal.getName(), model);
		System.out.println("CommunityController Start write..");
		return "community/write";
	}

	//게시글 작성하기
	@PostMapping(value = "insert")
	public String insert(Post post, Model model, Board board, Principal principal) throws Exception{
		System.out.println("CommunityController Start insert..");
		List<Board> listBoard = communityService.listBoard(board);
		model.addAttribute("listBoard", listBoard);
		post.setM_id(principal.getName());
		communityService.insert(post);
		//사이드바 리스트 
		communityService.listSide(principal.getName(), model);
		return "redirect:/community";
		
		
	}
	
	// 게시글 상세내용 조회, 게시글 조회수 증가 처리
    @RequestMapping(value="view", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView view(@RequestParam int p_num, HttpSession session, Principal principal) throws Exception{
        // 조회수 증가 처리
    	communityService.increase_p_view(p_num, session);
        // 모델(데이터)+뷰(화면)를 함께 전달하는 객체
        ModelAndView modelandview = new ModelAndView();

        modelandview.setViewName("community/view");

        Post post = communityService.read(p_num);
  
        if(principal != null) {
        	post.setLoginId(principal.getName());
        }
        //댓글 가져오기
     	List<Reply> listReply = communityService.listReply(p_num);
        modelandview.addObject("listReply", listReply);
     	communityService.listSide(principal.getName(), modelandview);	
        modelandview.addObject("view", post);
     
        
        //좋아요 가져오기
      PostLike postLike = new PostLike();
      if(principal != null) {
    	  postLike.setM_id(principal.getName());
    	  postLike.setP_num(p_num);
    	  int statusOfLike = communityService.checkLike(postLike);
    	  modelandview.addObject("statusOfLike", statusOfLike);
    	  //
    	  
      }
      return modelandview;
}
    // 게시글 수정
    @PostMapping(value = "update")
    public String update(Post post) throws Exception{
    	System.out.println("CommunityController Start update...");
    	communityService.update(post);
    	return "redirect:/community";
  
    }
    //게시글 삭제 
    @RequestMapping(value ="delete" )
    public String delete(int p_num, Model model) {
    	System.out.println("CommunityController Start delete...");
    	communityService.delete(p_num);
    	return "redirect:/community";
    }
    @PostMapping(value = "uploadSummernoteImageFile", produces = "application/json")
    @ResponseBody
    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
    	 System.out.println("uploadSummernoteImageFile");
    	 JsonObject jsonObject = new JsonObject();
    	 
    	 String fileRoot = "C:\\summernote_image\\";	
    	 String originalFileName = multipartFile.getOriginalFilename();
    	 String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
    	 
    	 String savedFileName = UUID.randomUUID() + extension;
    	 
    	 File targetFile = new File(fileRoot + savedFileName);
    	 
    	 try {
			InputStream filStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(filStream, targetFile);
			jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
			
			
		} catch (Exception e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
    	 return jsonObject;
    }

  //댓글작성하기
    @PostMapping(value ="reply_insert")
    	public String insert(Reply reply, Model model, Principal principal) throws Exception {
    	System.out.println("CommunityController Start Replyinsert..");

    		if(principal != null) {
    			reply.setM_id(principal.getName());
    		}
    			int p_num = reply.getP_num();
    		communityService.reply_insert(reply);
    		return "redirect:/community/view?p_num=" + p_num;
    			}
  //댓글 삭제하기		
  	
  		@PostMapping(value="reply_delete")
  		@ResponseBody
  		public String reply_delete( int rp_num, Model model) {
  			System.out.println("CommunityController Start reply_delete...");
  			System.out.println("rp_num"+ rp_num);
  			//postService.delete(p_num);
  			communityService.reply_delete(rp_num);
  			//여기서의 리턴값은  success : function(data) 여기서의 data -- > "!!!!!!!!!!!"
  			return  "이제된다";
  		}
  	//대댓글	
  			@PostMapping(value = "rereply_insert")
  			public String rereply_insert(Reply reply, Model model, Principal principal, int parent_rp_num ) throws Exception {
  				System.out.println("CommunityController Start Rereplyinsert..");

  				if(principal != null) {
  					reply.setM_id(principal.getName());
  				}
  				int p_num = reply.getP_num();
  				communityService.rereply_insert(reply, p_num, parent_rp_num );
  				return  "redirect:/community/view?p_num=" + p_num;
  			}	
//게시물 좋아요 기능
  			@RequestMapping(value = "recommend")
  			public String like(int p_num, Model model, PostLike postLike, Principal principal) {
  				
  				if(principal != null) {
  					postLike.setM_id(principal.getName());
  					postLike.setP_num(p_num);
  					communityService.listPost(postLike);
  				}
  				return"redirect:/community/view?p_num=" + p_num;
  			}
//이동하기
  		
  			@PostMapping(value = "communityGroup")
  
  			public void communityGroup(@RequestParam(value ="checkArray[]", required=false) List<String> groupList, Model model, int bd_num) {
  		       // Ajax를 통해 Array로 받은 "deleteList"를 하나씩 빼내어 ArrayList에 넣음 
 		       ArrayList<String> GroupArray = new ArrayList<String>();
 		       for(int i=0;i<groupList.size();i++){
 		          GroupArray.add(groupList.get(i));
 		       }
 		      communityService.communityGroup(groupList, bd_num);
 		   }
  			//삭제
  public void communityDeleteGroup(@RequestParam(value ="checkArray[]", required=false) List<String> groupList, Model model) {

  			   ArrayList<String> GroupArray = new ArrayList<String>();
  			   for(int i=0;i<groupList.size();i++){
  			   GroupArray.add(groupList.get(i));
  			   }
  	 communityService.communityDeleteGroup(groupList);
}

//공지로 등록
	public void community_NoticeGroup(@RequestParam(value ="checkArray[]", required=false) List<String> groupList, Model model) {

     ArrayList<String> GroupArray = new ArrayList<String>();
     for(int i=0;i<groupList.size();i++){
        GroupArray.add(groupList.get(i));
     }
    communityService.communityNoticeGroup(groupList);
 }
 //게시판 리스트 띄우기 
			@RequestMapping(value = "board_list")
			public String board(Board board, Model model) {
				List<Board> listBoard = communityService.listBoard(board);
				model.addAttribute("listBoard", listBoard);
				return "community/board";
			}	
//사이드
			@RequestMapping(value = "sideboard_list")
			public String board_list(Post post, String currentPage, Model model, int bd_num, Principal principal,BoardMember boardMember) {
				//bd_num, 커뮤니티 정보 jsp에 넘기기
				model.addAttribute("bd_num", bd_num);
				Board community = communityService.findBoard(bd_num);
				model.addAttribute("community", community);
				
				// borad type 3번인 리스트만 가져옴
				int total = communityService.board_list_total(bd_num);
				if(currentPage == null || "".equals(currentPage)) {
					currentPage = "1";
				}
				model.addAttribute("sessionId",principal.getName());
				Paging pg = new Paging(total, currentPage);
				post.setStart(pg.getStart());
				post.setEnd(pg.getEnd());
				List<Post> board_list = communityService.board_list(post);
			
				List<Board> boardListOfCommunity = communityService.listBoard(3);
				List<BoardMember> boardListOfJoinedCommunity = communityService.list_board(bd_num);
				
				
				model.addAttribute("boardListOfJoinedCommunity", boardListOfJoinedCommunity);
				model.addAttribute("total", total);
				model.addAttribute("board_list", board_list);
				model.addAttribute("boardListOfCommunity", boardListOfCommunity);
				model.addAttribute("pg",pg);
				communityService.listSide(principal.getName(), model);
				return "community/test";
			}
			
			//커뮤니티 작성화면
			@GetMapping(value = "write_Community")
			public String write_Community(Model model, Principal principal) {
				//사이드바 리스트 
				communityService.listSide(principal.getName(), model);
				return "community/CommunityCreate";
				
			}

		//커뮤니티 만들기
			@PostMapping(value = "CommunityCreate")
			public String Community_create(Model model, Board board, Principal principal) throws Exception{
				//커뮤니티 타입 설정하기
				int bd_type = 3;
				board.setBd_type(bd_type);
				
				//세션 아이디 넣기
				board.setM_id(principal.getName());
				//화면에서 입력받은 제목,소개
				communityService.insert(board);
				//사이드바 리스트 
				communityService.listSide(principal.getName(), model);
				return "redirect:/community/";
				
				
			}
//커뮤니티 가입하기
			@PostMapping(value = "CommunitySign")
			public String CommunitySign(Model model, BoardMember boardMember, Principal principal, int bd_num) throws Exception{
				
				//아이디 넣기
				boardMember.setM_id(principal.getName());
				//화면에서 입력받은 제목,소개
				communityService.insert(boardMember);
				//사이드바 리스트 
				communityService.listSide(principal.getName(), model);
				return "redirect:/community/";
}
}
