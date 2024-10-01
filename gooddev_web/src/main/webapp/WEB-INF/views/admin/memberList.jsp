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
	<div style="text-align: right; margin: 10px;">
	    <form action="<c:url value='/member/logout' />" method="post">
	        <button type="submit">로그아웃</button>
	    </form>
	</div>
	<div class="container wrap" style="width:100%; height: 100%; padding-top:100px; padding-bottom: 300px;">
		<div class="d-flex">
	        <!-- 관리자용 메뉴 바 -->
	        <div id="my_box" style="width:24%; height: 80%; padding: 0px 30px;">
	            <h2 style="padding-bottom: 60px; width:15rem;"><a href="${pageContext.request.contextPath}/admin" style="text-decoration-line: none; color:black;"><b>관리자페이지</b></a></h2> 
	            <ul class="my_menu">
	                <li id="menu1" style="height: 50%;">  
	                    <h5 class="menu_depth01">관리자 정보</h5> 
	                    <ul class="menu_depth02">
	                    	<li id="update"><a href="<c:url value='/admin/memberList'/>">전체 회원목록 관리</a></li>
	                        <li id="update"><a href="<c:url value='/admin/noticeList'/>">전체 공지사항 관리</a></li> 
	                        <li id="myBoardList"><a href="<c:url value='/admin/boardList'/>">전체 게시물 관리</a></li> 
	                    </ul>
	                </li>
	            </ul>
	        </div>
			<div class="content">
				<div class="profile">
					<div class="user_info">
						<span class="name" id="spanNickname">관리자 님</span>
					</div>
				</div>
				<div class="wrapper">
				<!-- contents -->
				<div class="main p-3">
					<div class="headingArea">
						<div class="title">
							<h1 id="itemTitle">전체 회원 조회</h1>
						</div>
					</div>
					<div class="section_block">
						<div class="container mt-3">
						  <!-- <h2>내 게시물 목록</h2> -->
						  <table class="table">
						    <thead class="table-dark">
						      <tr>
						        <th scope="col">회원 아이디</th>
						        <th scope="col">이름</th>
						        <th scope="col">닉네임</th>
						        <th scope="col">이메일</th>
						        <th scope="col">가입일시</th>
						        <th scope="col">상세보기/삭제</th>
						      </tr>
						    </thead>
						    <tbody>
						    	<c:forEach var="member" items="${pageResponseDTO.list}">
							      <tr>
							        <td>${member.mid}</td>
							        <td>${member.member_Name}</td>
							        <td>${member.nickname}</td>
							        <td>${member.email}</td>
							        <td>${member.signup_Date}</td>
							        <td>
							        	<div class="btn_big_wrap">
											<button type="button" onclick="location.href='<c:url value='/admin/detailMember'/>?mid=${member.mid}'" class="btn btn-outline-dark">상세보기</button>
	   										<button type="button" onclick="location.href='<c:url value='/admin/removeMember'/>?mid=${member.mid}'" class="btn btn-outline-dark">삭제</button>
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
	            self.location = "memberList?" + param; // 경로
		    });
		});
	</script>

</body>
</html>