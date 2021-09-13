package com.giantsgram.friend;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.giantsgram.friend.bo.FriendBO;

@RestController
@RequestMapping("/friend")
public class FriendRestController {
	
	@Autowired
	private FriendBO friendBO;

	@RequestMapping("/friend_add")
	public Map<String, String> friendAdd(
			@RequestParam("friendId") int friendId
			,HttpServletRequest request
			){
		HttpSession session = request.getSession();
		// 로그인 중인 유저의 id가져오기
		int userId = (int)session.getAttribute("userId");
		// 결과값 내리기용
		Map<String, String> result = new HashMap<>();
		friendBO.addFriend(userId,friendId);
		result.put("result", "success");
		
		return result;
	}
	
	@PostMapping("/friend_delete")
	public Map<String, String> friendDelete(
			// 친구 id가져오기
			@RequestParam("friendId") int friendId
			,HttpServletRequest request
			){
		
		HttpSession session = request.getSession();
		// 로그인 중인 유저 아이디 가져오기
		int userId = (int)session.getAttribute("userId");
		
		friendBO.deleteFriend(userId, friendId);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		return result;
	}
}
