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
		List<Friend> friendList = new ArrayList<>();
		// 저장할 때 유저아이디를 기준으로 친구아이디와 저장하기 때문에 반대인 경우도 있을 수 있다. 따라서 두 가지 경우를 모두 고려하기
		// 위해 반대인 경우도 가져오도록 하였다.
		// 친구DB 기준으로 유저id와 접속한 유저의 id가 같은 데이터 가져오기
		List<Friend> friendListByUserId = friendDAO.getFriendListByUserId(userId);
		// 친구DB 기준으로 친구id와 접속한 유저의 id가 같은 데이터 가져오기
		List<Friend> friendListByFriendId = friendDAO.getFriendListByFriendId(userId);

		for(int i=0; i<friendListByUserId.size(); i++) {
			friendList.add(friendListByUserId.get(i));
		}
		for(int i=0; i<friendListByFriendId.size(); i++) {
			friendList.add(friendListByFriendId.get(i));
		}
		
		return friendList;
	}
	
	// 친구 추가
	public void addFriend(int userId, int friendId){
		friendDAO.addFriend(userId, friendId);
	}
	
	// 친구 삭제
	public void deleteFriend(int userId, int friendId) {
		friendDAO.deleteFriend(userId, friendId);
		friendDAO.deleteFriend(friendId, userId);
	}
	
	
}
