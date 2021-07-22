package com.example.sproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.sproject.model.board.Post;
import com.example.sproject.service.board.Paging;
import com.example.sproject.service.board.PostService;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private PostService ps;

	@RequestMapping(value = "board")
	public String Board(Post Post, String currentPage, Model model) {
		System.out.println("BoardController Start List..");
		int total = ps.total();
		System.out.println("BoardController total=>"+total);
		
		//입력받은 currentpage가 null일 때 1로 바꿔주기
		if(currentPage == null || "".equals(currentPage)) {
			currentPage = "1";
		}
		System.out.println("currentPage=>" + currentPage);

		Paging pg = new Paging(total, currentPage);
		Post.setStart(pg.getStart());
		Post.setEnd(pg.getEnd());
		List<Post> listPost = ps.listPost(Post);
		model.addAttribute("listPost", listPost);
		model.addAttribute("total", total);
		model.addAttribute("listPost", listPost);
		model.addAttribute("pg",pg);
		return "board/board";
	}

}
