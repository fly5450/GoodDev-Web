package io.good.gooddev_web.member.vo;

    /*  뷰와 데이터를 주고받는 객체로, 클라이언트와의 상호작용에 중점을 둔다.
       비즈니스 로직이 포함될 수 있다. */

import io.good.gooddev_web.member.dto.MemberDTO;
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

        private String mid; // 아이디
        private String password; // 비밀번호
        private String memberName; // 회원명(실명)
        private String nickname; // 닉네임
        private String phone; // 전화번호
        private String email; // 이메일
	
	public boolean isEqualPasswordd(String password) {
		return this.password.equals(password);
	}

	// public MemberVO(String mid, String password) {
	// 	this(mid, password, "");
	// }
		
	public MemberVO(MemberDTO member) {
		
		this.mid = member.getMid();
		this.password = member.getPassword();
		this.memberName = member.getMemberName();
        this.nickname = member.getMemberName();
        this.phone = member.getPhone();
        this.email = member.getEmail();
	}
	
	public MemberDTO createMemberDTO() {
		return new MemberDTO();  
	}


}
