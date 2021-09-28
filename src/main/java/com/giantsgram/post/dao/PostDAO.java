package com.giantsgram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.post.model.Post;
import com.giantsgram.post.model.UploadFile;

@Repository
public interface PostDAO {

	public void insertPost(
			@Param("userId") int userId
			,@Param("loginId") String loginId
			,@Param("content") String content
			);
	
	public void insertFile(
			@Param("userId") int userId
			,@Param("postId") int postId
			,@Param("imagePath") String imagePath);

	
	public Post selectPost(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public Post selectPostByPostId(int postId);
	
	public List<Post> selectPostList();
	
	public List<UploadFile> selectFiles(int postId);
	
	public void deletePost(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public int countPost(int userId);
	
	public List<Post> selectPostListByUserId(int userId);
	
	public void insertImagePath(
			@Param("userId") int userId
			,@Param("imagePath") String imagePath);
}
