package com.giantsgram.friend.model;

import com.giantsgram.user.model.User;

public class FriendUser {

	private Friend friend;
	private User user;
	
	public Friend getFriend() {
		return friend;
	}
	public void setFriend(Friend friend) {
		this.friend = friend;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
