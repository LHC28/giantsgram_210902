package com.giantsgram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.post.model.Post;

@Repository
public interface PostDAO {

	public void postCreate(
			@Param("userId") int userId
			,@Param("loginId") String loginId
			,@Param("content") String content
			,@Param("imagePath") String imagePath
			);
	
	public Post getPost(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public List<Post> getPostList();
	
	public void postDelete(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public int countPost(int userId);
	
	public List<Post> getPostListByUserId(int userId);
}
