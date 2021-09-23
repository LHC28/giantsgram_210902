package com.giantsgram.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.like.model.Like;

@Repository
public interface LikeDAO {

	public void insertLike(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public Integer selectLikeCount(int postId);
	
	public Like selectLikeClick(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
	public void deleteLike(
			@Param("userId") int userId
			,@Param("postId") int postId);
	
}
