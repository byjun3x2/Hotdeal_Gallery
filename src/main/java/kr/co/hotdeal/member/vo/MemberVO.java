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

	private String role;

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}