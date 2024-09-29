<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
</head>
<body>
	<div class="container">
        <!-- Header -->
        <%@ include file="/WEB-INF/views/commons/header.jsp" %>

        <!-- Navigation -->
        <%@ include file="/WEB-INF/views/commons/nav.jsp" %>

        <!--컨텐츠부분-->
        <div class = "main">
            <%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>

            <!-- Main Content -->
			<div class="board-read-container">
				<span id="bno" data-bno="${board.bno}" style="display: none;"></span>
				<!--제목 및 작성자정보영역-->
				<div class="board-read-header">
					<h1 class="board-read-title">${board.title}</h1>
					<div class="board-read-meta">
						<span class="board-read-author">작성자: ${board.mid}</span>
						<span class="board-read-date">일자: ${board.formatDate}</span>
					</div>
				</div>
				<!-- 내용 영역 -->
				<div class="board-read-content">
					<p>${board.content}</p>
					<c:if test="${not empty board.boardFileDTOList}">
						<div class="attachment-item">
							<span class="board-read-label">첨부파일:</span>
							<div class="attachment-dropdown">
								<button onclick="toggleDropdown()" class="attachment-button">파일 보기</button>
								<div id="attachment-Dropdown" class="attachment-dropdown-content">
									<c:forEach var="boardFile" items="${board.boardFileDTOList}">
										<a href="download/${boardFile.fid}">${boardFile.file_name}</a>
									</c:forEach>
								</div>
							</div>
						</div>
					</c:if>
				</div>

				<!-- 기타 정보 한 줄로 배치 -->
				<div class="board-read-info">
					<span id="likeCount" class="board-read-label">좋아요 수: ${board.like_cnt}</span>
					<button onclick="handleLikeHate('like')" class="board-read-button">좋아요 </button>
					<span id="hateCount" class="board-read-label">싫어요 수: ${board.hate_cnt}</span>
					<button onclick="handleLikeHate('hate')" class="board-read-button">싫어요</button>
				</div>
				<!--버튼기능들-->
				<div style="margin-top: 20px;">
					<a href="list?&${link}">돌아가기</a>
					<a href="update?bno=${board.bno}&${pageRequestDTO.link}">수정</a>
				</div>
                <div class = "comment-content">
                    <h1>Comment</h1>
                        <table>
                            <tbody>
                                <c:forEach var="comment" items="${commentAllByBno}">
                                    <tr>
                                        <td>
                                            <details>
                                                <summary>${comment.comment_content}</summary>
                                                <input type="text" placeholder="대댓글 내용">
                                                <button onclick="insertCocomment(${comment.cno})">작성</button>
                                                <c:forEach var="cocomment" items="${comment.cocomment}">
                                                    <div>
                                                        <span>${cocomment.comment_content}</span>
                                                    </div>
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
                            <input type="hidden" name="link" value="${param.link}">
                            <div>
                                <h3>
                                    <span>내용: </span>
                                    <input type="text" name="comment_content">
                                </h3>
                            </div>
                            <input type="submit" value="등록">
                            <input type="reset" value="초기화">
                        </form>
                </div>
            </div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>

	<script>
		function toggleDropdown() {
            document.getElementById("attachment-Dropdown").classList.toggle("show");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.attachment-button')) {
                var dropdowns = document.getElementsByClassName("attachment-dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }

		function handleLikeHate(action) {
            const isLoggedIn = <%= request.getSession().getAttribute("loginInfo") != null %>;

            if (!isLoggedIn) {
                alert("로그인이 필요합니다.");
                const currentUrl = window.location.href;
                window.location.href = "<%= request.getContextPath() %>/member/login?redirect="+encodeURIComponent(currentUrl);
                return;
            }

            const bno = parseInt(document.getElementById('bno').getAttribute('data-bno'));
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
                document.getElementById('likeCount').innerText = "좋아요 수: "+data.likeCount;
                document.getElementById('hateCount').innerText = "싫어요 수: "+data.hateCount;
            });
        }

        function insertCocomment(cno) {
            const replyContent = document.querySelector(`input[placeholder="대댓글 내용"]`).value;
            const bno = parseInt(document.getElementById('bno').textContent);
            const url = "<%= request.getContextPath() %>/comment/cocomment"; // 대댓글을 위한 URL
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `bno=${bno}&parentCno=${parentCno}&comment_content=${replyContent}`
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json(); 
            })
            .then(data => {
                // 대댓글 추가 후 UI 업데이트 필요
                console.log(data);
            });
        }
	</script>
</body>
</html>
