package io.good.gooddev_web.util;

// 유효성 검사: 아이디 검증
public class IdValidator {
    //아이디는 영문 대소문자와 숫자로 이루어진 4~20자리의 문자열
    private static final String ID_REGEX = "^[a-zA-Z0-9]{4,20}$"; 
    
    // 아이디 유효성 검사 메서드
    public static boolean isValidIdREGEX(String mid) {
        return mid != null && mid.matches(ID_REGEX); //아이디가 null이 아니고, 정규표현식에 맞는지 검사 matches는 정규표현식에 맞는지 검사하는 메서드임
    }
}
