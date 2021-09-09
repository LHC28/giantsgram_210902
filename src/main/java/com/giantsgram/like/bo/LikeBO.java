package com.giantsgram.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giantsgram.like.dao.LikeDAO;
import com.giantsgram.like.model.Like;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;

	public Integer getLikeCount(int postId) {
		Integer num = likeDAO.getLikeCount(postId); // 없는 경우도 생각하기 위해 Integer 사용.
		return num;
	}
	
	public boolean getLikeClick(int userId, int postId) {
		Like like = likeDAO.getLikeClick(userId, postId); 
		if(like!=null) {
			return true;
		}else {
			return false;
		}
	}
	
	public void deleteLike(int userId, int postId) {
		likeDAO.deleteLike(userId, postId);
	}
	
	public void addLike(int userId, int postId) {
		likeDAO.addLike(userId, postId);
	}
	
}
