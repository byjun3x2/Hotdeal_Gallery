package kr.co.hotdeal.comment.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.comment.service.CommentService;
import kr.co.hotdeal.comment.vo.CommentVO;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class CommentController {

	private final CommentService commentService;

	@PostMapping(value = "/addComment", consumes = "application/json", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> addComment(@RequestBody CommentVO comment, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("loginUser");
		if (user == null) {
			result.put("success", false);
			result.put("msg", "로그인이 필요합니다.");
			return result;
		}
		comment.setUsername(user.getUsername());
		commentService.insertComment(comment);
		result.put("success", true);
		return result;
	}

	@PostMapping(value = "/updateComment", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> updateComment(@RequestBody CommentVO comment, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("loginUser");
		if (user == null) {
			result.put("success", false);
			result.put("msg", "로그인이 필요합니다.");
			return result;
		}
		comment.setUsername(user.getUsername());
		commentService.updateComment(comment);
		result.put("success", true);
		return result;
	}

	@PostMapping(value = "/deleteComment", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> deleteComment(@RequestBody Map<String, Object> req, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("loginUser");
		if (user == null) {
			result.put("success", false);
			result.put("msg", "로그인이 필요합니다.");
			return result;
		}
		int commentId = (int) req.get("commentId");
		int hotdealId = (int) req.get("hotdealId");
		List<CommentVO> commentList = commentService.getCommentList(hotdealId);
		CommentVO target = commentList.stream().filter(c -> c.getCommentId() == commentId).findFirst().orElse(null);
		if (target == null || !user.getUsername().equals(target.getUsername())) {
			result.put("success", false);
			result.put("msg", "삭제 권한이 없습니다.");
			return result;
		}
		int childCount = commentService.countChildComments(commentId);
		if (childCount > 0) {
			result.put("success", false);
			result.put("msg", "대댓글이 달려 삭제할 수 없습니다.");
			return result;
		}
		commentService.deleteComment(commentId);
		result.put("success", true);
		return result;
	}
}
