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
	<c:if test="${not empty board.boardFileDTOList}">
		<c:forEach var="boardFile" items="${board.boardFileDTOList}">
			<div>
				<h3>
					<span>첨부파일: </span>
					<span><a href="download/${boardFile.fid}">${boardFile.file_name}</a></span>
				</h3>
			</div>
		</c:forEach>
	</c:if>
	<a href="list?&${pageRequestDTO.link}">뒤로가기</a>

	<a href="update?bno=${board.bno}&${pageRequestDTO.link}">수정</a>
	<button onclick="handleLikeHate('like')">좋아요</button>
	<button onclick="handleLikeHate('hate')">싫어요</button>
	<%-- 	<a href="remove?id=${param.id}&${pageRequestDTO.link}">삭제</a>
	<a href="list?&${pageRequestDTO.link}">목록</a>
 --%>
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
        return response.json(); // JSON으로 응답을 파싱
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
