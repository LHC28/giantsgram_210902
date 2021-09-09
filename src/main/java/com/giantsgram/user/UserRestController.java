package com.giantsgram.user;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.giantsgram.common.SHA256;
import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
	// 회원가입
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("email") String email
			) throws NoSuchAlgorithmException {
		
		String encryptPassword = SHA256.encrypt(password);
		userBO.addUser(loginId, encryptPassword, name, phoneNumber, email);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
	// id 중복확인
	@RequestMapping("/duplicated_id")
	public Map<String, Boolean> duplicatedId(
			@RequestParam("loginId") String loginId
			) {
		Map<String, Boolean> result = new HashMap<>();
		User user =  userBO.duplicatedId(loginId);
		if(user==null) {
			result.put("result", true);
		}else {
			result.put("result", false);
		}
		return result;
	}
	
	// 로그인 하기
	@PostMapping("/sign_in")
	public Map<String, Boolean> signIn(
			@RequestParam("loginId") String loginId
			,@RequestParam("password") String password
			,HttpServletRequest request
			) throws NoSuchAlgorithmException{
		// 비밀번호 해싱(SHA256)
		String encryptPassword = SHA256.encrypt(password);
		// 아이디와 비밀번호로 계정 유무 확인
		User user = userBO.getUser(loginId, encryptPassword);
		
		Map<String, Boolean> result = new HashMap<>();
		// 로그인 성공한 경우
		if(user!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginId", user.getLoginId());
			session.setAttribute("userId", user.getId());
			session.setAttribute("name", user.getName());
			session.setAttribute("nickname", user.getNickname());
			result.put("result", true);
		// 로그인 실패한 경우
		}else {
			result.put("result", false);
		}
		return result;
	}
	
	@PostMapping("/profile_change")
	public Map<String, String> profileChange(
			@RequestParam("name") String name
			,@RequestParam("nickname") String nickname
			,@RequestParam("phoneNumber") String phoneNumber
			,@RequestParam("email") String email
			,@RequestParam(value="picture", required=false) MultipartFile file
			,HttpServletRequest request
			){
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		String loginId = (String)session.getAttribute("loginId");
		userBO.profileChange(userId, loginId, name, nickname, phoneNumber, email, file);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		return result;
	}

	
}
