package kr.co.hotdeal.member.vo;

import lombok.Data;

@Data
public class MemberVO {
    private int memberId;       // 회원 번호 (PK)
    private String username;    // 아이디
    private String password;    // 비밀번호(암호화 필요)
    private String name;        // 이름
    private String email;       // 이메일
    private String regDate;     // 가입일 (String 또는 Date)
}
