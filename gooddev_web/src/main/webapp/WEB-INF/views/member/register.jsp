<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-container">
                <div class="logo-container">
                    <a href="<c:url value='/'/>">
                        <img src="<c:url value='/resources/img/good.png'/>" alt="굿이야 로고">
                    </a>
                </div>
                <div class="search-wrapper">
                    <span class="search-label">통합검색</span>
                    <div class="search-container">
                        <form action="<c:url value='/search'/>" method="get" id="searchForm" class="search-form">
                            <input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                            <button type="submit" class="search-button">검색</button>
                        </form>
                    </div>
                </div>
            </div>
        </header>

        <main>
            <h2>회원가입</h2>
            <form id="registerForm" action="<c:url value='/member/register'/>" method="post">
                <div>
                    <label for="mid">아이디:</label>
                    <input type="text" id="mid" name="mid" required>
                    <span id="idCheck"></span>
                </div>
                <div>
                    <label for="password">비밀번호:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div>
                    <label for="confirmPassword">비밀번호 확인:</label>
                    <input type="password" id="confirmPassword" required>
                    <span id="passwordMatch"></span>
                </div>
                <div>
                    <label for="memberName">이름:</label>
                    <input type="text" id="memberName" name="memberName" required>
                </div>
                <div>
                    <label for="nickname">닉네임:</label>
                    <input type="text" id="nickname" name="nickname" required>
                </div>
                <div>
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div>
                    <label for="phone">전화번호:</label>
                    <input type="tel" id="phone" name="phone" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                </div>
                <button type="submit">가입하기</button>
            </form>
        </main>

        <footer>
            <p>&copy; 2024 굿이야. All rights reserved.</p>
        </footer>
    </div>

    
</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
	<div class="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class = "main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
				<h2>회원가입</h2>
                <form id="registerForm" action="<c:url value='/member/register'/>" method="post">
                    <div>
                        <label for="mid">아이디:</label>
                        <input type="text" id="mid" name="mid" required>
                        <span id="idCheck"></span>
                    </div>
                    <div>
                        <label for="password">비밀번호:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div>
                        <label for="confirmPassword">비밀번호 확인:</label>
                        <input type="password" id="confirmPassword" required>
                        <span id="passwordMatch"></span>
                    </div>
                    <div>
                        <label for="memberName">이름:</label>
                        <input type="text" id="memberName" name="memberName" required>
                    </div>
                    <div>
                        <label for="nickname">닉네임:</label>
                        <input type="text" id="nickname" name="nickname" required>
                    </div>
                    <div>
                        <label for="email">이메일:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div>
                        <label for="phone">전화번호:</label>
                        <input type="tel" id="phone" name="phone" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                    </div>
                    <button type="submit">가입하기</button>
                </form>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
    
	<script>
    $(document).ready(function() {
        // 아이디 중복 체크
        $('#mid').blur(function() {
            $.ajax({
                url: '<c:url value="/member/checkId"/>',
                type: 'POST',
                data: {mid: $('#mid').val()},
                success: function(result) {
                    if(result == 'available') {
                        $('#idCheck').text('사용 가능한 아이디입니다.').css('color', 'green');
                    } else {
                        $('#idCheck').text('이미 사용 중인 아이디입니다.').css('color', 'red');
                    }
                }
            });
        });

        // 비밀번호 일치 확인
        $('#confirmPassword').keyup(function() {
            if($('#password').val() == $('#confirmPassword').val()) {
                $('#passwordMatch').text('비밀번호가 일치합니다.').css('color', 'green');
            } else {
                $('#passwordMatch').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
            }
        });

        // 폼 제출 전 유효성 검사
        $('#registerForm').submit(function(e) {
            if($('#password').val() != $('#confirmPassword').val()) {
                alert('비밀번호가 일치하지 않습니다.');
                e.preventDefault();
            }
        });
    });
    </script>
    
</body>
</html>