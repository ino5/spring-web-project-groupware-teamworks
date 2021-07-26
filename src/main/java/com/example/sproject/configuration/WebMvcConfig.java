package com.example.sproject.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	public static final String PRE_PATH = "file:///C:";
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/summernoteImage/**")
                .addResourceLocations(PRE_PATH + "/summernote_image/");
        registry.addResourceHandler("/resource/**")
        		.addResourceLocations(PRE_PATH + "/sproject_resource/");
    }
}
