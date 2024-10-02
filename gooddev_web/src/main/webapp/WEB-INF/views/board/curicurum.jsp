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
				<div class="curicurum-container">
					<c:choose>
						<c:when test="${curicurum == 'MSA5'}">
							<p>MSA5차 커리큘럼</p>
							<img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.47.10.png" alt="msa5차">
						</c:when>
						<c:when test="${curicurum == 'MSA6'}">
							<p>MSA6차 커리큘럼</p>
							<img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.48.00.png" alt="msa6차">
						</c:when>
						<c:when test="${curicurum == 'MSA7'}">
							<p>MSA7차 커리큘럼</p>
							<img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.57.45.png" alt="msa7차">
						</c:when>
					</c:choose>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
</body>
</html>
