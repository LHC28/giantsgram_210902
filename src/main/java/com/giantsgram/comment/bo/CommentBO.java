package com.giantsgram.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giantsgram.comment.dao.CommentDAO;
import com.giantsgram.comment.model.Comment;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;

	public List<Comment> getCommentList(int postId){
		List<Comment> commentList = new ArrayList<>();
		commentList = commentDAO.getCommentList(postId);
		return commentList;
	}
	
	public void addComment(int userId, String nickname, int postId, String content) {
		commentDAO.addComment(userId, nickname, postId, content);
	}
	
	public void deleteComment(int userId, int postId) {
		commentDAO.deleteComment(userId, postId);
	}
}
