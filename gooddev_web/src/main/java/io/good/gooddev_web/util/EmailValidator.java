package io.good.gooddev_web.util;
//유효성 검사 : 이메일 검증
public class EmailValidator {
    public static boolean isValidEmail(String email) {
        //email != null: 먼저 이메일이 null이 아닌지 확인합니다.
        //email.matches("^[A-Za-z0-9+_.-]+@(.+)$"): 정규표현식을 사용하여 이메일 형식을 검사합니다.
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$"); 
    }
}
