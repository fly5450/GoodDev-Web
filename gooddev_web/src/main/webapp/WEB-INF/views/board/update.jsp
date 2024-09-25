<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Board Update</h1>
<form action="update?${pageRequestDTO.link}" method="post">
	<div>
		<h3>
			<span>게시물 번호: </span>
			<input type="text" name="bno" value="${board.bno}" readonly>
		</h3>
	</div>
	<div>
		<h3>
			<span>아이디 : </span>
			<input type="text" name="mid" value="${board.mid}" readonly="readonly">
		</h3>
	</div>
	<div>
		<h3>
			<span>제목: </span>
			<input type="text" name="title" value="${board.title}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>내용: </span>
			<input type="text" name="content" value="${board.content}" >
		</h3>
	</div>
	<div>
		<h3>
			<span>일자: </span>
			<input type="text" name="formatDate" value="${board.formatDate}" readonly>
		</h3>
	</div>
	<input type="submit" value="수정">
</form>
</body>
</html>