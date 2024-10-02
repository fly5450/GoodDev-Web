<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
        $("#findIdForm").submit(function(event) {
            event.preventDefault(); // 기본 폼 제출 동작 막음

            let email = $("#email").val();
            
            if (!email) {
                alert("이메일을 입력해 주세요.");
                return;
            }

            let formAction = $("#findIdForm").attr("action");

            $.ajax({
                url: formAction,
                type: "POST",
                data: { email: email },
                success: function(response) {
                    // 서버에서 성공 응답을 받았을 때 처리
                    if (response.foundId) {
                        $(".main-content").html('<div class="alert alert-success">아이디 찾기 결과: ' + response.foundId + '</div>');
                    } else if (response.message) {
                        $(".main-content").html('<div class="alert alert-danger">' + response.message + '</div>');
                    }
                },
                error: function() {
                    alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
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

            <!-- Main Content -->
            <div class="main-content">
                <h2>아이디 찾기</h2>
                <form action="<c:url value='/member/findid'/>" method="post" id="findIdForm">  
                    <div class="form-group">
                        <label for="email">이메일:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <button type="submit" class="btn-primary">아이디 찾기</button>
                </form>

                <c:if test="${not empty foundId}">
                    <div class="alert alert-success">
                        <p>아이디 찾기 결과: ${foundId}</p>
                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="alert alert-danger">
                        <p>${message}</p>
                    </div>
                </c:if>
            </div>

            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
</body>
</html>
