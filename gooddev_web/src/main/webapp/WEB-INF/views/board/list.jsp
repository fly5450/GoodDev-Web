<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
	<div class="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class = "main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
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
									<td><a href="#" class="read-link" data-board-bno="${board.bno}" data-page = "${pageResponse.page}" data-link="${pageRequestDTO.link}">${board.title}</a></td>
									<td>${board.mid}</td>
									<td>${board.formatDate}</td>
									<td>${board.view_cnt}</td>
									<td>${board.like_cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<a href="#" class="board-list-insert" data-category_no="${pageRequestDTO.category_no}">글쓰기</a>
					<jsp:include page="/WEB-INF/views/commons/page_nav.jsp"></jsp:include>
				</div>
				<%@ include file="/WEB-INF/views/commons/top10List.jsp" %>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
	<script>
		
		document.addEventListener('DOMContentLoaded', function() {
			let links = document.querySelectorAll('.read-link');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let boardBno = link.getAttribute('data-board-bno');
                    let pageLink = link.getAttribute('data-link');
                    let page = link.getAttribute('data-page');
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "read?bno=" + boardBno + "&link="+encodedLink;
                });
            });
            links = document.querySelectorAll('.board-list-insert');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let category_no = link.getAttribute('data-category_no');
                    link.href = "insert?" +"category_no="+ category_no;
                });
            });
        });
	</script>

</body>
</html>

