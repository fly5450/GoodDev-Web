<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var contextPath = "${pageContext.request.contextPath}";

        document.addEventListener('DOMContentLoaded', function() {
            let findPwdBtn = document.querySelector('button[type="submit"]');
            findPwdBtn.addEventListener('click', function(event) {
                event.preventDefault(); // 기본 제출 동작을 막음
                let originalAction = document.getElementById('findPwdForm').getAttribute('action');
                const redirectParam = window.location.href;
                document.getElementById('findPwdForm').setAttribute('action', originalAction + "?redirect=" + encodeURIComponent(redirectParam));
                document.getElementById('findPwdForm').submit(); // 폼 제출
            });
        });
    </script>
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
            <%@ include file="/WEB-INF/views/commons/top10List.jsp" %>
            
            <!-- Main Content -->
            <div class="main-content">
                <c:if test="${not empty message}">
                    <div id="resultMessage" class="alert alert-info">${message}</div>
                </c:if>
        
                <main class="main-content">
                    <div class="form-container">
                        <h2>비밀번호 찾기</h2> 
                        <form action="<c:url value='/member/findpwd'/>" method="post" id="findPwdForm">  
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

                        <c:if test="${not empty foundUser}">
                            <form action="<c:url value='/member/resetPassword'/>" method="post" id="resetPasswordForm">
                                <div class="form-group">
                                    <label for="newPassword">새 비밀번호:</label>
                                    <input type="password" id="newPassword" name="newPassword" required>
                                </div>
                                <input type="hidden" name="mid" value="${foundUser.mid}">
                                <button type="submit" class="btn-primary">비밀번호 재설정</button>
                            </form>
                        </c:if>
                    </div>
                </main>
        
                <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
                <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
            </div>
        </div>
    </div>
</body>
</html>
