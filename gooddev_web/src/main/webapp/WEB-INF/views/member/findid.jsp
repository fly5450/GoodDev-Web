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
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
                <h2>아이디 찾기</h2>
                <form action="<c:url value='/member/findid'/>" method="post" id="findIdForm">
                    <div>
                        <label for="email">이메일:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <button type="submit">아이디 찾기</button>
                </form>
                
                <div id="resultMessage"></div>
            </div>

            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    // DOM이 완전히 로드된 후 실행
    $(document).ready(function() {
        // 'findIdForm' ID를 가진 폼의 제출 이벤트를 처리
        $('#findIdForm').submit(function(e) {
            // 기본 폼 제출 동작을 방지
            e.preventDefault();
            
            // AJAX 요청 실행
            $.ajax({
                url: $(this).attr('action'),    // 폼의 action 속성 값을 URL로 사용
                type: 'POST',                   // POST 방식으로 요청
                data: $(this).serialize(),      // 폼 데이터를 직렬화하여 전송
                
                success: function(response)     // 요청 성공 시 실행되는 콜백 함수
                {
                    if(response.foundId) {
                        // 아이디를 찾은 경우 녹색으로 결과 표시
                        $('#resultMessage').text('찾은 아이디: ' + response.foundId).css('color', 'green');
                    } else {
                        // 아이디를 찾지 못한 경우 빨간색으로 메시지 표시
                        $('#resultMessage').text('일치하는 정보가 없습니다.').css('color', 'red');
                    }
                },
                // 요청 실패 시 실행되는 콜백 함수
                error: function() {
                    // 오류 발생 시 빨간색으로 메시지 표시
                    $('#resultMessage').text('오류가 발생했습니다. 나중에 다시 시도해주세요.').css('color', 'red');
                }
            });
        });
    });
    </script>
</body>
</html>
