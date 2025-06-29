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

    // [ADD] 관리자용: 전체 회원 목록 조회
    List<MemberVO> selectAllMembers();
}