package kr.co.hotdeal.comment.dao;

import kr.co.hotdeal.comment.vo.CommentVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CommentDAOImpl implements CommentDAO {

    private static final String NAMESPACE = "kr.co.hotdeal.comment.dao.CommentDAO.";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<CommentVO> getCommentList(int hotdealId) {
        return sqlSessionTemplate.selectList(NAMESPACE + "getCommentList", hotdealId);
    }

    @Override
    public void insertComment(CommentVO vo) {
        sqlSessionTemplate.insert(NAMESPACE + "insertComment", vo);
    }
    
    @Override
    public void deleteAllComments() {
        sqlSessionTemplate.delete(NAMESPACE + "deleteAllComments");
    }
}
