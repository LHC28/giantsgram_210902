package com.giantsgram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giantsgram.comment.bo.CommentBO;
import com.giantsgram.comment.model.Comment;
import com.giantsgram.friend.bo.FriendBO;
import com.giantsgram.friend.model.Friend;
import com.giantsgram.friend.model.FriendUser;
import com.giantsgram.like.bo.LikeBO;
import com.giantsgram.post.bo.PostBO;
import com.giantsgram.post.model.Post;
import com.giantsgram.timeline.domain.Timeline;
import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private FriendBO friendBO;
	
	public List<Timeline> getTimelineList(int userId){ 
		// 여기서 userId는 로그인 여부를 확인하는 용도로 사용. 여기서 가져오지 않으면 다른 곳에서 가져올 방법이 마땅치 않을듯 싶다.
		// int인 이유는 사이트 게시물을 보기 위해서는 무조건 로그인을 해야하기 때문에 userId가 null값이 있을 수 없기 때문.
		List<Timeline> timelineList = new ArrayList();
		
		// 게시물 리스트
		List<Post> postList = new ArrayList<>();
		postList = postBO.getPostList();
		
		// 가져온 포스트 리스트를 활용하여 반복 시행
		for(Post post:postList) {
			Timeline timeline = new Timeline(); // timeline 게시물 하나씩 만들어서 리스트에 넣기
			
			// 게시글 넣기
			timeline.setPost(post);
			
			// 유저 정보 넣기
			User user = userBO.getUserById(post.getUserId());
			timeline.setUser(user);
			
			// 댓글 넣기
			List<Comment> commentList = new ArrayList<>();
			commentList = commentBO.getCommentList(post.getId());
			timeline.setCommentList(commentList);
			
			// 좋아요 넣기
			int likeCount = likeBO.getLikeCount(post.getId());
			timeline.setLike(likeCount);
			
			// 로그인된 유저가 게시물별로 좋아요를 눌렀는지 여부
			boolean likeClick = likeBO.getLikeClick(userId, post.getId());
			timeline.setLikeClick(likeClick);
			
			// timelineList에 timeline 넣기
			timelineList.add(timeline);
		}
		
		return timelineList;
	}
	// 친구리스트 가져오기
	public List<FriendUser> getFriendList(int userId){
		List<FriendUser> friendList = new ArrayList<>(); 
		
		// 친구 목록
		List<Friend> friends = friendBO.getFriendList(userId); 
		// 친구에 대한 유저 정보 가져오기
		for(Friend friend:friends) {
			FriendUser friendUser = new FriendUser();
			// 친구 목록 가져오기
			friendUser.setFriend(friend);
			// 친구의 id로 친구의 user정보 가져오기
			User user = userBO.getUserById(friend.getFriendId());
			// 유저정보 넣기
			friendUser.setUser(user);
			
			friendList.add(friendUser);
		}
		return friendList;
	}
	
	public List<User> getNotFriendList(int userId){
		List<User> notFriendList = new ArrayList<>();
		
		// 친구 목록
		List<Friend> friendList = friendBO.getFriendList(userId);
		// 유저목록
		List<User> userList = userBO.getUserList();
		// 유저목록을 반복하여 친구목록에 있는지 확인하고 없는 것을 notFriendList에 넣기
		for(User user:userList) {
			if(user.getId()!=userId && friendList.contains(user)==false) {
				notFriendList.add(user);
			}
		}
		return notFriendList;
	}
	
	
}
