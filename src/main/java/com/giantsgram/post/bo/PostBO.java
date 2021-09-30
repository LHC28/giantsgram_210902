package com.giantsgram.post.bo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.giantsgram.common.FileManagerService;
import com.giantsgram.post.dao.PostDAO;
import com.giantsgram.post.model.Post;
import com.giantsgram.post.model.UploadFile;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void postCreate(int userId, String loginId, String content, List<MultipartFile> files) {
		// 업로드 하는 이미지가 하나인 경우 활용
		String imagePath = null;
		// 업로드 하는 이미지가 둘 이상인 경우 활용
		List<String> imagePaths = null;
		
		// 업로드 하는 파일이 하나인 경우
		if(files.size()==1) {
			try {
				// 파일 가져오는 방식 변경
				imagePath = fileManagerService.saveFile(loginId, files.get(0));
				postDAO.insertPost(userId, loginId, content);
				List<Post> posts = postDAO.selectPostListByUserId(userId);
				// file DB에 파일 넣기.
				postDAO.insertFile(userId, posts.get(0).getId(), imagePath);
				System.out.println("########"+posts.get(posts.size()-1).getId());
			} catch (IOException e) {
				e.printStackTrace();
			}
		// 업로드 하는 파일이 둘 이상인 경우
		}else if(files.size()>1) {
			try {
				imagePaths = fileManagerService.saveFiles(loginId, files);
				postDAO.insertPost(userId, loginId, content);
				List<Post> posts = postDAO.selectPostListByUserId(userId);
				// file DB에 파일 넣기
				for(int i=0; i<imagePaths.size(); i++) {
					// imagePath에 저장된 것들을 하나씩 저장하는 과정.
					postDAO.insertFile(userId, posts.get(0).getId(), imagePaths.get(i));
					
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public Post getPostByPostId(int postId) {
		return postDAO.selectPostByPostId(postId);
	}
	
	public List<Post> getPostList(){
		return postDAO.selectPostList();
	}
	
	// 이미지가 여러 개인 경우 여러 개를 모두 가져온다.
	public List<UploadFile> getUploadFiles(int postId){
		return postDAO.selectFiles(postId);
	}
	// 여기서는 여러 개 있는 경우도 하나만 가져오도록 한다.
	public List<UploadFile> getImageListByPostId(List<Post> postList){
		List<UploadFile> imageList = new ArrayList<>();
		for(int i=0; i<postList.size(); i++) {
			UploadFile image = postDAO.selectFileByPostIdOneFile(postList.get(i).getId());
			imageList.add(image);
		}
		return imageList;
	}
	
	public boolean postDelete(int userId, int postId) {
		Post post = postDAO.selectPost(userId, postId);
		if(post!=null) {
			postDAO.deletePost(userId, postId);
			return true;
		}else {
			return false;
		}
		
	}
	
	public int countPost(int userId) {
		return postDAO.countPost(userId);
	}
	
	public List<Post> getPostListByUserId(int userId){
		return postDAO.selectPostListByUserId(userId);
	}
	
	public void addFileList(int userId, String loginId, List<MultipartFile> fileList) {
		List<String> imagePaths = null;
		try {
			imagePaths = fileManagerService.saveFiles(loginId, fileList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		for(int i=0; i<imagePaths.size(); i++) {
			logger.info("###########"+imagePaths.get(i));
			postDAO.insertImagePath(userId, imagePaths.get(i));
		}
	}
}
