package com.giantsgram.friend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.friend.model.Friend;

@Repository
public interface FriendDAO {

	public List<Friend> getFriendList(int userId);
	
	public void addFriend(
			@Param("userId") int userId
			,@Param("friendId") int friendId);
	
	public void deleteFriend(
			@Param("userId") int userId
			,@Param("friendId") int friendId);
	
}
