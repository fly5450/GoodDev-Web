%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 수정</title>
</head>
<body>
    <h2>회원 수정</h2>
    <form action="/member/edit" method="post">
        <input type="hidden" name="mid" value="${memberDTO.mid}"/>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" value="${memberDTO.password}" required/><br/>

        <label for="memberName">이름:</label>
        <input type="text" id="memberName" name="memberName" value="${memberDTO.memberName}" required/><br/>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" value="${memberDTO.email}" required/><br/>

        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone" value="${memberDTO.phone}" required/><br/>

        <button type="submit">수정</button>
    </form>
</body>
</html>