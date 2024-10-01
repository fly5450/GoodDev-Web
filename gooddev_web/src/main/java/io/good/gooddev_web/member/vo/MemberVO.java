package io.good.gooddev_web.member.vo;

import java.util.Date;

import io.good.gooddev_web.member.dto.MemberDTO;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
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
    private String mid;            // 회원 아이디

    @NotEmpty(message = "비밀번호는 필수입니다.")
    private String password;       // 회원 비밀번호

    @NotEmpty(message = "회원명은 필수입니다.")
    private String member_Name;     // 회원 이름

    @NotEmpty(message = "닉네임은 필수입니다.")
    private String nickname;       // 회원 닉네임

    @NotEmpty(message = "전화번호는 필수입니다.")
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

    // DTO를 VO로 변환하는 생성자
    public MemberVO(MemberDTO member) {
        this.mid = member.getMid();
        this.password = member.getPassword();
        this.member_Name = member.getMember_Name();
        this.nickname = member.getNickname();
        this.phone = member.getPhone();
        this.email = member.getEmail();
        this.auto_Login = member.getAuto_Login();
        this.last_Login_Date = member.getLast_Login_Date();
        this.last_Logout_Date = member.getLast_Logout_Date();
        this.deleteYn = member.getDeleteYn();
        this.isAdminYn = member.getIsAdminYn();
        this.signup_Date = member.getSignup_Date();
        this.signout_Date = member.getSignout_Date();
        this.class_No = member.getClass_No();
    }
}
