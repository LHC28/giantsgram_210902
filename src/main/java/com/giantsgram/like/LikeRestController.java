package com.giantsgram.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.giantsgram.like.bo.LikeBO;

@RestController
@RequestMapping("/like")
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;

	@RequestMapping("/like_click")
	public Map<String, String> likeClick(
			@RequestParam("userId") int userId
			,@RequestParam("postId") int postId
			){
		boolean check = likeBO.getLikeClick(userId, postId);
		if(check==true) {
			// like 있는 경우로 삭제 
			likeBO.deleteLike(userId, postId);
		}else {
			// like 없는 경우로 추가
			likeBO.addLike(userId, postId);
		}
		
		Map<String, String> result = new HashMap<>();
		
		return result;
	}
}
