package com.example.sproject.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.sproject.model.board.Post;
import com.example.sproject.service.board.Paging;
import com.example.sproject.service.board.PostService;
import com.google.gson.JsonObject;

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
//		model.addAttribute("p_num", p_num);
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
	// 게시글 상세내용 조회, 게시글 조회수 증가 처리
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
        
//        System.out.println("post.bd_num: " + post.getBd_num());
//        Sysout 결과
//        Post(p_num=4, bd_num=0, m_id=null, p_name=안녕하세요, p_content=반가워요, p_filename=null, p_regdate=Thu Jul 22 00:00:00 KST 2021, p_view=3, p_type=0, p_is_del=0, search=null, keyword=null, pageNum=null, start=0, end=0)

        
        return modelandview;
    }
    
 // 게시글 수정
    // 폼에서 입력한 내용들은 post로 전달됨
    @PostMapping(value="update")
    public String update(Post post) throws Exception{
    	System.out.println("BoardController Start update..");
        postService.update(post);
        return "redirect:/board/board";
    }
    // 게시글 삭제
    // 폼에서 입력한 내용들은 post로 전달됨
//    @RequestMapping(value="delete")
//    public String delete(@RequestParam int p_num)throws Exception{
//    	System.out.println("BoardController delete start..");
//        postService.delete(p_num);
//        return "redirect:/board/board";
//    }
	@RequestMapping(value="delete")
	public String delete(int p_num, Model model) {
		System.out.println("EmpController Start delete...");
		postService.delete(p_num);
		return  "redirect:/board/board";
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
}

