package kr.co.hotdeal.member.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.hotdeal.member.dao.MemberDAO;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

	private final MemberDAO memberDAO;

	public void join(MemberVO member) {
		memberDAO.insertMember(member);
	}

	public MemberVO getMemberByUsername(String username) {
		return memberDAO.selectMemberByUsername(username);
	}

	public MemberVO getMemberById(int memberId) {
		return memberDAO.selectMemberById(memberId);
	}

	public MemberVO login(String username, String password) {
		return memberDAO.login(username, password);
	}

	public MemberVO getMemberByEmail(String email) {
		return memberDAO.selectMemberByEmail(email);
	}

	public List<MemberVO> getAllMembers() {
		return memberDAO.selectAllMembers();
	}
}
