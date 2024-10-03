<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지(공지사항 수정) - goodDev</title>

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
	<h1>공지사항 수정</h1>
	<div style="text-align: right; margin: 10px;">
	    <%@ include file="/WEB-INF/views/commons/minilogin.jsp" %>
	</div>
	<div class="card-body">
		<form action="${pageContext.request.contextPath}/admin/updateNotice" method="post" enctype="multipart/form-data">
			<input type="hidden" name="bno" value="${board.bno}"/>
			<div class="input-group mb-3">
				<span class="input-group-text">제목</span>
				<input name="title" class="form-control" placeholder="Title" value="${board.title}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">내용</span>
				<input name="content" class="form-control" placeholder="Content" value="${board.content}">
			</div>
			<input type="submit" class="btn btn-primary" value="수정">
			<input type="reset" class="btn btn-secondary" value="초기화">
		</form>
	</div>
</body>
</html>