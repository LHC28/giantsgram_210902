package com.giantsgram.friend.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giantsgram.friend.dao.FriendDAO;
import com.giantsgram.friend.model.Friend;
import com.giantsgram.friend.model.FriendUser;
import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@Service
public class FriendBO {
	
	@Autowired
	private FriendDAO friendDAO;
	
	@Autowired
	private UserBO userBO;

	public List<Friend> getFriendList(int userId){
		return friendDAO.getFriendList(userId);
	}
	
	
	
}