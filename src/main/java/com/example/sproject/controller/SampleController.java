package com.example.sproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.sproject.model.sample.Sample;
import com.example.sproject.service.sample.SampleService;

@Controller
@RequestMapping("sample")
public class SampleController {
	@Autowired
	private SampleService sampleService;
	
	@RequestMapping("")
	public String sample(Model model) {
		System.out.println("sample in Class SampleController");
		return "sample/sample";
	}
	
	@RequestMapping("main")
	public String sampleMain(Model model) {
		System.out.println("sampleMain in Class SampleController");
		return "sample/sampleMain";
	}
	
	@RequestMapping("list")
	public String sampleList(Model model) {
		System.out.println("Method sampleList in Class SampleController");
		List<Sample> sampleList = sampleService.listSample();
		model.addAttribute("sampleList", sampleList);
		return "sample/sampleList";
	}
	
	@RequestMapping("insert")
	public String sampleInsert(Sample sample, Model model) {
		System.out.println("Method sampleInsert in Class SampleController");
		sampleService.insertSample(sample);
		return "redirect:/sample/list";
	}
	
}
