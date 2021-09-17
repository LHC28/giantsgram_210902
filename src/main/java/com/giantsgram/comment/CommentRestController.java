package com.giantsgram.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.giantsgram.comment.bo.CommentBO;

@RestController
@RequestMapping("/comment")
public class CommentRestController {
	
	@Autowired
	private CommentBO commentBO;

	@RequestMapping("/comment_create")
	public Map<String, String> commentCreate(
			@RequestParam("userId") int userId
			,@RequestParam("postId") int postId
			,@RequestParam("content") String content
			,HttpServletRequest request
			){
		HttpSession session = request.getSession();
		String nickname = (String)session.getAttribute("nickname");
		commentBO.addComment(userId, nickname, postId, content);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		return result;
	}
	
	@RequestMapping("/comment_delete")
	public Map<String, String> commentDelete(
			@RequestParam("commentId") int commentId
			,HttpServletRequest request
			){
		Map<String, String> result = new HashMap<>();
		
		HttpSession session = request.getSession();
		int loginUserId = (int)session.getAttribute("userId");
		commentBO.deleteComment(commentId);
		result.put("result", "success");
		
		return result;
	}
}
