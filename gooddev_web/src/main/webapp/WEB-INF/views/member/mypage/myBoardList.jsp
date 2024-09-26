<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지(게시물리스트) - goodDev</title>

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
		<!--  <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
		-->
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
		
</head>
<body>
	<div class="wrapper">
		<!-- contents -->
		<div class="main p-3">
			<div class="headingArea">
				<div class="title">
					<h1 id="itemTitle">내가 작성한 게시글 조회</h1>
				</div>
			</div>
			
			<div class="section_block">
				<div class="container mt-3">
				  <!-- <h2>내 게시물 목록</h2> -->
				  <table class="table">
				    <thead class="table-dark">
				      <tr>
				        <th>No</th>
				        <th>이름</th>
				        <th>닉네임</th>
				        <th>작성일시</th>
				        <th>수정/삭제</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<c:forEach var="member" items="${pageResponseDTO.list}">
					      <tr>
					        <td>${member.class_No}</td>
					        <td>${member.mid}</td>
					        <td>${member.memberName}</td>
					        <td>${member.nickname}</td>
					        <td>${member.email}</td>
					        <td>${member.signup_Date}</td>
					        <td>
					        	<div class="btn_big_wrap">
									<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/memberUpdate'" class="btn btn-outline-dark">수정</button>
									<button type="button" onclick="location.href='#'" class="btn btn-outline-dark">삭제</button>
								</div>
					        </td>
					      </tr>
				    	</c:forEach>
				    </tbody>
				  </table>
					  <!-- 페이지네이션 -->

				</div>
			</div>
		</div>
	</div>
</body>
</html>