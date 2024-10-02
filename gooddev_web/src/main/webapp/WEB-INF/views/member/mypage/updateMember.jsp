<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 -  goodDev</title>
		

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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/updateMember.css">
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		function changePassword() {
			// 비밀번호 입력 데이터 양식 검사
			let totalResult = true;
			
			// 비밀번호 1차 검사 (영어, 숫자 포함 6 - 20자 이하)
			const goodPasswordPattern = /^(?=.*\d)(?=.*[a-z]).{6,20}$/;
			const pwd1 = document.getElementById("pwdCheck1").value;
			const pwd2 = document.getElementById("pwdCheck2").value;
			
			if (goodPasswordPattern.test(pwd1)) {
			  document.getElementById("passwordSpan1").classList.remove("text-danger");
			  document.getElementById("passwordSpan1").innerHTML = "";
			} else {
			  document.getElementById("passwordSpan1").classList.add("text-danger");
			  document.getElementById("passwordSpan1").innerHTML = "영어 , 숫자 포함 6 ~ 20자이하로 작성해주세요.";
			  totalResult = false;
			}
			
			// 비밀번호 일치 확인 2차 검사
			if (pwd1 === pwd2) {
			  document.getElementById("passwordSpan2").classList.remove("text-danger");
			  document.getElementById("passwordSpan2").innerHTML = "";
			} else {
			  document.getElementById("passwordSpan2").classList.add("text-danger");
			  document.getElementById("passwordSpan2").innerHTML = "비밀번호가 일치하지 않습니다.";
			  totalResult = false;
			}
			
			if (totalResult) {
			  const url = "<%= request.getContextPath() %>/member/updateMember";												// Fetch API를 사용하여 비밀번호 변경 요청
			  const changedPwd = pwd1; 												
			  fetch(url, {  
			    method: 'POST',
			    headers: {
			      'Content-Type': 'application/x-www-form-urlencoded'
			    },
			    body: 'newPassword=' + encodeURIComponent(changedPwd)
			  })
			  .then(response => {
			    if (!response.ok) {
			      throw new Error('Network response was not ok');
			    }
			    return response.json();
			  })
			  .then(data => {
			    if (data.success) {
			      alert('비밀번호가 성공적으로 변경되었습니다.');
			      const modal = bootstrap.Modal.getInstance(document.getElementById('changePasswordModal'));
			      if (modal) {
			        modal.hide();
			      } else {
			        console.error('모달 인스턴스를 찾을 수 없습니다.');
			      }
			      
			      document.getElementById("changedPassword").value = changedPwd;
			    } else {
			      alert('비밀번호 변경에 실패했습니다. 다시 시도해 주세요.');
			    }
			  })
			  .catch(error => {
			    console.error('There was a problem with the fetch operation:', error);
			    alert('오류가 발생했습니다. 다시 시도해 주세요.');
			  });
			}
		}
		
		</script>
		
</head>
<body>
	<div class="container wrap" style="width:100%; height: 100%; padding-top:100px; padding-bottom: 300px;">
		<div class="d-flex">
				<div id="my_box"  style="width:24%; height: 80%; padding: 0px 30px;">
					<h2 style="padding-bottom: 60px; width:15rem;"><a href="myPage" style="text-decoration-line: none; color:black;"><b>마이페이지</b></a></h2>
					<ul class="my_menu">
						<li id="menu1" style="height: 50%;">  
							<a class="menu_depth01" href="${pageContext.request.contextPath}/member/detailMember?mid=${member.mid}">내 정보</a>
							<ul class="menu_depth02">
								<li id="update"><a href="updateMember?mid=${loginInfo.mid}" onclick="changeStyle(this)">회원 정보 수정</a></li>
								<li id="update"><a href="myBoardList?mid=${loginInfo.mid}" onclick="changeStyle(this)">나의 작성 게시물</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="content">
					<div class="profile">
						<div class="user_info">
							<span class="name" id="spanNickname">${loginInfo.nickname} 님</span>
							<p class="date">가입일 : <span>${loginInfo.signup_Date}</span></p>
						</div>
					</div>
					<form action="${pageContext.request.contextPath}/updateMember" method="post" id="updateForm">
					    <div class="tit_area line_thick">
							<strong class="member_info2">회원정보 수정</strong> 
						</div>
						<div class="section_block1">
							<div class="member_info">
								<strong>회원 정보</strong>
							</div>
							<div class="form_table">
								<div class="tr">
									<div class="th">
										<p class="form_label">이름</p>
									</div>
									<div class="td">
										<div class="input_clear sm">
											<input type="text" id="masName" placeholder="${member.member_name}" readonly>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">아이디</p>
									</div>
									<div class="td">
										<div class="input_clear sm">
											<input type="text" id="masId" placeholder="${member.mid}" readonly>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">비밀번호</p>
									</div>
									<div class="td">
										<button id="modalOpenButton1" class="secession_btn btn white" type="button" data-bs-toggle="modal" data-bs-target="#changePasswordModal">비밀번호 변경</button>
										<input type="hidden" id="changedPassword" name="changedPassword" value="${member.password}">
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">휴대폰 번호</p>
									</div>
									<div class="td">
										<div class="form_set">
											<div class="input_clear sm">
												<input type="text" id="orgMphone"  placeholder="${member.phone}" readonly>
												<input type="hidden" id="changedMphone" name="mphone" value="${member.phone}">
											</div>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">이메일</p>
									</div>
									<div class="td">
										<div class="form_set">
											<div class="input_clear sm">
												<input type="email" id="mbrEmail"  placeholder="${member.email}" readonly>
											</div>
										</div>
									</div>
								</div>
								<div class="container btncont">
									<button id="modalOpenButton3" class="secession_btn" type="button" data-bs-toggle="modal" data-bs-target="#removeMemberModal">회원탈퇴</button>
								</div>
							</div>
						</div>
						<div class="btn_big_wrap btn_size_fix mt60">
							<button type="button" onclick="location.href='myPage'" class="white btn_cancel">취소</button>
							<button type="submit" class="btn_submit">완료</button>
						</div>
					</form>
				<!-- 회원 탈퇴 모달 -->
				<div class="modal" id="removeMemberModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title">탈퇴하면 복구되지 않습니다</h4>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				      <div class="modal-body">
				        <p>정말 탈퇴하시겠어요?</p>
				      </div>
				      <div class="modal-footer">
				        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
						<form action="removeMember" method="post">
						    <button type="submit" id="modalSubmitButton">확인</button>
						</form>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 비밀번호 변경 모달 -->
				<div class="modal" id="changePasswordModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title">비밀번호 변경</h4>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				      <div class="modal-body">
				        <p>새로운 비밀번호를 입력해주세요.</p>
				        <div style="margin-bottom: 3px;">
					        <input id="pwdCheck1" type="password" placeholder="알파벳 대소문자, 숫자를 혼용해서 10자 이상 15자 이하" style="width: 70%;">
					    </div>
					    <div style="text-align: width: 70%;">
					        <span id="passwordSpan1" class="text-danger"></span>
					    </div>
				        <div style="margin-bottom: 3px;">
					        <input id="pwdCheck2" type="password" placeholder="다시 한 번 입력해주세요." style="width: 70%;">
					    </div>
					    <div style="text-align: width: 70%;">
					        <span id="passwordSpan2" class="text-danger"></span>
					    </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
				        <button type="button" id="changePasswordButton" onclick="changePassword()">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		function changeStyle(element) {
		    // 모든 링크의 스타일을 초기화
		    document.querySelectorAll('.menu_depth02 a').forEach(link => {
		        link.parentElement.classList.remove('selected');
		    });
		    
		    // 선택된 링크에 스타일 적용
		    element.parentElement.classList.add('selected');
		}
	</script>

</body>
</html>