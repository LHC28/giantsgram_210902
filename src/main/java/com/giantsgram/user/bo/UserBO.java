package com.giantsgram.user.bo;

import java.io.IOException;
import java.util.List;

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
		userDAO.insertUser(loginId, password, name, phoneNumber, email);
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
		
		userDAO.updateProfile(userId, name, nickname, phoneNumber, email, imagePath);
	}
	
	//전체 유저 리스트 가져오기
	public List<User> getUserList(){
		return userDAO.selectUserList();
	}
	
	public String getLoginIdByNameAndEmail(String name, String email) {
		return userDAO.selectLoginIdMyNameAndEmail(name, email);
	}
	
	public boolean getEmailByNameAndEmail(String loginId, String email) {
		String getEmail = userDAO.selectEmailByLoginId(loginId);
		if(email.equals(getEmail)) {
			return true;
		}else {
			return false;
		}
	}
	
	public void changePasswordByLoginId(String loginId, String password) {
		userDAO.updatePasswordByloginId(loginId, password);
	}
}
