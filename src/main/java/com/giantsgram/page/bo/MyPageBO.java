package com.giantsgram.page.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giantsgram.post.bo.PostBO;
import com.giantsgram.post.model.Post;
import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@Service
public class MyPageBO {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private PostBO postBO;
	
	public User getUserById(int userId) {
		return userBO.getUserById(userId);
	}
	
	public int countPost(int userId) {
		return postBO.countPost(userId);
	}
	
	public List<Post> getPostListByUserId(int userId){
		return postBO.getPostListByUserId(userId);
	}
}
