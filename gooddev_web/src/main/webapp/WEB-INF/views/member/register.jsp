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
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
                <div class="content">
                    <h2 class="mb-4">회원가입</h2>
                    <form id="registerForm" action="<c:url value='/member/register'/>" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="mid" class="form-label">아이디:</label>
                            <input type="text" class="form-control" id="mid" name="mid" required>
                            <div id="idCheck" class="form-text"></div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호:</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">비밀번호 확인:</label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                            <div id="passwordMatch" class="form-text"></div>
                        </div>
                        <div class="mb-3">
                            <label for="memberName" class="form-label">이름:</label>
                            <input type="text" class="form-control" id="memberName" name="memberName" required>
                        </div>
                        <div class="mb-3">
                            <label for="nickname" class="form-label">닉네임:</label>
                            <input type="text" class="form-control" id="nickname" name="nickname" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일:</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">전화번호:</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                        </div>
                        <button type="submit" class="btn btn-primary">가입하기</button>
                    </form>
                </div>
            </div>

            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
    <script src="<c:url value='/resources/js/register.js'/>"></script>
</body>
</html>