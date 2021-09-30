package com.giantsgram.page;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giantsgram.friend.bo.FriendBO;
import com.giantsgram.friend.model.Friend;
import com.giantsgram.page.bo.MyPageBO;
import com.giantsgram.page.model.PostWithImage;
import com.giantsgram.post.model.Post;
import com.giantsgram.post.model.UploadFile;
import com.giantsgram.user.bo.UserBO;
import com.giantsgram.user.model.User;

@Controller
@RequestMapping("/page")
public class MyPageController {

	@Autowired
	private MyPageBO myPageBO;
	
	@Autowired
	private FriendBO friendBO;
	
	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/my_page_view")
	public String pageView(
			Model model
			,HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		String nickname = (String)session.getAttribute("nickname");
		// MyPageBO를 거치지 않아도 되는지 확인...
		// 로그인 된 유저의 값을 가져와서 활용
		User user = myPageBO.getUserById(userId); 
		
		//게시물 갯수 가져오기
		int count = myPageBO.countPost(userId);
		
		//게시물 가져오기
		List<Post> postList = new ArrayList<>();
		postList = myPageBO.getPostListByUserId(userId);
		
		// 이미지 가져오기
		// postList순으로 가져오기 때문에 순서는 같다.
		List<UploadFile> imageList = new ArrayList<>();
		imageList = myPageBO.getImageListByPostId(postList);
		// post와 image를 같이 묶기
		List<PostWithImage> postWithImage = new ArrayList<>();
		
		for(int i=0; i<postList.size(); i++) {
			PostWithImage postWithImageSingle = new PostWithImage();
			postWithImageSingle.setPost(postList.get(i));
			postWithImageSingle.setUploadFile(imageList.get(i));
			
			postWithImage.add(postWithImageSingle);
		}
		
		// 친구 수 가져오기
		List<Friend> friendList = new ArrayList<>();
		friendList = friendBO.getFriendList(userId);
		int friendCount = friendList.size();
		
		model.addAttribute("user", user);
		model.addAttribute("postCount",count);
		model.addAttribute("postWithImage", postWithImage);
		model.addAttribute("friendCount", friendCount);
		model.addAttribute("view", "page/personal_page");
		return "template/layout";
	}
	
	@RequestMapping("/user_page_view")
	public String userPageView(
			Model model
			,@RequestParam("userId") int userId
			) {
		// 로그인 된 유저의 값을 가져와서 활용
		User user = myPageBO.getUserById(userId); 
		
		//게시물 갯수 가져오기
		int count = myPageBO.countPost(userId);
		
		//게시물 가져오기
		List<Post> postList = new ArrayList<>();
		postList = myPageBO.getPostListByUserId(userId);
		
		// 친구 수 가져오기
		List<Friend> friendList = new ArrayList<>();
		friendList = friendBO.getFriendList(userId);
		int friendCount = friendList.size();
		
		model.addAttribute("user", user);
		model.addAttribute("postCount",count);
		model.addAttribute("postList", postList);
		model.addAttribute("friendCount", friendCount);
		model.addAttribute("view", "page/personal_page");
		return "template/layout";
	}
	
	@RequestMapping("/change_profile_view")
	public String changeProfileView(
			Model model
			,HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		User user = userBO.getUserById(userId);
		
		model.addAttribute("user", user);
		model.addAttribute("view", "user/change_profile");
		return "template/layout";
	}
	
}
