package com.example.sproject;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		System.out.println("Method SpringApplicationBuilder in Class ServletInitializer");
		return builder.sources(SprojectApplication.class);
	}

}
