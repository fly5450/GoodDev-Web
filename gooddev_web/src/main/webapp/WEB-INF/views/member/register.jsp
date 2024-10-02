<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
            <div class="main-content">
                <div class="register-form">
                    <h2>회원가입</h2>
                    <form id="registerForm" action="<c:url value='/member/register'/>" method="post" enctype="application/x-www-form-urlencoded">
                        <div class="form-group">
                            <label for="mid">아이디:</label>
                            <input type="text" id="mid" name="mid" value="${memberDTO.mid}" required>
                            <button type="button" id="checkIdBtn">중복 체크</button>
                            <span id="idCheckMessage"></span>
                        </div>

                        <div class="form-group">
                            <label for="password">비밀번호:</label>
                            <input type="password" id="password" name="password" required>
                            <span id="passwordCheckMessage"></span>
                        </div>

                        <div class="form-group">
                            <label for="member_Name">이름:</label>
                            <input type="text" id="member_Name" name="member_name" value="${memberDTO.member_name}" required>
                        </div>

                        <div class="form-group">
                            <label for="nickname">닉네임:</label>
                            <input type="text" id="nickname" name="nickname" value="${memberDTO.nickname}" required>
                        </div>

                        <div class="form-group">
                            <label for="email">이메일:</label>
                            <input type="email" id="email" name="email" value="${memberDTO.email}" required>
                            <span id="emailCheckMessage"></span>
                        </div>

                        <div class="form-group">
                            <label for="phone">전화번호:</label>
                            <input type="tel" id="phone" name="phone" value="${memberDTO.phone}" required pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="000-0000-0000">
                        </div>

                        <button type="submit" name="register" value="register" id="registerBtn" formaction="<c:url value='/member/register'/>" class="submit-btn">가입하기</button>
                    </form>
                </div>
            </div>

            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            var contextPath = "${pageContext.request.contextPath}";
            let isValidId = false;
            let isEmailValid = false;
            let isPasswordValid = false;

            function ajaxRequest(url, method, data, successCallback, errorCallback) {
                var xhr = new XMLHttpRequest();
                xhr.open(method, url, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        successCallback(xhr.responseText);
                    } else {
                        errorCallback();
                    }
                };
                xhr.onerror = errorCallback;
                xhr.send(data);
            }

            // 아이디 중복 확인
            document.getElementById('checkIdBtn').addEventListener('click', function() {
                const checkMid = document.getElementById('mid').value;
                if (!checkMid) {
                    document.getElementById('idCheckMessage').textContent = "아이디를 입력해주세요.";
                    isValidId = false;
                    return;
                }

                ajaxRequest(
                    contextPath + '/member/checkIdDuplicate',
                    'POST',
                    'mid=' + encodeURIComponent(checkMid),
                    function(response) {
                        if (response === "invalid") {
                            document.getElementById('idCheckMessage').textContent = "유효하지 않은 아이디 형식입니다.";
                            isValidId = false;
                        } else if (response === "duplicate") {
                            document.getElementById('idCheckMessage').textContent = "이미 사용 중인 아이디입니다.";
                            isValidId = false;
                        } else if (response === "available") {
                            document.getElementById('idCheckMessage').textContent = "사용 가능한 아이디입니다.";
                            isValidId = true;
                        }
                    },
                    function() {
                        document.getElementById('idCheckMessage').textContent = "서버 오류가 발생했습니다. 다시 시도해주세요.";
                        isValidId = false;
                    }
                );
            });

            // 이메일 중복 및 유효성 확인
            document.getElementById('email').addEventListener('blur', function() {
                const checkEmail = this.value;
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                
                if (!checkEmail) {
                    document.getElementById('emailCheckMessage').textContent = "이메일을 입력해주세요.";
                    isEmailValid = false;
                    return;
                }

                if (!emailRegex.test(checkEmail)) {
                    document.getElementById('emailCheckMessage').textContent = "유효하지 않은 이메일 형식입니다.";
                    isEmailValid = false;
                    return;
                }

                ajaxRequest(
                    contextPath + '/member/checkEmailDuplicate',
                    'POST',
                    'email=' + encodeURIComponent(checkEmail),
                    function(response) {
                        if (response === "duplicate") {
                            document.getElementById('emailCheckMessage').textContent = "이미 사용 중인 이메일입니다.";
                            isEmailValid = false;
                        } else if (response === "available") {
                            document.getElementById('emailCheckMessage').textContent = "사용 가능한 이메일입니다.";
                            isEmailValid = true;
                        }
                    },
                    function() {
                        document.getElementById('emailCheckMessage').textContent = "서버 오류가 발생했습니다. 다시 시도해주세요.";
                        isEmailValid = false;
                    }
                );
            });

            // 비밀번호 유효성 검사
            document.getElementById('password').addEventListener('blur', function() {
                const password = this.value;
                const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$/;
                if (passwordRegex.test(password)) {
                    document.getElementById('passwordCheckMessage').textContent = "유효한 비밀번호 형식입니다.";
                    isPasswordValid = true;
                } else {
                    document.getElementById('passwordCheckMessage').textContent = "비밀번호는 6자 ~ 최대 15자 이며, 영문자와 숫자를 포함해야 합니다.";
                    isPasswordValid = false;
                }
            });

            // 폼 제출 이벤트 리스너
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                e.preventDefault(); // 기본 동작을 막음

                if (!isValidId) {
                    document.getElementById('idCheckMessage').textContent = "아이디 중복 확인을 해주세요.";
                    return;
                }
                
                if (!isEmailValid) {
                    document.getElementById('emailCheckMessage').textContent = "유효한 이메일을 입력해주세요.";
                    return;
                }
                
                if (!isPasswordValid) {
                    document.getElementById('passwordCheckMessage').textContent = "비밀번호를 확인해주세요.";
                    return;
                }

                // 모든 유효성 검사가 통과되면 폼을 제출
                let originalHref = document.getElementById('registerBtn').getAttribute('formaction');
                const redirectParam = window.location.href;
                this.action = originalHref + "?redirect=" + encodeURIComponent(redirectParam);
                this.submit();
            });
        });
    </script>
</body>
</html>
