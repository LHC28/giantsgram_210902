package com.giantsgram.friend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.friend.model.Friend;

@Repository
public interface FriendDAO {

	public List<Friend> selectFriendListByUserId(int userId);
	
	public List<Friend> selectFriendListByFriendId(int friendId);
	
	public void insertFriend(
			@Param("userId") int userId
			,@Param("friendId") int friendId);
	
	public void deleteFriend(
			@Param("userId") int userId
			,@Param("friendId") int friendId);
	
}
