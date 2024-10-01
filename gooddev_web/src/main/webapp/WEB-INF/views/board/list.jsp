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
            <div class="main-content">
				<div class = "list-table-container">
					<table class="list-table">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">일자</th>
								<th scope="col">조회수</th>
								<th scope="col">좋아요</th>
							</tr>
						</thead>
						<tbody id="list_body">
							<c:forEach var="board" items="${pageResponseDTO.list}">
								<tr>
									<td >${board.bno}</td>
									<td><a href="#" class="list-title" data-board-bno="${board.bno}">${board.title}</a></td>
									<td>${board.mid}</td>
									<td>${board.formatDate}</td>
									<td>${board.view_cnt}</td>
									<td>${board.like_cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<input type="hidden" name="category_no" value="${pageRequestDTO.category_no}">
					<div>
						<%-- <a href="#" class="board-list-insert" data-category_no="${pageRequestDTO.category_no}">글쓰기</a> --%>
						<a href="insert?category_no=${pageRequestDTO.category_no}">글쓰기</a>
						<jsp:include page="/WEB-INF/views/commons/page_nav.jsp"></jsp:include>
						<div class="search-wrapper">
							<span class="search-label">제목+내용</span>
							<div class="search-container">
								<form action="list" method="get" class="search-form">
										<input name="page" type="hidden" class="search-input" value="${pageResponseDTO.page}">
										<input name="size" type="hidden" class="search-input" value="${pageResponseDTO.size}">
										<input name="category_no" type="hidden" class="search-input" value="${pageRequestDTO.category_no}">
										<input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
										<button type="submit" class="search-button">검색</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				<%@ include file="/WEB-INF/views/commons/top10List.jsp" %>
			</div>
			<%@ include file="/WEB-INF/views/commons/advertisement.jsp" %>
		</div>
		<%@ include file="/WEB-INF/views/commons/footer.jsp" %>
	</div>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			document.addEventListener('click', function(event) {
				if (event.target.classList.contains('page-button')) {
					event.preventDefault();
					const page = event.target.getAttribute('data-page');
					const size = `${pageResponseDTO.size}`;
					const category_no = `${pageRequestDTO.category_no}`;
					paginationClick(page, size, category_no);
				}
			});
		});

		async function paginationClick(page,size,category_no) {
			const destinationUrl = "<%= request.getContextPath() %>/board/list";
			const bodyData = 'page=' + page + '&size=' + size +'&category_no=' +category_no;
			let data = await doFetch(destinationUrl,bodyData);
			const container = document.getElementById("list_body");
			container.innerHTML = '';
			const list = data.pageResponseDTO.list;
			list.forEach(board => {
				const boardElement = createBoardElement(board,data.pageResponseDTO.page);
				container.appendChild(boardElement);
			});
			const pageButtons = document.querySelectorAll('.page-button');
			let num = data.pageResponseDTO.start;
			pageButtons.forEach(button => button.classList.remove('active'));
            pageButtons.forEach(button => {
				if(button.id === 'prev') {
					if(!data.pageResponseDTO.prev) button.style.display="none";
					else{
						button.setAttribute('data-page', data.pageResponseDTO.start-1);
						button.style.display="block";
					}
				}
				else if(button.id === 'next') {
					if(!data.pageResponseDTO.next) button.style.display="none";
					else{
						button.setAttribute('data-page', data.pageResponseDTO.end+1);
						button.style.display="block";
					}
				}
				else{
					button.setAttribute('data-page', num);
					button.innerText = '';
					button.innerText = num;
					if(data.pageResponseDTO.page == num) button.classList.add('active');
					if(num>data.pageResponseDTO.end) button.style.display="none";
					else button.style.display="block";
					num++;
				}
            });
			const url = new URL(window.location.href); // 현재 URL 가져오기
			url.searchParams.set("page", data.pageResponseDTO.page);
			url.searchParams.set("size", data.pageResponseDTO.size); // 파라미터 값 수정
			history.replaceState(null, '', url);
		}

		function createBoardElement(board,page) {
            const boardTr = document.createElement('tr');
           boardTr.innerHTML =
				'<td>' + board.bno + '</td>' +
				'<td><a href="read?bno=' + board.bno + '&link=' + encodeURIComponent(window.location.href) +
				'" class="list-title" data-board-bno="' + board.bno +
				'">' + board.title + '</a></td>' +
				'<td>' + board.mid + '</td>' +
				'<td>' + board.formatDate + '</td>' +
				'<td>' + board.view_cnt + '</td>' +
				'<td>' + board.like_cnt + '</td>';
			
			return boardTr;
        }

		document.addEventListener('DOMContentLoaded', function() {
			let links = document.querySelectorAll('.list-title');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let boardBno = link.getAttribute('data-board-bno');
                    let pageLink = window.location.href;
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "read?bno=" + boardBno + "&link="+encodedLink;
                });
            });
            /* links = document.querySelectorAll('.board-list-insert');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let category_no = link.getAttribute('data-category_no');
                    link.href = "insert?" +"category_no="+ category_no;
                });
            }); */
        });
	</script>

</body>
</html>

