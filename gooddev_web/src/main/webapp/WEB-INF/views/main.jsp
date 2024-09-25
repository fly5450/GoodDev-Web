<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>굿이야 사이트</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous">
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
        <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header>
            <h1>굿이야 웹사이트</h1>
            <div class="card-body">
            <form action="search" method="post" id = "searchForm">
                <div class="input-group mb-3">
                    <span class="input-group-text">통합검색</span>
                    <input name="keyword" id="keyword" class="form-control" placeholder="검색어를 입력해주세요">
                    <button type="submit" class="btn btn-primary">검색</button>
                </div>
            </form>
        </div>
        </header>

        <!-- Navigation -->
        <nav>
            <a href="#">공지사항</a>
            <a href="#">게시판</a>
            <a href="#">갤러리</a>
            <a href="#">커리큘럼</a>
            <a href="#">교육신청</a>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Sidebar (Hot/Real-time info) -->
            <div class="sidebar">
                <h2>실시간 HOT</h2>
                <p>광고 영역 등</p>
                <img src="ad_image.jpg" alt="광고 이미지" width="100%">
            </div>

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
                        <a href="member/login" class="login-button">로그인하기</a>
                    </div>
                    <div>
                        <a href="member/findId" >아이디찾기</a>
                        <a href="member/findPassword" >비밀번호찾기</a>
                        <a href="member/register" >회원가입</a>
                    </div>
                </div>
            </c:if>
            <c:if test = "${not empty mid}">
                <div class="login-container" >
                    <div>
                        <label class="login-message">${loginInfo.nickname}님 환영합니다</label>
                    </div>
                    <div>
                        <a href="member/myPage" >마이페이지</a>
                        <a href="member/logout" >로그아웃</a>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Footer -->
        <footer>
            <p>© 2024 굿이야. All rights reserved.</p>
        </footer>
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