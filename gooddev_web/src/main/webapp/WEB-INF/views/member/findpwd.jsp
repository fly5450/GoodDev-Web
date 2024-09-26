<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="/member/findPwd" method="post">
        <label for="mid">아이디:</label>
        <input type="text" id="mid" name="mid" required/><br/>
        
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required/><br/>
        
        <button type="submit">찾기</button>
    </form>
    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>
