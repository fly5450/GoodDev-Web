<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 굿이야</title>
    <!-- CSS 스타일 시트를 불러옴 -->
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
    <div class="container">
        <!-- 헤더, 네비게이션, 광고 등 포함 -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        <!-- Main Content -->
        <div class="main-content">
            <h2>아이디 찾기</h2>
            <!-- 아이디 찾기 모달을 열기 위한 버튼 -->
            <button id="openFindIdModal">아이디 찾기</button>
        </div>
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        <!-- Footer -->
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
    
    <!-- 아이디 찾기 모달 -->
    <div id="findIdModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>아이디 찾기</h2>
            <!-- 아이디 찾기 폼 -->
            <form id="findIdForm">
                <div>
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <button type="submit">아이디 찾기</button>
            </form>
            <!-- 결과 메시지를 표시할 div -->
            <div id="resultMessage"></div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        var modal = $('#findIdModal');
        var btn = $('#openFindIdModal');
        var span = $('.close');

        // 모달 열기
        btn.click(function() {
            modal.css('display', 'block');
        });

        // 모달 닫기 (x 버튼)
        span.click(function() {
            modal.css('display', 'none');
        });

        // 모달 외부 클릭 시 닫기
        $(window).click(function(event) {
            if (event.target == modal[0]) {
                modal.css('display', 'none');
            }
        });

        // 아이디 찾기 폼 제출 처리
        $('#findIdForm').submit(function(e) {
            e.preventDefault();
            
            // AJAX를 사용하여 서버에 아이디 찾기 요청
            $.ajax({
                url: '<c:url value="/member/findid"/>',
                type: 'POST',
                data: $(this).serialize(),
                
                success: function(response) {
                    // 성공 시 결과 표시
                    if(response.foundId) {
                        $('#resultMessage').text('찾은 아이디: ' + response.foundId).css('color', 'green');
                    } else {
                        $('#resultMessage').text('일치하는 정보가 없습니다.').css('color', 'red');
                    }
                },
                error: function() {
                    // 오류 발생 시 메시지 표시
                    $('#resultMessage').text('오류가 발생했습니다. 나중에 다시 시도해주세요.').css('color', 'red');
                }
            });
        });
    });
    </script>
    
    <!-- 모달 스타일 -->
    <style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    </style>
</body>
</html>
