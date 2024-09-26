<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>아이디 찾기</title>
</head>
<body>
    <h2>아이디 찾기</h2>
    <form action="/member/findId" method="post">
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required/><br/>
        <button type="submit">찾기</button>
    </form>
    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>
