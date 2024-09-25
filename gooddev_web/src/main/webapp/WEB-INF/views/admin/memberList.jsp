<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 마이페이지(memberList) - goodDev</title>

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
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
		
</head>
<body>
	<div class="wrapper">
		<!-- contents -->
		<div class="main p-3">
			<div class="item-section mt-2 mb-2" style="font-size: 12px">
			회원 관리 > 전체 회원 조회
			</div>
		
			<div class="headingArea">
				<div class="title">
					<h1 id="itemTitle">전체 회원 조회</h1>
				</div>
			</div>
			
			<div class="section_block">
				<div class="container mt-3">
				  <!-- <h2>전체 상품 목록</h2> -->
				  <table class="table">
				    <thead class="table-dark">
				      <tr>
				        <th>No</th>
				        <th>회원 아이디</th>
				        <th>이름</th>
				        <th>닉네임</th>
				        <th>이메일</th>
				        <th>가입일시</th>
				        <th>수정/삭제</th>
				      </tr>
				    </thead>
				    <tbody>
				    	<c:forEach var="member" items="${good_member}">
					      <tr>
					        <td>${member.class_no}</td>
					        <td>${member.mid}</td>
					        <td>${member.member_name}</td>
					        <td>${member.nickname}</td>
					        <td>${member.email}</td>
					        <td>${member.signup_date}</td>
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
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>