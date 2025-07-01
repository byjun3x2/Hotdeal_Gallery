package kr.hotdeal;

import kr.co.hotdeal.member.dao.MemberDAO;
import kr.co.hotdeal.member.vo.MemberVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class MemberDAOTest {

    @Autowired
    private MemberDAO memberDAO;

    /**
     * 회원과 연관된 모든 데이터를 안전하게 삭제하는 헬퍼 메서드
     */
    private void safeDeleteMember(String username) {
        try {
            // 1. 댓글 삭제 (대댓글도 포함)
            memberDAO.deleteCommentsByUsername(username);
        } catch (Exception e) {
            // 댓글이 없을 수도 있음
        }
        
        try {
            // 2. 투표 기록 삭제
            memberDAO.deleteVotesByUsername(username);
        } catch (Exception e) {
            // 투표 기록이 없을 수도 있음
        }
        
        try {
            // 3. 신고 기록 삭제
            memberDAO.deleteReportsByUsername(username);
        } catch (Exception e) {
            // 신고 기록이 없을 수도 있음
        }
        
        // 4. 회원 삭제
        memberDAO.deleteMemberByUsername(username);
    }

    @Test
    public void testInsertAndSelectMember() {
        // 안전한 회원 삭제
        safeDeleteMember("testuser1");

        // 회원 등록
        MemberVO member = new MemberVO();
        member.setUsername("testuser1");
        member.setPassword("testpass1");
        member.setName("테스트유저1");
        member.setEmail("testuser1@example.com");
        member.setRole("USER"); // 입력값은 USER

        memberDAO.insertMember(member);

        // 검증 - 실제 DB에서는 ROLE_USER로 저장됨
        MemberVO result = memberDAO.selectMemberByUsername("testuser1");
        assertNotNull(result);
        assertEquals("testuser1", result.getUsername());
        assertEquals("테스트유저1", result.getName());
        assertEquals("ROLE_USER", result.getRole()); // ← 수정: ROLE_USER로 검증
    }

    @Test
    public void testLogin() {
        MemberVO loginResult = memberDAO.login("testuser1", "testpass1");
        assertNotNull(loginResult);
        assertEquals("testuser1", loginResult.getUsername());
    }

    @Test
    public void testSelectAllMembers() {
        List<MemberVO> members = memberDAO.selectAllMembers();
        assertNotNull(members);
        assertTrue(members.size() > 0);
    }

    @Test
    public void testDeleteMemberByUsername() {
        // 안전한 회원 삭제
        safeDeleteMember("testuser1");
        
        // 삭제 확인
        MemberVO deleted = memberDAO.selectMemberByUsername("testuser1");
        assertNull(deleted);
    }
}
