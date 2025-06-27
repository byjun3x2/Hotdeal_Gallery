package kr.hotdeal;

import kr.co.hotdeal.member.dao.MemberDAO; // 인터페이스 import
import kr.co.hotdeal.member.vo.MemberVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class MemberDAOTest {

    @Autowired
    private MemberDAO memberDAO; // 인터페이스 타입으로 주입

    @Test
    public void testInsertAndSelectMember() {
        // 중복 데이터 삭제
        memberDAO.deleteMemberByUsername("testuser1");

        MemberVO member = new MemberVO();
        member.setUsername("testuser1");
        member.setPassword("testpass1");
        member.setName("테스트유저1");
        member.setEmail("testuser1@example.com");

        memberDAO.insertMember(member);

        MemberVO result = memberDAO.selectMemberByUsername("testuser1");
        assertNotNull(result);
        assertEquals("testuser1", result.getUsername());
        assertEquals("테스트유저1", result.getName());
    }


    @Test
    public void testLogin() {
        MemberVO loginResult = memberDAO.login("testuser1", "testpass1");
        assertNotNull(loginResult);
        assertEquals("testuser1", loginResult.getUsername());
    }
}
