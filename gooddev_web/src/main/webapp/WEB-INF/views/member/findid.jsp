<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 굿이야 사이트</title>
    <!-- CSS 스타일 시트를 불러옴 -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
    <div class="container">
        <!-- 헤더 영역 (공통) -->
        <header>
            <div class="header-container">
                <div class="logo-container">
                    <!-- 사이트 로고 이미지 -->
                    <img src="resources/img/good.png" alt="로고">
                </div>
                <div class="search-wrapper">
                    <span class="search-label">통합검색</span>
                    <div class="search-container">
                        <!-- 검색 폼 -->
                        <form action="search" method="post" id="searchForm" class="search-form">
                            <input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                            <button type="submit" class="search-button">검색</button>
                        </form>
                    </div>
                </div>
            </div>
        </header>

        <!-- 메인 컨텐츠 영역 -->
        <main>
            <h2>아이디 찾기</h2>
            <!-- 아이디 찾기 요청을 위한 폼 -->
            <form action="<c:url value='/member/findid'/>" method="post">
                <div>
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <button type="submit">아이디 찾기</button>
            </form>
            
            <!-- 아이디 찾기 결과 표시 -->
            <c:if test="${not empty foundId}">
                <p>찾은 아이디: ${foundId}</p>
            </c:if>
            
            <!-- 에러 메시지 표시 -->
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>
        </main>

        <!-- 푸터 영역 (공통) -->
        <footer>
            <p>© 2024 굿이야(주) . All rights reserved.</p>
        </footer>
    </div>
    
    <!-- 디버깅을 위한 스크립트 추가 -->
    <script>
        console.log("페이지 로드 완료");
        
        // 폼 제출 시도 시의 이벤트
        document.querySelector('form').addEventListener('submit', function(e) {
            console.log("폼 제출 시도");
            var email = document.getElementById('email').value; // 입력된 이메일 값 가져오기
            console.log("입력된 이메일:", email);
            
            // 폼 제출 전 유효성 검사
            if (!email) {
                console.error("이메일이 입력되지 않았습니다."); // 이메일이 입력되지 않았을 경우 경고 메시지
                e.preventDefault(); // 폼 제출 방지
                return;
            }
        });
        
        // 서버에서 반환된 결과 확인
        var foundId = "${foundId}"; // JSP 표현식을 사용하여 서버에서 전달된 foundId 가져오기
        if (foundId) {
            console.log("찾은 아이디:", foundId); // 찾은 아이디 출력
        }
        
        var errorMessage = "${errorMessage}"; // JSP 표현식을 사용하여 서버에서 전달된 errorMessage 가져오기
        if (errorMessage) {
            console.error("에러 메시지:", errorMessage); // 에러 메시지 출력
        }
        
        // AJAX 요청 실패 시 디버깅
        $(document).ajaxError(function(event, jqXHR, ajaxSettings, thrownError) {
            console.error("AJAX 요청 실패:", thrownError); // AJAX 요청 실패 시 에러 메시지 출력
            console.log("상태 코드:", jqXHR.status); // 상태 코드 출력
            console.log("응답 텍스트:", jqXHR.responseText); // 서버 응답 텍스트 출력
        });
    </script>
    
</body>
</html>
