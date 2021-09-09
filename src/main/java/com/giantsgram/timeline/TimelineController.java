package com.giantsgram.timeline;

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

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private TimelineBO timelineBO;

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
		model.addAttribute("timelineList", timelineList);
		model.addAttribute("view", "timeline/timelineList");
		return "template/layout";
	}
	
	@RequestMapping("/post")
	public String post(Model model) {
		
		model.addAttribute("view", "timeline/post");
		return "template/layout";
	}
}
