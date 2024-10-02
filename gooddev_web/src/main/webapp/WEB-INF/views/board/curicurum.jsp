<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>커리큘럼</title>
<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
	<div class="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
            <div class="main-content">
                <div class="content">
                    <div class="curicurum-container">
                        <div class="curicurum-board">
                            <h2>KOSA 국비지원 개발자 교육 커리큘럼 소개</h2>
                        </div>
                        <div class="curicurum-list">
                            <h2>MSA5차 커리큘럼</h2>
                            <img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.47.10.png" alt="msa5차">
                            <hr class="curriculum-divider">
                        
                            <h2>MSA6차 커리큘럼</h2>
                            <img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.48.00.png" alt="msa6차">
                            <hr class="curriculum-divider">

                            <h2>MSA7차 커리큘럼</h2>
                            <img src="${pageContext.request.contextPath}/resources/img/스크린샷 2024-10-01 오후 6.57.45.png" alt="msa7차">
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
 
</body>
</html>
