package com.giantsgram.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.giantsgram.user.model.User;

@Repository
public interface UserDAO {

	public void insertUser(
			@Param("loginId") String loginId
			,@Param("password") String password
			,@Param("name") String name
			,@Param("phoneNumber") String phoneNumber
			,@Param("email") String email);
	
	public User duplicatedId(String loginId);
	
	public User selectUser(
			@Param("loginId") String loginId
			,@Param("password") String password
			);
	
	public User selectUserById(int userId);
	
	public void updateProfile(
			@Param("userId") int userId
			,@Param("name") String name
			,@Param("nickname") String nickname
			,@Param("phoneNumber") String phoneNumber
			,@Param("email") String email
			,@Param("imagePath") String imagePath);
	
	public List<User> selectUserList();
}
