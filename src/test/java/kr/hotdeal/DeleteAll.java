package kr.hotdeal;

import kr.co.hotdeal.board.dao.HotdealDAO;
import kr.co.hotdeal.comment.dao.CommentDAO;
import kr.co.hotdeal.member.dao.MemberDAO;
import kr.co.hotdeal.vote.dao.VoteDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class DeleteAll {

    @Autowired
    private VoteDAO voteDAO;
    @Autowired
    private CommentDAO commentDAO;
    @Autowired
    private HotdealDAO hotdealDAO;
    @Autowired
    private MemberDAO memberDAO;
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Test
    public void 모든_데이터_삭제() {
        // 추천/비추천 → 댓글 → 게시글 → 유저 순으로 삭제 (FK 제약 고려)
        try {
            sqlSessionTemplate.delete("kr.co.hotdeal.vote.dao.VoteDAO.deleteAllVotes");
        } catch (Exception e) {}
        try {
            commentDAO.deleteAllComments();
        } catch (Exception e) {}
        try {
            sqlSessionTemplate.delete("kr.co.hotdeal.board.dao.HotdealDAO.deleteAllHotdeals");
        } catch (Exception e) {}
        try {
            sqlSessionTemplate.delete("kr.co.hotdeal.member.dao.MemberDAO.deleteAllMembers");
        } catch (Exception e) {}
    }
} 