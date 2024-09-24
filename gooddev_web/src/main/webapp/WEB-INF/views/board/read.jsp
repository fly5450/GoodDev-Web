<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Board Read</h1>
	<div>
		<h3>
			<span name="bno">bno : </span> <span>${board.bno}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>아이디 : </span> <span>${board.mid}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>제목: </span> <span>${board.title}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>날짜: </span> <span>${board.insertDate}</span>
		</h3>
	</div>

<%-- 	<a href="modify?id=${param.id}&${pageRequestDTO.link}">수정</a>
	<a href="remove?id=${param.id}&${pageRequestDTO.link}">삭제</a>
	<a href="list?&${pageRequestDTO.link}">목록</a>
 --%>
 </body>
</html>
