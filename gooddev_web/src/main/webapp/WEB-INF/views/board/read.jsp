<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<input type="hidden" id="sessionMid" value="${sessionMid}">
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
					<c:if test="${board.mid eq sessionMid}">
						<a href="#" class="board-read-update" data-bno="${board.bno}" data-page="${pageResponse.page}" data-link="${pageRequestDTO.link}">수정</a>
					    <a href="#" class="board-delete" data-bno="${board.bno}" onclick="confirmDelete(${board.bno})">삭제</a>
					</c:if>

				</div>

                <div class = "comment-section" id = "comment-section">
                    <c:forEach var="comment" items="${comments}">
                    <div class="comment" id="comment" data-cno="${comment.cno}">
                        <div class="comment-header">
                            <span class="comment-author">${comment.mid}</span>
                        </div>
                        <div class="comment-content">
                            ${comment.comment_content}
                        </div>
                         <div class="comment-actions">
                            <button class="reply-button" onclick="toggleReplySection('${comment.bno}','${comment.cno}')">답글보기</button>
                        </div>
                        <div class="reply-section" id="reply-section-${comment.cno}">
                            <div class="replies" id="replies-${comment.cno}"></div>
                            <input type="text" class="reply-input" id="reply-input-${comment.cno}" placeholder="답글을 입력하세요...">
                            <button class="reply-submit" onclick="submitReply('${comment.bno}','${comment.cno}','${loginInfo.mid}')">등록</button>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                <div>
                    <h5>댓글 작성</h5>
                     <div class="comment-form">
                        <div>
                            <h3>
                                <span>내용: </span>
                                <input type="text" id="comment_content">
                                <button class="submit-button" onclick="insertComment(${board.bno}, '${loginInfo.mid}')">등록</button>
                            </h3>
                        </div>
                    </div>
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
            	if (action == 'like') {
                	document.getElementById('likeCount').innerText = "좋아요 수: "+data.likeCount;
            	} else if (action == 'hate') {
                	document.getElementById('hateCount').innerText = "싫어요 수: "+data.hateCount;
            	}
            });
        }

         function toggleReplySection(bno,cno) {
            const replySection = document.getElementById("reply-section-"+cno);
            if (replySection.style.display === 'none' || replySection.style.display === '') {
                replySection.style.display = 'block';
                loadReplies(bno,cno);
            } else {
                replySection.style.display = 'none';
            }
        }

        function loadReplies(bno,cno) {
           const url = "<%= request.getContextPath() %>/comment/cocomment";
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'bno=' + bno + '&parent_cno=' + cno

            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log(data);
                const cocomments = data.cocomments;
                const commentContainer = document.getElementById("replies-"+cno);
                commentContainer.innerHTML = '';
                cocomments.forEach(comment => {
                    const commentElement = createReplyElement(comment);
                    commentContainer.appendChild(commentElement);
                });

            });
        }

        function createReplyElement(comment) {
            const replyDiv = document.createElement('div');
            replyDiv.className = 'reply';
            replyDiv.innerHTML = 
                '<div class="comment-header">' +
                    '<span class="comment-author">' + comment.mid + '</span>' +
                '</div>' +
                '<div class="comment-content">' +
                    comment.comment_content +
                '</div>';
            return replyDiv;
        }

        function submitReply(bno,cno,mid) {
            const isLoggedIn = <%= request.getSession().getAttribute("loginInfo") != null %>;

            if (!isLoggedIn) {
                alert("로그인이 필요합니다.");
                const currentUrl = window.location.href;
                window.location.href = "<%= request.getContextPath() %>/member/login?redirect="+encodeURIComponent(currentUrl);
                return;
            }
            const url = "<%= request.getContextPath() %>/comment/insert";
            const commentInput = document.getElementById("reply-input-"+cno);
            const content = commentInput.value.trim();
            const commentContainer = document.getElementById("replies-"+cno);
            if (content) {
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'bno=' + bno + '&parent_cno=' + cno + '&mid='+mid+'&comment_content='+content

                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    const comment = data.comment;
                    const commentElement = createReplyElement(comment);
                    commentContainer.appendChild(commentElement);
                    commentInput.value = '';
                });
            }
        }

        function insertComment(bno, mid) {
            const isLoggedIn = <%= request.getSession().getAttribute("loginInfo") != null %>;

            if (!isLoggedIn) {
                alert("로그인이 필요합니다.");
                const currentUrl = window.location.href;
                window.location.href = "<%= request.getContextPath() %>/member/login?redirect="+encodeURIComponent(currentUrl);
                return;
            }

            const url = "<%= request.getContextPath() %>/comment/insert";
            const commentInput = document.getElementById("comment_content");
            const commentValue = commentInput.value;
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'bno=' + bno + '&mid=' + encodeURIComponent(mid) + '&comment_content=' + encodeURIComponent(commentValue)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                const comment = data.comment;
                const commentsDiv = document.getElementById("comment-section");
                const commentItem = 
                    '<div class="comment" id="comment" data-cno="' + comment.cno + '">' +
                        '<div class="comment-header">' +
                            '<span class="comment-author">' + comment.mid + '</span>' +
                        '</div>' +
                        '<div class="comment-content">' +
                            comment.comment_content +
                        '</div>' +
                        '<div class="comment-actions">' +
                            '<button class="reply-button" onclick="cocomment(' + comment.bno + ', ' + comment.cno + ')">답글보기</button>' +
                            '<div id="cocomments_' + comment.cno + '" style="display: none;"></div>' +
                            '<div>' +
                                '<h3>' +
                                    '<span>내용: </span>' +
                                    '<input type="text" id="cocomment_content_' + comment.cno + '">' +
                                    '<button class="submit-button" onclick="insertCocomment(' + comment.bno + ', ' + comment.cno + ', \'' + mid + '\')">등록</button>' +
                                '</h3>' +
                            '</div>' +
                        '</div>' +
                    '</div>';
                commentsDiv.innerHTML += commentItem;
            });
        }

        function insertCocomment(bno,cno,mid) {
            const isLoggedIn = <%= request.getSession().getAttribute("loginInfo") != null %>;

            if (!isLoggedIn) {
                alert("로그인이 필요합니다.");
                const currentUrl = window.location.href;
                window.location.href = "<%= request.getContextPath() %>/member/login?redirect="+encodeURIComponent(currentUrl);
                return;
            }

        }
        
        document.addEventListener('DOMContentLoaded', function() {
            links = document.querySelectorAll('.board-read-update');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                	let bno = link.getAttribute('data-bno');
                	let pageLink = link.getAttribute('data-link');
                    let page = link.getAttribute('data-page');
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "update?bno=" + bno + "&link="+encodedLink;
                });
            });
        });
        
        function confirmDelete(bno) {
        	const password = prompt("게시물 비밀번호를 입력하세요.")
        	if (password !== null) {
        		fetch("<%= request.getContextPath() %>/board/delete", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'bno=' + bno + '&board_password=' + encodeURIComponent(password)
                })
                .then(response => {
                	if (response.ok) {
                		return response.json();
                	} 
                })
                .then(data => {
                	console.log(data);
                	if (data.success) {
                		alert("게시물이 삭제되었습니다.")
                		 window.location.href = "<%= request.getContextPath() %>/board/list"; 
                    } else {
                        alert("비밀번호가 틀렸습니다. 삭제를 실패하였습니다.");
                    }
                });
        	}
        }
	</script>
</body>
</html>
