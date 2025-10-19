package kr.co.hotdeal.comment.dao;

import kr.co.hotdeal.comment.vo.CommentVO;
import java.util.List;

public interface CommentDAO {
	List<CommentVO> getCommentList(int hotdealId);

	void insertComment(CommentVO vo);

	void updateComment(CommentVO vo);

	void deleteComment(int commentId);

	int countChildComments(int parentId);
}
