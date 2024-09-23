package com.gooddev.member;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {

    private String mid; // 아이디
    private String password; // 비밀번호
    private String memberName; // 회원명(실명)
    private String nickname; // 닉네임
    private String phone; // 전화번호
    private String email; // 이메일
    private String autoLogin; // 자동로그인 key
    private Date lastLoginDate; // 마지막 로그인
    private Date lastLogoutDate; // 마지막 로그아웃
    private char deleteYn; // 삭제 여부
    private char isAdminYn; // 관리자 여부
    private Date signupDate; // 가입날짜
    private Date signoutDate; // 탈퇴날짜(비활성화)

    // Getters and Setters
    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAutoLogin() {
        return autoLogin;
    }

    public void setAutoLogin(String autoLogin) {
        this.autoLogin = autoLogin;
    }

    public Date getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(Date lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public Date getLastLogoutDate() {
        return lastLogoutDate;
    }

    public void setLastLogoutDate(Date lastLogoutDate) {
        this.lastLogoutDate = lastLogoutDate;
    }

    public char getDeleteYn() {
        return deleteYn;
    }

    public void setDeleteYn(char deleteYn) {
        this.deleteYn = deleteYn;
    }

    public char getIsAdminYn() {
        return isAdminYn;
    }

    public void setIsAdminYn(char isAdminYn) {
        this.isAdminYn = isAdminYn;
    }

    public Date getSignupDate() {
        return signupDate;
    }

    public void setSignupDate(Date signupDate) {
        this.signupDate = signupDate;
    }

    public Date getSignoutDate() {
        return signoutDate;
    }

    public void setSignoutDate(Date signoutDate) {
        this.signoutDate = signoutDate;
    }
}
