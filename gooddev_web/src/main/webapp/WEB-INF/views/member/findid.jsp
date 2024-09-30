<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class="main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
                <h2>아이디 찾기</h2>
                <form action="<c:url value='/member/findid'/>" method="post">
                    <div>
                        <label for="email">이메일:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <button type="submit" class="btn-primary">아이디 찾기</button>
                </form>
            </div>

            <!--광고부분-->
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        </div>

        <!-- Footer -->
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>

    <!-- 모달 -->
    <div id="resultModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>아이디 찾기 결과</h2>
            <p id="modalMessage"></p>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        var modal = document.getElementById('resultModal');
        var span = document.getElementsByClassName('close')[0];
        var message = "${message}";
        
        if (message) {
            document.getElementById('modalMessage').textContent = message;
            modal.style.display = 'block';
        }
        
        span.onclick = function() {
            modal.style.display = 'none';
        }
        
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    });
    </script>
</body>
</html>
