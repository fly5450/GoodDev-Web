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
			<span>게시판 번호 : </span> <span>${board.bno}</span>
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
			<span>내용: </span> <span>${board.content}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>일자: </span> <span>${board.formatDate}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>조회수: </span> <span>${board.view_cnt}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>좋아요: </span> <span>${board.like_cnt}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>싫어요: </span> <span>${board.hate_cnt}</span>
		</h3>
	</div>
	 <a href="list?&${pageRequestDTO.link}">뒤로가기</a> 

	<a href="update?bno=${param.bno}&${pageRequestDTO.link}">수정</a>
	<button>좋아요</button>
	<button>싫어요</button>
	<%-- 	<a href="remove?id=${param.id}&${pageRequestDTO.link}">삭제</a>
	<a href="list?&${pageRequestDTO.link}">목록</a>
 --%>

 </body>
</html>
