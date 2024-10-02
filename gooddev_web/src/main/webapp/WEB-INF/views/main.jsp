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
                <!-- Content (Notice, Boards, Gallery) -->
                <div class="content">
                    <!-- Notice Board -->
                        <div class="main-notice-board">
                            <h2>공지사항</h2>
                            <c:forEach var="notice" items="${noticeList}">
                                   <a href="#"class="main-list" data-board-bno="${notice.bno}">${notice.title}</a><br />
                            </c:forEach>
                        </div>
                    <!-- 게시판 Section -->
                    <div class="main-boards">
                        <c:forEach var="entry" items="${mainMap}">
                            <div class="main-boards-list">
                                <!-- key를 출력 -->
                                <h2>${entry.key}</h2>
                                <div class="board" id="board1">
                                    <c:forEach var="board" items="${entry.value}">
                                        <a href="#" class="main-list" data-board-bno="${board.bno}">${board.title}</a><br />
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- Gallery Section -->
                    <div class="gallery-container">
                        <h2>갤러리</h2>
                        <main class="main-gallery">
                                <c:forEach var="board" items="${galleryList}">
                                    <div class="gallery-item">
                                        <c:forEach var="boardFile" items="${board.boardFileDTOList}">
                                            <img src="board/download/${boardFile.fid}" alt="이미지"/>
                                        </c:forEach>
                                        <a href="#" class="main-list" data-board-bno="${board.bno}">${board.title}</a>
                                    </div>
                                </c:forEach>
                        </main>
                   
				    </div>
                </div>

                <div>
                    <!-- 로그인 Section -->
                    <c:set var="mid" value = "${loginInfo.mid}" />
                    <c:if test = "${empty mid}">
                        <div class="login-container">
                            <div>
                                <div class="login-btn">
                                    <a href="member/login">로그인하기</a>
                                </div>
                                <div class="login-links">
                                    <a href="member/findid" >아이디찾기</a>
                                    <a href="member/findpwd" >비밀번호찾기</a>
                                    <a href="member/register" >회원가입</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test = "${not empty mid}">
                        <div class="login-container" >
                            <div>
                            </div>
                            <div class="login-links">
                                <label class="login-message">${loginInfo.nickname}님 환영합니다</label>
                                <c:choose>
							        <c:when test="${not empty sessionScope.isAdminYn && sessionScope.isAdminYn == 'Y'}">
							            <a href="admin" >관리자페이지</a>
							        </c:when>
							        <c:otherwise>
							            <a href="member/myPage" >마이페이지</a>
							        </c:otherwise>
							    </c:choose>
                                <a href="member/logout" >로그아웃</a>
                            </div>
                        </div>
                    </c:if>
                    <%@ include file="/WEB-INF/views/commons/top10List.jsp" %>
                </div>
            </div>
            <!--광고부분-->
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
       <%@ include file="/WEB-INF/views/commons/footer.jsp" %>

    </div>
    <script>
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


            document.addEventListener('DOMContentLoaded', function() {
                let links = document.querySelectorAll('.main-list');
                links.forEach(function(link) {
                    link.addEventListener('click', function() {
                        let boardBno = link.getAttribute('data-board-bno');
                        let pageLink = window.location.href;
                        let encodedLink = encodeURIComponent(pageLink);
                        link.href = "board/read?bno=" + boardBno + "&link="+encodedLink;
                    });
                });
            });
        </script>
</body>
</html>
