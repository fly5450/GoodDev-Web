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
    <style>
        .register-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .register-form h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #0056b3;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-group button {
            padding: 10px 15px;
            background-color: #0056b3;  
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        #idCheck {
            display: block;
            margin-top: 5px;
            color: #dc3545;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 18px;
            cursor: pointer;
            margin-top: 10px;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
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
                <div class="register-form">
                    <h2>회원가입</h2>
                    <form id="registerForm" action="<c:url value='/member/register'/>" method="post" class="needs-validation" novalidate>
                        <div class="form-group">
                            <label for="mid">아이디:</label>
                            <input type="text" id="mid" name="mid" value="${checkedId}" required>
                            <button type="button" id="checkIdBtn">중복 체크</button>
                            <c:if test="${not empty message}">
                                <span id="idCheck">${message}</span>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">비밀번호:</label>
                            <input type="password" id="password" name="password" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">비밀번호 확인:</label>
                            <input type="password" id="confirmPassword" required>
                            <div id="passwordMatch"></div>
                        </div>
                        <div class="form-group">
                            <label for="memberName">이름:</label>
                            <input type="text" id="memberName" name="memberName" required>
                        </div>
                        <div class="form-group">
                            <label for="nickname">닉네임:</label>
                            <input type="text" id="nickname" name="nickname" required>
                        </div>
                        <div class="form-group">
                            <label for="email">이메일:</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">전화번호:</label>
                            <input type="tel" id="phone" name="phone" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                        </div>

                        <button type="submit" class="submit-btn">가입하기</button>
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