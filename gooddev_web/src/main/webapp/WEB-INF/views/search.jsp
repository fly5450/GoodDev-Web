<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
		.board {
			margin-bottom: 20px;
		}
        .board-list {
            list-style-type: none;
            padding: 0;
        }
        .board-item{
            margin-bottom: 10px;
        }
        .plus-link {
        display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #0066cc;
    }
       
    </style>
</head>
<body>
    <div class="container">
		<c:forEach var="entry" items="${totalMap.entrySet()}">
			<section class="board">
				<h2>${entry.key}</h2>
				<ul class="board-list">
					<c:forEach var="board" items="${entry.value}">
						<li class="board-item"><a href="#" class="detail-link" data-board-bno="${board.bno}" data-page = "${pageResponse.page}" data-link="${pageRequestDTO.link}">${board.title}</a></li>
					</c:forEach>
					 <li class="board-item" style="margin-top: 10px; text-align: right;">
						<a href="#" class="plus-link" data-link="${pageRequestDTO.link}">해당 게시판의 결과 더보기</a>
					</li>
				</ul>
			</section>
		</c:forEach>
	</div>
	<script>
		 document.addEventListener('DOMContentLoaded', function() {
	        let links = document.querySelectorAll('.detail-link');
	        links.forEach(function(link) {
	            link.addEventListener('click', function() {
	                let boardBno = link.getAttribute('data-board-bno');
	                let pageLink = link.getAttribute('data-link');
	                let page = link.getAttribute('data-page');
					let encodedLink = encodeURIComponent(pageLink);
	                link.href = "board/read?bno=" + boardBno + "&page="+page+"&link"+encodedLink;
	            });
	        });
			links = document.querySelectorAll('.plus-link');
	        links.forEach(function(link) {
	            link.addEventListener('click', function() {
	                let pageLink = link.getAttribute('data-link');
	                link.href = "board/list?&page=1"+pageLink;
	            });
	        });
	    });
	</script>
</body>
</html>