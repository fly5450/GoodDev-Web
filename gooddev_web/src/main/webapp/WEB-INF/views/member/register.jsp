<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 가입</title>
</head>
<body>
    <h2>회원 가입</h2>
    <form action="/member/register" method="post">
        <label for="mid">아이디:</label>
        <input type="text" id="mid" name="mid" required/><br/>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required/><br/>

        <label for="memberName">이름:</label>
        <input type="text" id="memberName" name="memberName" required/><br/>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required/><br/>

        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone" required/><br/>

        <button type="submit">등록</button>
    </form>
    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>
