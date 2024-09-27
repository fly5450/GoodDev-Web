<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정 - 굿이야 사이트</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
    <div class="container">
        <header>
            <div class="header-container">
                <div class="logo-container">
                    <img src="<c:url value='/resources/img/good.png'/>" alt="로고">
                </div>
                <div class="search-wrapper">
                    <span class="search-label">통합검색</span>
                    <div class="search-container">
                        <form action="<c:url value='/search'/>" method="post" id="searchForm" class="search-form">
                            <input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                            <button type="submit" class="search-button">검색</button>
                        </form>
                    </div>
                </div>
            </div>
        </header>
        
        <main>
            <h2>회원 정보 수정</h2>
            <form action="<c:url value='/member/edit'/>" method="post">
                <input type="hidden" name="mid" value="${memberDTO.mid}"/>
                
                <div class="form-group">
                    <label for="password">비밀번호:</label>
                    <input type="password" id="password" name="password" required/>
                </div>
                
                <div class="form-group">
                    <label for="memberName">이름:</label>
                    <input type="text" id="memberName" name="memberName" value="${memberDTO.memberName}" required/>
                </div>
                
                <div class="form-group">
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" value="${memberDTO.email}" required/>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호:</label>
                    <input type="tel" id="phone" name="phone" value="${memberDTO.phone}" required/>
                </div>
                
                <button type="submit" class="submit-button">수정 완료</button>
            </form>
        </main>
        
        <footer>
            <p>© 2024 굿이야(주). All rights reserved.</p>
        </footer>
    </div>
</body>
</html>