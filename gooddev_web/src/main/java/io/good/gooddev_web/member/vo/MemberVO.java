package io.good.gooddev_web.member.vo;

import java.util.Date;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
    @NotEmpty(message = "아이디는 필수입니다.")
    @Size(min = 4, max = 20, message = "아이디는 4자 이상 20자 이하로 입력해주세요.")
    private String mid;            // 회원 아이디

    @NotEmpty(message = "비밀번호는 필수입니다.")
    @Size(min = 6, max = 20, message = "비밀번호는 6자 이상 20자 이하로 입력해주세요.")
    private String password;       // 회원 비밀번호

    @NotEmpty(message = "회원명은 필수입니다.")
    @Size(min = 2, max = 20, message = "회원명은 2자 이상 20자 이하로 입력해주세요.")
    private String member_name;     // 회원 이름

    @NotEmpty(message = "닉네임은 필수입니다.")
    private String nickname;       // 회원 닉네임

    @NotEmpty(message = "전화번호는 필수입니다.")
    @Pattern(regexp = "^\\d{3}-\\d{3,4}-\\d{4}$", message = "전화번호는 010-0000-0000 형식으로 입력해주세요.")
    private String phone;          // 전화번호

    @Email(message = "유효한 이메일 주소를 입력하세요.")
    private String email;          // 이메일
    
    private String auto_Login;     // 자동로그인 key
    private Date last_Login_Date;  // 마지막 로그인
    private Date last_Logout_Date; // 마지막 로그아웃
    private char deleteYn;         // 삭제 여부
    private char isAdminYn;        // 관리자 여부
    private Date signup_Date;      // 가입 날짜
    private Date signout_Date;     // 탈퇴 날짜
    private int class_No;          // 분류 번호

}
