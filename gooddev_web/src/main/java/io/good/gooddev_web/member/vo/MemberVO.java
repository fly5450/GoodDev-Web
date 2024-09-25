package io.good.gooddev_web.member.vo;


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

        private String mid; 
        private String password; 
        private String memberName; 
        private String nickname; 
        private String phone; 
        private String email; 
	
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
