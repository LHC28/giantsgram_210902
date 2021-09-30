package com.giantsgram.page.model;

import java.util.List;

import com.giantsgram.post.model.Post;
import com.giantsgram.post.model.UploadFile;

public class PostWithImage {

	private Post post;
	private UploadFile uploadFile;
	
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public UploadFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(UploadFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	
	
}
