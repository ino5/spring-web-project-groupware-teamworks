package com.example.sproject.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	public static final String PRE_PATH = "file:///";
	
	public static final String RESOURCE_PATH = "C:/sproject_resource";
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	//다솔 게시판 관련
        registry.addResourceHandler("/summernoteImage/**")
                .addResourceLocations(PRE_PATH + "C:/summernote_image/");
        //일반적인 resource 위치
        registry.addResourceHandler("/resource/**")
        		.addResourceLocations(PRE_PATH + RESOURCE_PATH + "/");
    }
}
