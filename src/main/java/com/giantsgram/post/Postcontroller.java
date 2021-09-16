package com.giantsgram.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.giantsgram.post.bo.PostBO;
import com.giantsgram.timeline.bo.TimelineBO;
import com.giantsgram.timeline.domain.Timeline;

@Controller
@RequestMapping("/post")
public class Postcontroller {

	@Autowired
	private PostBO postBO;
	
	@Autowired
	private TimelineBO timelineBO;
	
	@RequestMapping("/add_post")
	public String addPost(Model model) {
		
		model.addAttribute("view", "post/post");
		return "template/layout";
	}
	
	@RequestMapping("/post_view")
	public String post(
			Model model
			,@RequestParam("postId") int postId
			) {
		// url로 넘겨받은 postId를 활용하여 게시글 정보 가져오기
		Timeline timeline = timelineBO.getTimeline(postId);
		
		model.addAttribute("timeline", timeline);
		model.addAttribute("view", "timeline/post");
		return "template/layout";
	}
}
