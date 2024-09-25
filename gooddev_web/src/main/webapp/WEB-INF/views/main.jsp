<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>main</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous">
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
        <style>
        .input-group {
            max-width: 400px; /* 원하는 너비로 설정 (예: 400px) */
            margin: auto; /* 중앙 정렬 */
        }
        .input-group .form-control {
            width: auto; /* 자동 너비 조정 */
            flex: 1; /* 버튼과 입력 필드가 같은 비율로 공간을 차지하도록 설정 */
        }
        .btn {
            white-space: nowrap; /* 버튼 텍스트가 줄바꿈되지 않도록 설정 */
        }
        .login-container {
            max-width: 600px; /* 최대 너비 */
            height: 120px;
            margin: 100px auto; /* 중앙 정렬 및 여백 */
            padding: 20px; /* 패딩 */
            border: 1px solid #ddd; /* 테두리 */
            border-radius: 5px; /* 모서리 둥글게 */
            background-color: #fff; /* 배경 색상 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            position: absolute; /* 절대 위치 설정 */
            right: 20px;
        }
        .login-button {
            display: flex; /* Flexbox 활성화 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center;
            width: 100%; /* 버튼을 가득 채움 */
            padding: 15px; /* 버튼 패딩 */
            font-size: 20px; /* 버튼 글자 크기 */
            background-color: #0eb4fc; /* 네이버 초록색 */
            color: white; /* 글자 색상 */
            border: none; /* 테두리 제거 */
            border-radius: 5px; /* 모서리 둥글게 */
            cursor: pointer; /* 커서 변경 */
            text-decoration: none; /* 링크 스타일 제거 */
        }
        .login-button:hover {
            background-color: #18B600; /* 호버 시 색상 변경 */
        }
        .login-plus{
            display: flex; /* Flexbox 활성화 */
            justify-content: center; /* 수평 중앙 정렬 */
        }
        .login-message {
            font-size: 24px; /* 글씨 크기를 크게 설정 */
            color: #4CAF50;  /* 녹색 계열로 설정 */
            font-weight: bold; /* 굵은 글씨체 */
            display: flex;
            justify-content: center; /* 수평 정렬 */
            align-items: center;
            font-family: 'Arial', sans-serif; /* 폰트 설정 */
        }
    </style>
    </head>
    <body>
        <div class="card-body">
            <form action="search" method="post" id = "searchForm">
                <div class="input-group mb-3">
                    <span class="input-group-text">통합검색</span>
                    <input name="keyword" id="keyword" class="form-control" placeholder="검색어를 입력해주세요">
                    <button type="submit" class="btn btn-primary">검색</button>
                </div>
            </form>
        </div>
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