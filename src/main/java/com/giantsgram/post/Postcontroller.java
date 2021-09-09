package com.giantsgram.post;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class Postcontroller {

	@RequestMapping("/add_post")
	public String addPost(Model model) {
		
		model.addAttribute("view", "post/post");
		return "template/layout";
	}
}
