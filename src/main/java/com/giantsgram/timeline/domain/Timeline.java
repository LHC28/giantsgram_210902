package com.giantsgram.timeline.domain;

import java.util.List;

import com.giantsgram.comment.model.Comment;
import com.giantsgram.post.model.Post;
import com.giantsgram.user.model.User;

public class Timeline {

	private User user;
	private Post post; // 게시물
	private List<Comment> commentList; // 게시물에 대한 댓글리스트
	private int Like; // 게시물에 있는 좋아요 갯수
	private boolean likeClick; // 접속유저라 좋아요를 눌렀는지 확인하기
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	public int getLike() {
		return Like;
	}
	public void setLike(int like) {
		Like = like;
	}
	public boolean isLikeClick() {
		return likeClick;
	}
	public void setLikeClick(boolean likeClick) {
		this.likeClick = likeClick;
	}
	
}
