<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정 - 굿이야 사이트</title>
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
        <main>
            <h2>회원 정보 수정</h2>
            <form action="<c:url value='/member/edit'/>" method="post">
                <input type="hidden" name="mid" value="${memberDTO.mid}"/>
                
                <div class="form-group">
                    <label for="password">비밀번호:</label>
                    <input type="password" id="password" name="password" required/>
                </div>
                
                <div class="form-group">
                    <label for="memberName">이름:</label>
                    <input type="text" id="memberName" name="memberName" value="${memberDTO.memberName}" required/>
                </div>
                
                <div class="form-group">
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" value="${memberDTO.email}" required/>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호:</label>
                    <input type="tel" id="phone" name="phone" value="${memberDTO.phone}" required/>
                </div>
                
                <button type="submit" class="submit-button">수정 완료</button>
            </form>
        </main>
        
        <footer>
            <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
        </footer>
    </div>
</body>
</html>