<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지(공지사항 상세보기) - goodDev</title>

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
    	
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
</head>
<body>

	<h1>회원정보 상세</h1>
	<div style="text-align: right; margin: 10px;">
	    <form action="<c:url value='/logout' />" method="post">
	        <button type="submit">로그아웃</button>
	    </form>
	</div>
	<div>
		<h3>
			<span>아이디 : </span> <span id="member">${member.mid}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>이름: </span> <span>${member.member_Name}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>닉네임: </span> <span>${member.nickname}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>전화번호: </span> <span>${member.phone}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>이메일: </span> <span>${member.email}</span>
		</h3>
	</div>
	<div>
		<h3>
			<span>가입날짜: </span> <span>${member.signup_Date}</span>
		</h3>
	</div>
	<button type="button" onclick="history.back()" class="btn btn-outline-dark">뒤로가기</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/boardList?${pageRequestDTO.link}'" class="btn btn-outline-dark">목록</button>

	<script>
	 function confirmDelete(bno) {
        // 모달 열기
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmationModal'));
        deleteModal.show();

        //비활성화 버튼 클릭 시 삭제 처리
        document.getElementById('confirmDeleteButton').onclick = function() {
            //비활성화 요청
            fetch(`/${pageContext.request.contextPath}/admin/remove?bno=${bno}`)
                .then(response => {
                    if (response.ok) {
                        //성공 시 목록 페이지로 리디렉션
                        window.location.href = `${pageContext.request.contextPath}/admin/boardList?${pageRequestDTO.link}`;
                    } else {
                        //실패 시 알림 표시
                        alert("회원 비활성화에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error('비활성화 중 오류 발생:', error);
                    alert("회원 비활성화 중 오류가 발생했습니다.");
                });
        };
    }
	</script>
	
	<!-- 삭제 확인 모달 -->
	<div class="modal" id="deleteConfirmationModal" tabindex="-1" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="deleteConfirmationModalLabel">비활성화 확인</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <p>회원을 비활성화 하시겠습니까?</p>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-danger" id="confirmDeleteButton">비활성화</button>
	            </div>
	        </div>
	    </div>
	</div>
	
</body>
</html>