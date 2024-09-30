<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 굿이야</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        
        <div class="main-content">
            <h2>아이디 찾기</h2>
            <form id="findIdForm">
                <div>
                    <label for="email">이메일:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <button type="submit">아이디 찾기</button>
            </form>
        </div>
        
        <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
        <%@ include file="/WEB-INF/views/commons/footer.jsp" %>
    </div>
    
    <div id="resultModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>아이디 찾기 결과</h2>
            <div id="resultMessage"></div>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        var modal = $('#resultModal');
        var span = $('.close');

        span.click(function() {
            modal.css('display', 'none');
        });

        $(window).click(function(event) {
            if (event.target == modal[0]) {
                modal.css('display', 'none');
            }
        });

        $('#findIdForm').submit(function(e) {
            e.preventDefault();
            
            $.ajax({
                url: '<c:url value="/member/findid"/>',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    if(response.foundId) {
                        $('#resultMessage').text('찾은 아이디: ' + response.foundId).css('color', 'green');
                    } else {
                        $('#resultMessage').text('일치하는 정보가 없습니다.').css('color', 'red');
                    }
                    modal.css('display', 'block');
                },
                error: function() {
                    $('#resultMessage').text('오류가 발생했습니다. 나중에 다시 시도해주세요.').css('color', 'red');
                    modal.css('display', 'block');
                }
            });
        });
    });
    </script>
    
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
        max-width: 500px;
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
</body>
</html>
