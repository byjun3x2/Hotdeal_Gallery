package kr.co.hotdeal.member.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private int memberId;
	private String username;
	private String password;
	private String name;
	private String email;
	private String regDate;

	// [ADD] 역할(Role) 필드 추가
	private String role;
	
	// Getter/Setter 추가
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
}