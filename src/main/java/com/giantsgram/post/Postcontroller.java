package com.giantsgram.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giantsgram.post.bo.PostBO;

@Controller
@RequestMapping("/post")
public class Postcontroller {

	@Autowired
	private PostBO postBO;
	
	@RequestMapping("/add_post")
	public String addPost(Model model) {
		
		model.addAttribute("view", "post/post");
		return "template/layout";
	}
	
	@RequestMapping("/post_view")
	public String post(
			Model model
			,@RequestParam("postId") int postId
			) {
		//post값 가져와서 넘기기
		
		model.addAttribute("postId", postId);
		model.addAttribute("view", "timeline/post");
		return "template/layout";
	}
}
