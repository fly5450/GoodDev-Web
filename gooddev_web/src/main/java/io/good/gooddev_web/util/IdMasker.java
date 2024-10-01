package io.good.gooddev_web.util;
//ID 마스킹처리
public class IdMasker {
    public static String maskId(String id) {
        if (id == null || id.isEmpty()) { //아이디가 비어있으면
            return ""; // 빈문자열 반환.
        }
        
        int visibleLength = Math.min(3, id.length()); //보여줄 문자 수(visibleLength)를 계산. (최대 3자리).
        int maskedLength = id.length() - visibleLength; // 마스킹할 문자 수(maskedLength)를 계산.
        
        //StringBuilder를 사용하여 마스킹된 ID를 생성.
        StringBuilder maskedId = new StringBuilder(id.substring(0, visibleLength)); // 스트링빌더 생성 앞의3자리만 보이게
        maskedId.append("*".repeat(maskedLength)); //나머지는 *로 채운다.
        
        return maskedId.toString(); // 마스킹된 ID를 문자열로 변환하여 반환.
    }
}