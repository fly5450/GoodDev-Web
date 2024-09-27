<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Board Read</h1>
	<div>
		<h3>
			<span>게시판 번호 : </span> <span id="bno">${board.bno}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>아이디 : </span> <span>${board.mid}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>제목: </span> <span>${board.title}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>내용: </span> <span>${board.content}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>일자: </span> <span>${board.formatDate}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>조회수: </span> <span>${board.view_cnt}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>좋아요: </span> <span id="likeCount">${board.like_cnt}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>싫어요: </span> <span id="hateCount">${board.hate_cnt}</span>
		</h3>
	</div>
	<a href="list?&${pageRequestDTO.link}">뒤로가기</a>

	<a href="update?bno=${board.bno}&${pageRequestDTO.link}">수정</a>
	<button onclick="handleLikeHate('like')">좋아요</button>
	<button onclick="handleLikeHate('hate')">싫어요</button>
	<%-- 	<a href="remove?id=${param.id}&${pageRequestDTO.link}">삭제</a>
	<a href="list?&${pageRequestDTO.link}">목록</a>
 --%>
 	
 	<h1>Comment</h1>
 	<table>
 		<tbody>
 			<c:forEach var="comment" items="${commentAllByBno}">
	 			<tr>
	 				<td>
	 					<details>
	 						<summary>
								${comment.comment_content}	
	 						</summary>
								<input type="text">
								<button>작성</button>
 								<c:forEach var="cocoment" items="${comment.cocomment}">
									<tr>
										<td>${cocomment.comment_content}</td>
									</tr>
								</c:forEach>
	 					</details>
	 				</td>
	 			</tr>
	 		</c:forEach>
		</tbody>
 	</table>
 	<h5>댓글 작성</h5>
 	<form action="comment/insert" method="post">
 	<input type="hidden" name="bno" value="${board.bno}">
 	<input type="hidden" name="mid" value="${board.mid}">
		<div>
			<h3>
				<span>내용: </span>
				<input type="text" name="comment_content">
			</h3>
		</div>
		<input type="submit" value="등록">
		<input type="reset" value="초기화">
 	</form>
	<script>
    function handleLikeHate(action) {
    	const bno = parseInt(document.getElementById('bno').textContent);
        console.log("bno 값: ", bno);
        const url = "<%= request.getContextPath() %>/board/" + action;
        
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'bno=' + bno
        })
        .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json(); 
    	})
        .then(data => {
        	console.log(data);
            document.getElementById('likeCount').innerText = data.likeCount;
            document.getElementById('hateCount').innerText = data.hateCount;
        });
    }
</script>
</body>
</html>
