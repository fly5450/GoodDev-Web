<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <style>
        .content-center {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 100px); /* 헤더와 푸터 높이를 고려하여 조정 */
        }
        .form-container {
            background-color: #f9f9f9;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
        }
        .form-group input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-primary {
            width: 100%;
            padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        #resultMessage {
            margin-top: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        
        <main class="main-content">
            <div class="form-container">
                <h2>비밀번호 찾기</h2>
                <form action="<c:url value='/member/findpwd'/>" method="post">
                    <div class="form-group">
                        <label for="mid">아이디:</label>
                        <input type="text" id="mid" name="mid" required>
                    </div>
                    <div class="form-group">
                        <label for="email">이메일:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <button type="submit" class="btn-primary">비밀번호 찾기</button>
                </form>
                <div id="resultMessage">
                    <c:if test="${not empty message}">
                        <p style="color: ${message.startsWith('임시 비밀번호가') ? 'green' : 'red'}">${message}</p>
                    </c:if>
                </div>
            </div>
        </main>
        
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
</body>
</html>