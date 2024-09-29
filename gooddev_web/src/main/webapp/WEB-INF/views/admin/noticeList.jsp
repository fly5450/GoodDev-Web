<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 - goodDev</title>

		<!-- Bootstrap 5를 위한 외부 라이브러리 설정 -->
		<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
		<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
		
</head>
<body>
	<div>
		<table border="1" style="width: 100%; border-collapse: collapse;">
	        <thead>
	            <tr>
	                <th>번호</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>작성일</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="notice" items="${pageResponseDTO.getList()}">
	                <tr>
	                    <td>${notice.bno}</td>
	                    <td><a href="/gooddev_web/admin/noticeDetail/${notice.bno}">${notice.title}</a></td>
	                    <td>${notice.mid}</td>
	                </tr>
	            </c:forEach>
        	</tbody>
    	</table>
	</div>
</body>
</html>