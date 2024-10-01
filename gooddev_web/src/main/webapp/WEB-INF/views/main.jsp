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
                    <div class="notice-board">
                        <h2>공지사항</h2>
                        <ul>
                            <li>공지사항 1</li>
                            <li>공지사항 2</li>
                            <li>공지사항 3</li>
                        </ul>
                    </div>

                    <!-- 게시판 Section -->
                    <div class="boards">
                        <h2>게시판</h2>
                        <div class="board" id="board1">
                            <h3>게시판 1</h3>
                            <p>내용</p>
                        </div>
                        <div class="board" id="board2">
                            <h3>게시판 2</h3>
                            <p>내용</p>
                        </div>
                        <div class="board" id="board3">
                            <h3>게시판 3</h3>
                            <p>내용</p>
                        </div>
                    </div>
                    <!-- Gallery Section -->
                    <div class="gallery">
                        <h2>갤러리</h2>
                        <div>
                            <img src="gallery_img1.jpg" alt="사진 1" width="30%">
                            <img src="gallery_img2.jpg" alt="사진 2" width="30%">
                            <img src="gallery_img3.jpg" alt="사진 3" width="30%">
                        </div>
                    </div>

                    
                </div>
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
                            <div>
                                <label class="login-message">${loginInfo.nickname}님 환영합니다</label>
                            </div>
                            <div class="login-links">
                                <a href="member/myPage" >마이페이지</a>
                                <a href="member/logout" >로그아웃</a>
                            </div>
                        </div>
                    </div>
                </c:if>
                
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
            
        </script>
</body>
</html>
