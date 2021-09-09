package com.giantsgram.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserBO userBO;

	@RequestMapping("/sign_in_view")
	public String signInView() {
		
		return "user/sign_in";
	}
	
	@RequestMapping("/sign_up_view")
	public String signUpView() {
		
		return "user/sign_up";
	}
	
	@RequestMapping("/change_profile_view")
	public String changeProfileView(
			Model model
			,HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		User user = userBO.getUserById(userId);
		
		model.addAttribute("user", user);
		model.addAttribute("view", "user/change_profile");
		return "template/layout";
	}
	
	

}
