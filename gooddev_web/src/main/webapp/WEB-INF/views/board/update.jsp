<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	        <div class="board-update-container">
		        <form action="update" method="post" enctype="multipart/form-data">
		        	<input type="hidden" name="bno" value="${board.bno}"/>
		        	<input type="hidden" name="link" value="${link}"/>
		        	<div class="board-update-header">
		        		<input type="text" class="board-update-title" name="title" value="${board.title}"/>
		        		<div class="board-update-meta">
		        			<span class="board-update-author">작성자: ${board.mid}</span>
		        			<span class="board-update-date">일자: ${board.formatDate}</span>
		        		</div>
						<div class="input-group mb-3">
							<span class="input-group-text">첨부파일</span>
							<input type="file" name="file" multiple><br />
						</div>
		        	</div>
		        	<!-- 내용 영역 -->
		        	<div class="board-update-content">
		        		<input type="text" name="content" value="${board.content}"/>
		        		<c:if test="${not empty board.boardFileDTOList}">
							<div class="attachment-item">
								<span class="board-update-label">첨부파일:</span>
								<div class="attachment-dropdown">
									<button onclick="toggleDropdown()" class="attachment-button">파일 보기</button>
									<div id="attachment-Dropdown" class="attachment-dropdown-content">
										<c:forEach var="boardFile" items="${board.boardFileDTOList}">
											<a href="download/${boardFile.fid}">${boardFile.file_name}</a>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:if>
		        	</div>
		        	<!-- 기타 정보 한 줄로 배치 -->
					<div class="board-read-info">
						<span id="likeCount" class="board-read-label">좋아요 수: ${board.like_cnt}</span>
						<button onclick="handleLikeHate('like')" class="board-read-button">좋아요 </button>
						<span id="hateCount" class="board-read-label">싫어요 수: ${board.hate_cnt}</span>
						<button onclick="handleLikeHate('hate')" class="board-read-button">싫어요</button>
					</div>
					<!--버튼기능들-->
					<div style="margin-top: 20px;">
						<a href="${link}">돌아가기</a>
						<button type="submit" class="btn btn-primary">수정</button>
					</div>
				</form>
			</div>
		<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
    </div>
	<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
</div>
</body>
</html>