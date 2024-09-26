package io.good.gooddev_web.member.vo;

    import java.util.Date;

/*  뷰와 데이터를 주고받는 객체로, 클라이언트와의 상호작용에 중점을 둔다.
       비즈니스 로직이 포함될 수 있다. */

import io.good.gooddev_web.member.dto.MemberDTO;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Slf4j
    public class MemberVO {

		@NotEmpty(message = "아이디는 필수입니다.")
		private String mid; // 아이디
	
		@NotEmpty(message = "비밀번호는 필수입니다.")
		private String password; // 비밀번호
	
		@NotEmpty(message = "회원명은 필수입니다.")
		private String memberName; // 회원명(실명)
	
		@NotEmpty(message = "닉네임은 필수입니다.")
		private String nickname; // 닉네임
	
		@NotEmpty(message = "전화번호는 필수입니다.")
		private String phone; // 전화번호
	
		@Email(message = "유효한 이메일 주소를 입력하세요.")
		private String email; // 이메일
        private String auto_Login; // 자동로그인 key
        private Date last_Login_Date; // 마지막 로그인
        private Date last_Logout_Date; // 마지막 로그아웃
        private char deleteYn; // 삭제 여부
        private char isAdminYn; // 관리자 여부
        private Date signup_Date; // 가입날짜
        private Date signout_Date; // 탈퇴날짜(비활성화)

	public MemberVO(MemberDTO member) {
		
		this.mid = member.getMid();
		this.password = member.getPassword();
		this.memberName = member.getMemberName();
        this.nickname = member.getMemberName();
        this.phone = member.getPhone();
        this.email = member.getEmail();
	}

	public MemberDTO createMemberDTO(String mid, String password, String memberName, String nickname, String phone, String email) {
		return new MemberDTO();  
	}
 
	public void modifyMemberInfo(MemberVO modifyMember) {
		if (modifyMember.getPassword() != null) {
			this.password = modifyMember.getPassword();
		}
		if (modifyMember.getMemberName() != null) {
			this.memberName = modifyMember.getMemberName();
		}
		if (modifyMember.getNickname() != null) {
			this.nickname = modifyMember.getNickname();
		}
		if (modifyMember.getPhone() != null) {
			this.phone = modifyMember.getPhone();
		}
		if (modifyMember.getEmail() != null) {
			this.email = modifyMember.getEmail();
		}
	}
	
	// public void logMemberInfo() {
	// 	log.info("Member Info: {}", this.toString());
	// }

   

}
