<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - 굿이야</title>
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
                <c:if test="${not empty message}">
                    <div id="resultMessage" class="alert-info">${message}</div>
                </c:if>
        
                <main class="main-content">
                    <div class="form-container">
                        <h2>비밀번호 찾기</h2> 
                        <form action="<c:url value='/member/findpwd'/>" method="post" id="findpwdForm">  
                            <div class="form-group">
                                <label for="mid">아이디:</label>
                                <input type="text" id="mid" name="mid" required> 
                            </div>

                            <div class="form-group">
                                <label for="email">이메일:</label>
                                <input type="email" id="email" name="email" required>
                            </div>
                            
                            <div id="newPasswordGroup" class="form-group" style="display: none;">
                                <label for="password">새 비밀번호:</label>
                                <input type="password" id="password" name="newPassword" required>
                            </div>
                            <button type="button" id="findPwdBtn" class="btn-primary">비밀번호 찾기</button>
                            <button type="submit" id="submitBtn" class="btn-primary" style="display: none;">새 비밀번호 설정</button>
                        </form>
                    </div>
                </main>
            </div>
            <!--광고부분-->
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
       <%@ include file="/WEB-INF/views/commons/footer.jsp" %>

    </div>

<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";

    document.addEventListener('DOMContentLoaded', function() {
        let findPwdBtn = document.getElementById('findPwdBtn');
        let submitBtn = document.getElementById('submitBtn');
        let newPasswordGroup = document.getElementById('newPasswordGroup');
        let findPwdForm = document.getElementById('findpwdForm');

        findPwdBtn.addEventListener('click', function() {
            let mid = document.getElementById('mid').value;
            let email = document.getElementById('email').value;

            // AJAX를 사용하여 서버에 아이디와 이메일 확인 요청
            fetch(`${contextPath}/member/checkIdDuplicate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ mid: mid, email: email })
            })
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    // 사용자가 존재하면 새 비밀번호 입력 폼 표시
                    newPasswordGroup.style.display = 'block';
                    findPwdBtn.style.display = 'none';
                    submitBtn.style.display = 'block';
                } else {
                    // 사용자가 존재하지 않으면 오류 메시지 표시
                    alert('입력하신 정보와 일치하는 사용자가 없습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            });
        });

        submitBtn.addEventListener('click', function(event) {
            event.preventDefault();
            let newPassword = document.getElementById('password').value;
            
            // 새 비밀번호 유효성 검사 (예: 6자 이상)
            if (newPassword.length < 6) {
                alert('새 비밀번호는 6자 이상이어야 합니다.');
                return;
            }
            let originalAction = document.getElementById('findpwdForm').getAttribute('action');
            const redirectParam = window.location.href;
            document.getElementById('findpwdForm').setAttribute('action', originalAction + "?redirect=" + encodeURIComponent(redirectParam))
            findPwdForm.submit();
            
        });
    });

</script>
    
</body>
</html>