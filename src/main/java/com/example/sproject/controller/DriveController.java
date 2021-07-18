package com.example.sproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("drive")
public class DriveController {
	@RequestMapping("")
	public String index(Model model) {
		return "index";
	}
}
