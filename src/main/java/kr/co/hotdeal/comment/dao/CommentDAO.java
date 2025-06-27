package kr.co.hotdeal.comment.dao;

import kr.co.hotdeal.comment.vo.CommentVO;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface CommentDAO {
    List<CommentVO> getCommentList(int hotdealId);
    void insertComment(CommentVO vo);
    
    void deleteAllComments(); // 전체 댓글 삭제
}

