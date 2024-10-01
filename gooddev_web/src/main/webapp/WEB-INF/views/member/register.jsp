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
<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";

</script>
<script src="<c:url value='/resources/js/register.js'/>"></script>
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
            <div class="main-content">
                <div class="register-form">
                    <h2>회원가입</h2>
                    <form id="registerForm" action="<c:url value='/member/register'/>" method="post">
                        <div class="form-group">
                            <label for="mid">아이디:</label>
                            <input type="text" id="mid" name="mid" value="${memberDTO.mid}" required>
                            <button type="button" id="checkIdBtn">중복 체크</button>
                            <span id="idCheckMessage"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">비밀번호:</label>
                            <input type="password" id="password" name="password" value="&{memberDTO.password}" required>
                            <span id="passwordCheckMessage"></span>
                        </div>
                        
                        <!-- 
                        <div class="form-group">
                            <label for="confirmPassword">비밀번호 확인:</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                            <span id="passwordCheckMessage"></span>
                        </div> -->
                        
                        <div class="form-group">
                            <label for="member_Name">이름:</label>
                            <input type="text" id="member_Name" name="member_Name" value="${memberDTO.member_Name}" required>
                            <span id="nameCheckMessage"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="nickname">닉네임:</label>
                            <input type="text" id="nickname" name="nickname" value="${memberDTO.nickname}" required>
                            <span id="nicknameCheckMessage"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">이메일:</label>
                            <input type="email" id="email" name="email" value="${memberDTO.email}" required>
                            <span id="emailCheckMessage"></span>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">전화번호:</label>
                            <input type="tel" id="phone" name="phone" value="${memberDTO.phone}" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                            <span id="phoneCheckMessage"></span>
                        </div>
                        
                        <button type="submit" name="register" value="register" id="registerBtn" class="submit-btn">가입하기</button>
                    </form>
                </div>
            </div>
            
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>
        
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
</body>
</html>