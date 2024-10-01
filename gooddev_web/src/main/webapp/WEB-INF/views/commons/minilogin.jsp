<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${empty sessionScope.loginInfo}">
        <div class="mini-login-container">
            <div class="login-links">
                <a href="${pageContext.request.contextPath}/member/login"class="mini-login-link">로그인하기</a>
            </div>
            <div class="login-links">
                <a href="${pageContext.request.contextPath}/member/register" class="mini-login-link">회원가입</a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="mini-login-container" >
            <div>
                <label class="login-message">${loginInfo.nickname}님 환영합니다</label>
            </div>
            <div class="login-links">
                <c:choose>
			        <c:when test="${not empty sessionScope.isAdminYn && sessionScope.isAdminYn == 'Y'}">
			            <a href="${pageContext.request.contextPath}/admin" class="mini-login-link">관리자페이지</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/member/myPage" class="mini-login-link">마이페이지</a>
			        </c:otherwise>
			    </c:choose>
                <a href="${pageContext.request.contextPath}/member/logout" class="mini-login-link">로그아웃</a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        loginLinks = document.querySelectorAll(".mini-login-link")
        loginLinks.forEach(function(loginLink) {
            loginLink.addEventListener('click', function() {
                event.preventDefault();
                let originalHref = loginLink.getAttribute('href');
                const redirectParam = window.location.href;
                loginLink.href = originalHref +"?redirect="+encodeURIComponent(redirectParam);
                window.location.href = loginLink.href;
            });
        });
    });
</script>

