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
	
	@RequestMapping("/sign_out")
	public String signOut(
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		session.removeAttribute("loginId");
		session.removeAttribute("userId");
		session.removeAttribute("name");
		session.removeAttribute("nickname");
		session.removeAttribute("imagePath");
		
		return "redirect:/user/sign_in_view";
	}
	
	@RequestMapping("/find_id")
	public String findId() {
		
		return "/user/find_id";
	}
	
	@RequestMapping("/find_password")
	public String findPassword() {
		
		return "/user/find_password";
	}
	
	

}
