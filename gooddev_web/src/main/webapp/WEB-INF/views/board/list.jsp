<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
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
	<h1>Board List</h1>
	<div class="card-body">
		<table class="table" style="">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">일자</th>
					<th scope="col">조회수</th>
					<th scope="col">좋아요</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${pageResponseDTO.list}">
					<tr>
						<td>${board.bno}</td>
						<td><a href="read?bno=${board.bno}&${pageRequestDTO.link}">${board.title}</a></td>
						<td>${board.mid}</td>
						<td>${board.formatDate}</td>
						<td>${board.view_cnt}</td>
						<td>${board.like_cnt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div>
	    <div>
	        <p>실시간 TOP10</p>
	    </div>
	    <div>
	        <table>
		        <tbody>
	                <c:forEach var="board" items="${topTenList}"> <!-- TOP 10 리스트를 위한 데이터 -->
	                    <tr>     
	                        <td><a href="read?bno=${board.bno}&${pageRequestDTO.link}">${board.title}</a></td>
	                    </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	    </div>
	</div>
	<br/>
	<a href="insert">글쓰기</a>
	
	<jsp:include page="/WEB-INF/views/inc/page_nav.jsp"></jsp:include>
</body>
</html>
