<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지(공지사항 상세보기) - goodDev</title>

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
		
		<!-- external css -->
    	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/my_page.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/page_nav.css">
    	
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
</head>
<body>

	<h1>공지사항 상세</h1>
	<div style="text-align: right; margin: 10px;">
	   <%@ include file="/WEB-INF/views/commons/minilogin.jsp" %>
	</div>
	<div>
		<h3>
			<span>게시판 번호 : </span> <span id="bno">${board.bno}</span>
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
	<button type="button" onclick="history.back()" class="btn btn-outline-dark">뒤로가기</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/boardList?${pageRequestDTO.link}'" class="btn btn-outline-dark">목록</button>

</body>
</html>