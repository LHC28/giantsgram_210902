package com.giantsgram.user.bo;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.giantsgram.common.FileManagerService;
import com.giantsgram.user.dao.UserDAO;
import com.giantsgram.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public void addUser(String loginId, String password, String name, String phoneNumber, String email) {
		userDAO.addUser(loginId, password, name, phoneNumber, email);
	}
	
	public User duplicatedId(String loginId) {
		return userDAO.duplicatedId(loginId);
	}
	
	public User getUser(String loginId, String password) {
		return userDAO.selectUser(loginId, password);
	}
	
	public User getUserById(int userId) {
		return userDAO.selectUserById(userId);
	}
	
	public void profileChange(int userId, String loginId, String name, String nickname, String phoneNumber, String email, MultipartFile file) {
		String imagePath = null;
		if(file!=null) {
			try {
				imagePath = fileManagerService.saveFile(loginId, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		userDAO.profileChange(userId, name, nickname, phoneNumber, email, imagePath);
	}
}
