<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
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
									<td><a href="read?bno=${board.bno}&${pageRequestDTO.link}">${board.title}</a></td>
									<td>${board.mid}</td>
									<td>${board.formatDate}</td>
									<td>${board.view_cnt}</td>
									<td>${board.like_cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<a href="insert">글쓰기</a>
					<jsp:include page="/WEB-INF/views/commons/page_nav.jsp"></jsp:include>
				</div>
				<%@ include file="/WEB-INF/views/commons/top10List.jsp" %>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
</body>
</html>
