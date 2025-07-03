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
@ContextConfiguration(locations = { "classpath:config/spring/spring-mvc.xml" })
public class MemberDAOTest {

	@Autowired
	private MemberDAO memberDAO;

	private void safeDeleteMember(String username) {
		try {

			memberDAO.deleteCommentsByUsername(username);
		} catch (Exception e) {

		}

		try {

			memberDAO.deleteVotesByUsername(username);
		} catch (Exception e) {

		}

		try {

			memberDAO.deleteReportsByUsername(username);
		} catch (Exception e) {

		}

		memberDAO.deleteMemberByUsername(username);
	}

	@Test
	public void testInsertAndSelectMember() {

		safeDeleteMember("testuser1");

		MemberVO member = new MemberVO();
		member.setUsername("testuser1");
		member.setPassword("testpass1");
		member.setName("테스트유저1");
		member.setEmail("testuser1@example.com");
		member.setRole("USER");

		memberDAO.insertMember(member);

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

		safeDeleteMember("testuser1");

		MemberVO deleted = memberDAO.selectMemberByUsername("testuser1");
		assertNull(deleted);
	}
}
