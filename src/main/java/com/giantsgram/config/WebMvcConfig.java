package com.giantsgram.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.giantsgram.intercepter.PermissionInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	@Autowired
	private PermissionInterceptor permissionInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(permissionInterceptor)
		.addPathPatterns("/**") // 모두 해당
		.excludePathPatterns("/user/sign_out","/static/**","/error"); // 로그아웃, css,이미지파일, 에러시 제외
	}
	
	// 사진을 웹주소로 가져올 수 있게 해주는 기능
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**")
		.addResourceLocations("file:///C:\\team SNS\\workspace\\Giantsgram\\images/");
	}
}
