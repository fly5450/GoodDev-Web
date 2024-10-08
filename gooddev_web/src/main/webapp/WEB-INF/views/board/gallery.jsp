<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>gallery</title>
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
				<div class="gallery-container">
					<main class="gallery">
							<c:forEach var="board" items="${pageResponseDTO.list}">
								<div class="gallery-item">
									<c:forEach var="boardFile" items="${board.boardFileDTOList}">
										<img src="download/${boardFile.fid}" alt="이미지"/>
									</c:forEach>
									<a href="read?bno=${board.bno}&link=${pageRequestDTO.link}" class="title">${board.title}</a>
								</div>
							</c:forEach>
					</main>
					<div class = "gallery-other-container">
						<a href="insert?category_no=${pageRequestDTO.category_no}">글쓰기</a>

					</div>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
</body>
</html>
