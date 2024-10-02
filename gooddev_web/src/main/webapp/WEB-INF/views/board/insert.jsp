<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Board Insert</title>
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
					<form action="insert" method="post" enctype="multipart/form-data">
						<input type="hidden" name="link" value="${link}">
						<div class="mb-3">
                            <select name="category_no" >
								<c:forEach var="category" items="${totalCategory}">
                            		<option value = "${category.category_no}" <c:if test="${category_no == category.category_no}">selected</c:if>>${category.category_name}</option>
								</c:forEach>
							</select>
                        </div>
						<div class="input-group mb-3">
							<span class="input-group-text">제목</span>
							<input name="title" class="form-control" placeholder="Title">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">내용</span>
							<input name="content" class="form-control" placeholder="Content">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">게시글 비밀번호</span>
							<input name="board_password" class="form-control" placeholder="Password">
						</div>
						<div class="input-group mb-3">
							<span class="input-group-text">첨부파일</span>
							<input type="file" name="file" multiple><br />
						</div>
						<div class="input-group mb-3">
							<input name="mid" type="hidden" class="form-control" value="${loginInfo.mid}">
						</div>
						<input type="submit" class="btn btn-primary" value="등록">
						<input type="reset" class="btn btn-secondary" value="초기화">
						<a href="list?page=1&size=10&category=${param.category_no}">목록으로 돌아가기</a>
					</form>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
</body>
</html>

