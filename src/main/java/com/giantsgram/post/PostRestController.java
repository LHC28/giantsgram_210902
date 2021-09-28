package com.giantsgram.post;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.giantsgram.post.bo.PostBO;
import com.giantsgram.post.model.Post;

@RestController
@RequestMapping("/post")
public class PostRestController {
	
	@Autowired
	private PostBO postBO;
	

	@PostMapping("/create")
	public Map<String, String> postCreate(
			@RequestParam("content") String content
			,@RequestParam(value="images", required=false) List<MultipartFile> files
			,HttpServletRequest request
			){
		
		// 세션 값 가져오기
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		String loginId = (String) session.getAttribute("loginId");
		// 등록하기
		postBO.postCreate(userId, loginId, content, files);
		
		// 결과 보내기
		Map<String, String> result = new HashMap<>();
		
		// 여기까지 에러없이 진행된다면 성공한 것이기 때문에 아래 값을 넘긴다.
		result.put("result", "success");
		
		return result;
	}
	
	@PostMapping("/post_delete")
	public Map<String, String> postDelete(
			@RequestParam("postId") int postId
			,HttpServletRequest request
			){
		HttpSession session = request.getSession();
		
		// 로그인한 유저의 id가져오기
		int userId = (int)session.getAttribute("userId");
		
		
		Map<String, String> result = new HashMap<>();
		boolean check = postBO.postDelete(userId, postId);
		if(check==true) {
			result.put("result", "success");
		}else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@PostMapping("/individual_page")
	public Map<String, String> individualPage(
			@RequestParam("postId") int postId
			){
		Map<String, String> result = new HashMap<>();
		Post post = postBO.getPostByPostId(postId);
		if(post!=null) {
			result.put("result", "success");
		}else {
			result.put("result", "fail");
		}
		return result;
	}
}
