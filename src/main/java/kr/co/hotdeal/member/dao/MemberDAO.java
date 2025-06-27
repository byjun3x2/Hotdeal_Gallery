package kr.co.hotdeal.member.dao;

import kr.co.hotdeal.member.vo.MemberVO;

public interface MemberDAO {
    void insertMember(MemberVO member);
    MemberVO selectMemberByUsername(String username);
    MemberVO selectMemberById(int memberId);
    MemberVO login(String username, String password);
    
    void deleteMemberByUsername(String username);
    
    void deleteAllMembers(); // 전체 회원 삭제
}
