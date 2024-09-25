<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<h1>Board Insert</h1>
	<div class="card-body">
		<form action="insert" method="post">
			<div class="input-group mb-3">
				<span class="input-group-text">제목</span>
				<input name="title" class="form-control" placeholder="Title">
			</div>
			<!-- <div class="input-group mb-3" id="title_err" style="color:red; display:none" ></div> -->
			<div class="input-group mb-3">
				<span class="input-group-text">내용</span>
				<input name="content" class="form-control" placeholder="Content">
			</div>			
			<div class="input-group mb-3">
				<span class="input-group-text">이름</span>
				<input name="mid" class="form-control" placeholder="Name">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">비밀번호</span>
				<input name="board_password" class="form-control" placeholder="Password">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">카테고리</span>
				<input name="category_no" class="form-control" placeholder="Category">
			</div>
			
			<!-- <div class="input-group mb-3" id="dueDate_err" style="color:red; display:none" ></div> -->
			
			<input type="submit" class="btn btn-primary" value="등록">
			<input type="reset" class="btn btn-secondary" value="초기화">
		</form>
	</div>
</body>
</html>