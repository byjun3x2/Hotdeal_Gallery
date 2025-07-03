package kr.co.hotdeal.comment.service;

import kr.co.hotdeal.comment.dao.CommentDAO;
import kr.co.hotdeal.comment.vo.CommentVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

	private final CommentDAO commentDAO;

	public List<CommentVO> getCommentList(int hotdealId) {
		return commentDAO.getCommentList(hotdealId);
	}

	public void insertComment(CommentVO vo) {
		commentDAO.insertComment(vo);
	}
}
