package io.good.gooddev_web.member.vo;
    /*  뷰와 데이터를 주고받는 객체로, 클라이언트와의 상호작용에 중점을 둔다.
       비즈니스 로직이 포함될 수 있습니다. */
    
    public class MemberVO {

    private String mid; // 아이디
    private String password; // 비밀번호
    private String memberName; // 회원명(실명)
    private String email; // 이메일

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
