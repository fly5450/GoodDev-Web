package io.good.gooddev_web.member.dto;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
    private String mid; 
    private String password; 
    private String memberName; 
    private String nickname; 
    private String phone; 
    private String email; 
    private String auto_Login; 
    private Date last_Login_Date; 
    private Date last_Logout_Date; 
    private char deleteYn; 
    private char isAdminYn; 
    private Date signup_Date; 
    private Date signout_Date;

    public MemberDTO(String mid, String password) {
        this.mid = mid;
        this.password = password;
    }
}
