package kr.co.hotdeal.member.dao;

import kr.co.hotdeal.member.vo.MemberVO;
import java.util.List; // import 추가

public interface MemberDAO {
	void insertMember(MemberVO member);

	MemberVO selectMemberByUsername(String username);

	MemberVO selectMemberById(int memberId);

	MemberVO login(String username, String password);

	void deleteMemberByUsername(String username);

	MemberVO selectMemberByEmail(String email);

	List<MemberVO> selectAllMembers();

	void deleteVotesByUsername(String username);

	void deleteCommentsByUsername(String username);

	void deleteReportsByUsername(String username);
}