package com.giantsgram.timeline;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.giantsgram.post.bo.PostBO;
import com.giantsgram.timeline.bo.TimelineBO;
import com.giantsgram.timeline.domain.Timeline;
import com.giantsgram.user.model.User;

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private TimelineBO timelineBO;
	// 타임라인
	@RequestMapping("/post_list_view")
	public String postlist(
			Model model
			,HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		int userId = (int)session.getAttribute("userId");
		String nickname = (String)session.getAttribute("nickname");
		String imagePath = (String)session.getAttribute("imagePath");
		
		// 게시글 가져오기
		List<Timeline> timelineList = timelineBO.getTimelineList(userId);
		

		// 나와 친구 맺지 않은 친구 리스트 가져오기 (친구리스트 + 해당 친구의 user 정보)
		List<User> notFriendList = new ArrayList<>();
		notFriendList = timelineBO.getNotFriendList(userId);
		
		model.addAttribute("timelineList", timelineList);
		model.addAttribute("notFriendList", notFriendList);
		model.addAttribute("view", "timeline/timelineList");
		return "template/layout";
	}
	// 게시글 추가 창
	@RequestMapping("/post")
	public String post(Model model) {
		
		model.addAttribute("view", "timeline/post");
		return "template/layout";
	}
}
