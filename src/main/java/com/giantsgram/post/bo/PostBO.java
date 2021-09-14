package com.giantsgram.post.bo;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.giantsgram.common.FileManagerService;
import com.giantsgram.post.dao.PostDAO;
import com.giantsgram.post.model.Post;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;

	public void postCreate(int userId, String loginId, String content, MultipartFile file) {
		String imagePath=null;
		if(file!=null) {
			try {
				imagePath = fileManagerService.saveFile(loginId, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		postDAO.postCreate(userId, loginId, content, imagePath);
	}
	
	public List<Post> getPostList(){
		return postDAO.getPostList();
	}
	
	public boolean postDelete(int userId, int postId) {
		Post post = postDAO.getPost(userId, postId);
		if(post!=null) {
			postDAO.postDelete(userId, postId);
			return true;
		}else {
			return false;
		}
		
	}
	
	public int countPost(int userId) {
		return postDAO.countPost(userId);
	}
	
	public List<Post> getPostListByUserId(int userId){
		return postDAO.getPostListByUserId(userId);
	}
}
