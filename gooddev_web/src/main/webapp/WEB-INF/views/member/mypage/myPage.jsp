<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - goodDev</title>

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
	<div>
		<div class="container wrap" style="width:100%; height: 100%; padding-top:100px; padding-bottom: 300px;">
			<div class="d-flex">
				<div id="my_box"  style="width:24%; height: 80%; padding: 0px 30px;">
					<h2 style="padding-bottom: 60px; width:15rem;"><a href="myPage" style="text-decoration-line: none; color:black;"><b>마이페이지</b></a></h2>
					<ul class="my_menu">
						<li id="menu1" style="height: 50%;">  
							<a class="menu_depth01" href="${pageContext.request.contextPath}/member/detailMember?mid=${member.mid}">내 정보</a>
							<ul class="menu_depth02">
								<li id="update"><a href="updateMember?mid=${member.mid}" onclick="changeStyle(this)">회원 정보 수정</a></li>
								<li id="update"><a href="myBoardList?mid=${member.mid}" onclick="changeStyle(this)">나의 작성 게시물</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="content" style="width:80%; padding:0px 30px;">
					<div class="profile">
						<div class="user_info">
							<span class="name" id="spanNickname">${member.mid} 님</span>
							<p class="date">가입일 : <span>${member.signup_Date}</span></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		function changeStyle(element) {
		    // 모든 링크의 스타일을 초기화
		    document.querySelectorAll('.menu_depth02 a').forEach(link => {
		        link.parentElement.classList.remove('selected');
		    });
		    
		    // 선택된 링크에 스타일 적용
		    element.parentElement.classList.add('selected');
		}
	</script>
</body>
</html>