package com.giantsgram.page;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/page")
public class MyPageController {

	@RequestMapping("personal_page_view")
	public String pageView(Model model) {
		
		model.addAttribute("view", "page/personal_page");
		return "template/layout";
	}
	
}
