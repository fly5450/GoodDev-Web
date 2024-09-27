<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - 굿이야 사이트</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <header>
            <!-- 헤더 내용 (메인 페이지와 동일) -->
        </header>

        <main>
            <h2>비밀번호 찾기</h2>
            <form id="findPasswordForm" action="<c:url value='/member/findPassword'/>" method="post">
                <div>
                    <label for="mid">아이디:</label>
                    <input type="text" id="mid" name="mid" required>
                </div>
                <div>
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <button type="submit">비밀번호 찾기</button>
            </form>
            <div id="resultMessage"></div>
        </main>

        <footer>
            <p>© 2024 굿이야. All rights reserved.</p>
        </footer>
    </div>

    <script>
    $(document).ready(function() {
        $('#findPasswordForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    if(response === 'success') {
                        $('#resultMessage').text('임시 비밀번호가 이메일로 전송되었습니다.').css('color', 'green');
                    } else {
                        $('#resultMessage').text('일치하는 정보가 없습니다. 다시 확인해주세요.').css('color', 'red');
                    }
                },
                error: function() {
                    $('#resultMessage').text('오류가 발생했습니다. 나중에 다시 시도해주세요.').css('color', 'red');
                }
            });
        });
    });
    </script>
</body>
</html>