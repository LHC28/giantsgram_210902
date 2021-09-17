package com.giantsgram.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.comment.model.Comment;

@Repository
public interface CommentDAO {

	public List<Comment> getCommentList(int postId);
	
	public void addComment(
			@Param("userId") int userId
			,@Param("nickname") String nickname
			,@Param("postId") int postId
			,@Param("content") String content);
	
	public void deleteComment(int commentId);
}
