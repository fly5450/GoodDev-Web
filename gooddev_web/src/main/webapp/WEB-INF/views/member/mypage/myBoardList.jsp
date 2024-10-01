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
    	<link rel="stylesheet" href="<c:url value='/resources/css/page_nav.css'/>">
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
		
</head>
<body>
	<div class="container wrap" style="width:100%; height: 100%; padding-top:100px; padding-bottom: 300px;">
		<div class="d-flex">
	        <!-- 일반 사용자용 메뉴 바 -->
	        <div id="my_box" style="width:24%; height: 80%; padding: 0px 30px;">
	            <h2 style="padding-bottom: 60px; width:15rem;"><a href="mypage" style="text-decoration-line: none; color:black;"><b>마이페이지</b></a></h2>
	            <ul class="my_menu">
	                <li id="menu1" style="height: 50%;">  
	                    <a class="menu_depth01" href="#">나의 정보</a>
	                    <ul class="menu_depth02">
	                        <li id="update"><a href="updateMember">회원 정보 수정</a></li>
	                        <li id="myBoardList"><a href="myBoardList">나의 작성 게시물</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
			<div class="content" style="width:80%; padding:0px 30px;">
				<div class="profile">
					<div class="user_info">
						<span class="name" id="spanNickname">누구누구 님</span>
						<p class="date">가입일 : <span>가입날짜 적을부분(db)</span></p>
					</div>
				</div>
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
						        <th>닉네임</th>
						        <th>작성일시</th>
						        <th>수정/삭제</th>
						      </tr>
						    </thead>
						    <tbody>
						    	<c:forEach var="member" items="${pageResponseDTO.list}">
							      <tr>
							        <td>${member.class_No}</td>
							        <td>${member.nickname}</td>
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
							  <div class="float-end" >
							    <ul class="pagination flex-wrap" >
							        <c:if test="${not empty pageResponseDTO && not empty pageRequestDTO}">
							            <c:if test="${pageResponseDTO.prev}">
							                <li class="page-item" ><a class="page-link" href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.start-1)}">이전</a></li>
							            </c:if>
							
							            <c:forEach var="num" begin="${pageResponseDTO.start}" end="${pageResponseDTO.end}">
							                <li class="page-item ${pageResponseDTO.page == num ? 'active' : ''}">
							                    <a class="page-link" href="?page=${num}&size=${pageResponseDTO.size}" data-param="${pageRequestDTO.getParam(num)}">${num}</a>
							                </li>		
							            </c:forEach>
										
							            <c:if test="${pageResponseDTO.next}">
							                <li class="page-item"><a class="page-link"href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}">다음</a></li>
							            </c:if>
							        </c:if>
							    </ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	<script>
		//페이지네이션 자바스크립트 (게시물목록)	
		document.querySelectorAll(".page-link").forEach(item => {
		    item.addEventListener('click', e => {
		        e.preventDefault();
		        e.stopPropagation();
		        
		        const param = e.target.getAttribute("data-param");
	            self.location = "boardList?" + param; // 경로
		    });
		});
	</script>
</body>
</html>