package com.example.sproject.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	public static final String PRE_PATH = "file:///";
	
	// WINDOW 환경
	public static final String RESOURCE_PATH = "C:/sproject_resource";
	public static final String RESOURCE_LOCATIONS_PATH = PRE_PATH + RESOURCE_PATH + "/";

	// UBUNTU 환경
//	public static final String RESOURCE_PATH = "/home/ubuntu/sproject_resource";
//	public static final String RESOURCE_LOCATIONS_PATH = PRE_PATH + RESOURCE_PATH.substring(1) + "/";	
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {   	
        //일반적인 resource 위치
        registry.addResourceHandler("/resource/**")
        		.addResourceLocations(RESOURCE_LOCATIONS_PATH);
    }
}
