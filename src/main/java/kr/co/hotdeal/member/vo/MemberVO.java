package kr.co.hotdeal.member.vo;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class MemberVO {
    private int memberId;       // 회원 번호 (PK)

    @NotBlank(message = "아이디는 필수입니다.")
    @Size(min = 4, max = 30, message = "아이디는 4~30자여야 합니다.")
    private String username;    // 아이디

    @NotBlank(message = "비밀번호는 필수입니다.")
    @Size(min = 8, max = 30, message = "비밀번호는 8~30자여야 합니다.")
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]{8,30}$",
             message = "비밀번호는 영문과 숫자를 모두 포함해야 합니다.")
    private String password;    // 비밀번호(암호화 필요)

    @NotBlank(message = "이름은 필수입니다.")
    @Size(min = 2, max = 30, message = "이름은 2~30자여야 합니다.")
    private String name;        // 이름

    @NotBlank(message = "이메일은 필수입니다.")
    @Email(message = "이메일 형식이 올바르지 않습니다.")
    private String email;       // 이메일

    private String regDate;     // 가입일 (String 또는 Date)
}
