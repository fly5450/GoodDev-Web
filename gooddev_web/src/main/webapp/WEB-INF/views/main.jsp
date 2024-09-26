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
        <header>
        <div class="header-container">
            <div class="logo-container">
                <img src="resources/img/good.png" alt="로고">
            </div>
            <div class="search-wrapper">
                <span class="search-label">통합검색</span>
                <div class="search-container">
                    <form action="search" method="post" id = "searchForm" class="search-form">
                            <input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                            <button type="submit" class="search-button">검색</button>
                    </form>
                </div>
            </div>
        </div>
        </header>

        <!-- Navigation -->
        <nav>
            <div class="menu-item">
                <a href="board/list?page=1&size=10&category_no=10" class = "navbar a">공지사항</a>
            </div>
            <div class = "menu-item">
                <a href="#" class = "navbar a">게시판</a>
                <div class="dropdown">
                    <div class="dropdown-item">
                        <a href="board/list?page=1&size=10&category_no=20" class = "navbar a">MSA5차</a>
                    </div>
                    <div class="dropdown-item">
                        <a href="board/list?page=1&size=10&category_no=30" class = "navbar a">MSA6차</a>
                    </div>
                    <div class="dropdown-item">
                        <a href="board/list?page=1&size=10&category_no=40" class = "navbar a">MSA7차</a>
                    </div>
                </div>
            </div>
            <div class="menu-item">
                <a href="board/gallery">갤러리</a>
            </div> <div class="menu-item">
                <a href="board/curicurum">커리큘럼</a>
            </div> <div class="menu-item">
                <a href="https://www.sw.or.kr/site/sw/edu/selectEduListGallery.do" >교육신청</a>
            </div>
        </nav>
        <div class = "main">
            <div class="sidebar">
                    <p>광고 영역 등</p>
                    <img src="ad_image.jpg" alt="광고 이미지" width="100%">
            </div>
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
                                <a href="member/findId" >아이디찾기</a>
                                <a href="member/findPassword" >비밀번호찾기</a>
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
            <div class="sidebar">
                    <p>광고 영역 등</p>
                    <img src="ad_image.jpg" alt="광고 이미지" width="100%">
            </div>
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
