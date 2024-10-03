<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>관리자 페이지(게시글 상세보기) - goodDev</title>

		<!-- Bootstrap 5를 위한 외부 라이브러리 설정 -->
		<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
		crossorigin="anonymous">
		<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
		
		<!-- external css -->
    	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/my_page.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/page_nav.css">
    	
</head>
<body>
	<h1>Board Read</h1>
	<div style="text-align: right; margin: 10px;">
	   <%@ include file="/WEB-INF/views/commons/minilogin.jsp" %>
	</div>
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
	<button type="button" onclick="history.back()" class="btn btn-outline-dark">뒤로가기</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/boardList?${pageRequestDTO.link}'" class="btn btn-outline-dark">목록</button>
	<script>
	 function confirmDelete(bno) {
        // 모달 열기
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmationModal'));
        deleteModal.show();

        // 삭제 버튼 클릭 시 삭제 처리
        document.getElementById('confirmDeleteButton').onclick = function() {
            // 삭제 요청
            fetch(`/${pageContext.request.contextPath}/admin/remove?bno=${bno}`)
                .then(response => {
                    if (response.ok) {
                        // 삭제 성공 시 목록 페이지로 리디렉션
                        window.location.href = `${pageContext.request.contextPath}/admin/boardList?${pageRequestDTO.link}`;
                    } else {
                        // 삭제 실패 시 알림 표시
                        alert("게시물 삭제에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error('삭제 중 오류 발생:', error);
                    alert("게시물 삭제 중 오류가 발생했습니다.");
                });
        };
    }
	</script>
	
	<!-- 삭제 확인 모달 -->
	<div class="modal" id="deleteConfirmationModal" tabindex="-1" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="deleteConfirmationModalLabel">삭제 확인</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <p>게시물을 삭제하시겠습니까?</p>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger" id="confirmDeleteButton">삭제</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>
