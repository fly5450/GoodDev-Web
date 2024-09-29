package io.good.gooddev_web.member.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDTO {
    private String mid; // 아이디
    private String password; // 비밀번호
    private String memberName; // 회원명(실명)
    private String nickname; // 닉네임
    private String phone; // 전화번호
    private String email; // 이메일
    private String auto_Login; // 자동로그인 key
    private Date last_Login_Date; // 마지막 로그인
    private Date last_Logout_Date; // 마지막 로그아웃
    private char deleteYn; // 삭제 여부
    private char isAdminYn; // 관리자 여부
    private Date signup_Date; // 가입날짜
    private Date signout_Date; // 탈퇴날짜
    private int class_No;

    public MemberDTO(String mid, String password) {
         // 추가 생성자: 아이디와 비밀번호만으로 객체 생성
        this.mid = mid;
        this.password = password;
        // 나머지 필드는 기본값으로 초기화(필요하다면 기존 생성자에 필드를 추가하도록 수정)
        this.memberName = "";
        this.nickname = "";
        this.phone = "";
        this.email = "";
        this.auto_Login = "";
        this.last_Login_Date = new Date();
        this.last_Logout_Date = new Date();
        this.deleteYn = 'N'; // 기본값
        this.isAdminYn = 'N'; // 기본값
        this.signup_Date = new Date(); // 기본값
        this.signout_Date = null; // 기본값
    }
}