package kr.co.hotdeal.comment.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.comment.service.CommentService;
import kr.co.hotdeal.comment.vo.CommentVO;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class CommentController {

	private final CommentService commentService;

	@PostMapping("/addComment")
	public String addComment(@ModelAttribute CommentVO comment, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("loginUser");
		if (user == null)
			return "redirect:/login";
		comment.setUsername(user.getUsername());
		commentService.insertComment(comment);
		return "redirect:/detail?id=" + comment.getHotdealId();
	}
}
