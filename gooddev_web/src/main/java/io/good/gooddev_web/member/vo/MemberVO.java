package io.good.gooddev_web.member.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import java.util.Date;

import io.good.gooddev_web.member.dto.MemberDTO;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String mid; 			// 아이디
	private String password; 		// 비밀번호
	private String memberName; 		// 회원명(실명)
	private String nickname; 		// 닉네임
	private String phone; 			// 전화번호
	private String email; 			// 이메일
	private String auto_Login; 		// 자동로그인 key
	private Date last_Login_Date; 	// 마지막 로그인
	private Date last_Logout_Date; 	// 마지막 로그아웃
	private char deleteYn; 			// 삭제 여부
	private char isAdminYn; 		// 관리자 여부
	private Date signup_Date; 		// 가입날짜
	private Date signout_Date; 		// 탈퇴날짜(비활성화)
	private int class_No; 			//클래스 번호(교육과정 차 수)
        
	
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
