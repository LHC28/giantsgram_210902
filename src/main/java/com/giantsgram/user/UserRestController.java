package com.giantsgram.user;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.ui.Model;
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
	
	@Autowired
	public JavaMailSender javaMailSender;
	
	// 회원가입
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("email") String email
			) {
		
		String encryptPassword = null;
		try {
			encryptPassword = SHA256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
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
		if(user==null && loginId.length()>=8) {
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
			) {
		// 비밀번호 해싱(SHA256)
		String encryptPassword = null;
		try {
			encryptPassword = SHA256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
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
			session.setAttribute("imagePath", user.getImagePath());
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
		
		// 변경된 user 정보 가져오기
		User user = userBO.getUserById(userId);
		
		// 세션 변경
		// name, nickname, phoneNumber, email,imagePath (imagePath는 아직 file로 BO에서 변경되므로 BO에서)
		session.setAttribute("name", user.getName());
		session.setAttribute("nickname", user.getNickname());
		session.setAttribute("phoneNumber", user.getPhoneNumber());
		session.setAttribute("email", user.getEmail());
		session.setAttribute("imagePath", user.getImagePath());
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		return result;
	}
	
	@PostMapping("/find_id")
	public Map<String, String> findId(
			@RequestParam("name") String name
			,@RequestParam("email") String email
			,Model model
			){
		Map<String, String> result = new HashMap<>();
		
		String loginId = userBO.getLoginIdByNameAndEmail(name, email);
		
		// 결과값에 따라 값 넘기기 - 성공시 success, 실패시 fail
		if(loginId==null) {
			result.put("result", "fail");
		}else {
			result.put("result", "success");
			result.put("loginId", loginId);
		}
		return result;
	}
	
	@PostMapping("/email_check")
	public Map<String, String> emailCheck(
			@RequestParam("loginId") String loginId
			,@RequestParam("email") String email
			){
		Map<String, String> result = new HashMap<>();
		
		boolean check = userBO.getEmailByNameAndEmail(loginId, email);
		if(check==true) {
			result.put("result", "success");
		}else {
			result.put("result", "fail");
		}
	
		return result;
	}
	
	@PostMapping("/send_email")
	public Map<String, String> sendMail(
			@RequestParam("email") String email) {
		Map<String, String> result = new HashMap<>();
		
		Random ran = new Random();
		String num = "";
		for(int i=0; i<6; i++) {
			int no = ran.nextInt(10);
			num+=no;
		}
		SimpleMailMessage simpleMessage = new SimpleMailMessage();
		simpleMessage.setFrom("zzangth95@naver.com");
		simpleMessage.setTo(email);
		simpleMessage.setSubject("이메일 인증번호");
		simpleMessage.setText("인증번호 : "+num+" 입니다.");
		javaMailSender.send(simpleMessage);
		
		result.put("result", "success");
		result.put("num", num);
		return result;
	}
	
	@PostMapping("/change_password")
	public Map<String, String> changePassword(
			@RequestParam("loginId") String loginId
			){
		Random ran = new Random();
		Map<String, String> result = new HashMap<>();
		String password = "";
		for(int i=0; i<8; i++) {
			int num = ran.nextInt(10);
			password+=num;
		}
		String encryptPassword = null;
		try {
			encryptPassword = SHA256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		userBO.changePasswordByLoginId(loginId, encryptPassword);
		result.put("result", "success");
		result.put("password", password);
		
		return result;
	}
	
}
