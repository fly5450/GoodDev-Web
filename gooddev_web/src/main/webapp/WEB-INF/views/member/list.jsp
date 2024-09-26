<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>회원 목록</title>
</head>
<body>
    <h2>회원 목록</h2>
    <a href="/member/register">회원 등록</a>
    <table border="1">
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${pageResponseDTO.list}">
                <tr>
                    <td>${member.mid}</td>
                    <td>${member.memberName}</td>
                    <td>${member.email}</td>
                    <td>${member.phone}</td>
                    <td><a href="/member/edit/${member.mid}">수정</a></td>
                    <td>
                        <form action="/member/delete/${member.mid}" method="post">
                            <button type="submit">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div>
        <c:if test="${pageResponseDTO.prev}">
            <a href="?page=${pageResponseDTO.page - 1}">이전</a>
        </c:if>
        <c:if test="${pageResponseDTO.next}">
            <a href="?page=${pageResponseDTO.page + 1}">다음</a>
        </c:if>
    </div>
</body>
</html>
