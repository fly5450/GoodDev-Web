<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>굿이야 사이트</title>
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
                <div class="search-results-container">
					<c:forEach var="entry" items="${totalMap.entrySet()}">
						<section class="search-board">
							<h2>${entry.key}</h2>
							<ul class="search-board-list">
								<c:forEach var="board" items="${entry.value}">
									<li class="search-board-item"><a href="#" class="search-detail-link" data-board-bno="${board.bno}" data-page = "${pageResponse.page}" data-link="${pageRequestDTO.link}">${board.title}</a></li>
								</c:forEach>
								<li class="search-board-item more-link">
									<a href="#" class="search-plus-link" data-link="${pageRequestDTO.link}">해당 게시판의 결과 더보기</a>
								</li>
							</ul>
						</section>
					</c:forEach>
				</div>
            </div>
            <!--광고부분-->
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
       <%@ include file="/WEB-INF/views/commons/footer.jsp" %>

    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            let links = document.querySelectorAll('.search-detail-link');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let boardBno = link.getAttribute('data-board-bno');
                    let pageLink = link.getAttribute('data-link');
                    let page = link.getAttribute('data-page');
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "board/read?bno=" + boardBno + "&link="+encodedLink;
                });
            });
            links = document.querySelectorAll('.search-plus-link');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let pageLink = link.getAttribute('data-link');
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "board/list?"+encodedLink;
                });
            });
        });
        const form = document.querySelector("#searchForm");
        form.addEventListener("submit", e =>{
            e.preventDefault();

            const keyword = document.querySelector("#keyword").value;

            if (keyword == null || keyword == "") {
                alert("검색어를 입력해주세요");
            } else if (keyword.length < 2){
                alert("검색어를 2글자 이상 입력해 주세요");
            } else{
                form.submit();
            }
        });

        let message = "${message}";
        if (message !== null && message !== "") alert(message);
    </script>
</body>
</html>