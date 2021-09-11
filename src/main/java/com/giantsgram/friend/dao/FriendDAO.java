package com.giantsgram.friend.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.giantsgram.friend.model.Friend;

@Repository
public interface FriendDAO {

	public List<Friend> getFriendList(int userId);
	
}
