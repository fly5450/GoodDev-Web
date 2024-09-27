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
		
		
		<!-- jQuery 외부 라이브러리  설정-->
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.7.1.min.js"></script>
		
		<!-- external css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/updateMember.css">
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		function changedPassword() {
			//비밀번호 입력 데이터 양식 검사
			var totalResult = true;
			
			//goodPassword 1차 검사 (영어 대소문자, 숫자 10 - 15자이하)
			var goodPasswordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10,15}$/;
			var goodPasswordResult = goodPasswordPattern.test($("#pwdCheck1").val());
			if(goodPasswordResult) {
				$("#passwordSpan1").removeClass("text-danger");
				$("#passwordSpan1").html("");
			} else {
				$("#passwordSpan1").addClass("text-danger");
				$("#passwordSpan1").html("영어 대소문자, 숫자 10 ~ 15자이하로 작성해주세요.");
				totalResult = false;
			}
			
			//goodPassword 일치 확인 2차 검사
			if($('#pwdCheck1').val()) == $('#pwdCheck2').val()) {
				$("#passwordSpan2").removeClass("text-danger");
				   $("#passwordSpan2").html("");
				} else {
					$("#passwordSpan2").html("비밀번호가 일치하지 않습니다.");
		            $("#passwordSpan2").addClass("text-danger");
		            totalResult = false;
				}
				
				if (totalResult) {
					var changedPwd = $("#pwdCheck1").val();
					$('#changePasswordModal').modal('hide');
					$("#changedPassword").val(changedPwd);
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
							<a class="menu_depth01" href="/myPage">나의 정보</a>
							<ul class="menu_depth02">
								<li id="update"><a href="updateMember">회원 정보 수정</a></li>
								<li id="myBoardList"><a href="myBoardList">나의 작성 게시물</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div class="content">
					<form action="updateMemberInfo" method="post" id="updateForm">
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
											<input type="text" id="masName" placeholder="${good_member.memberName}" readonly>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">아이디</p>
									</div>
									<div class="td">
										<div class="input_clear sm">
											<input type="text" id="masId" placeholder="${good_member.mid}" readonly>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">비밀번호</p>
									</div>
									<div class="td">
										<button id="modalOpenButton1" class="secession_btn btn white" type="button" data-bs-toggle="modal" data-bs-target="#changePasswordModal">비밀번호 변경</button>
										<input type="hidden" id="changedPassword" name="changedPassword" value="${good_member.password}">
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">휴대폰 번호</p>
									</div>
									<div class="td">
										<div class="form_set">
											<div class="input_clear sm">
												<input type="text" id="orgMphone"  placeholder="${good_member.phone}" readonly>
												<input type="hidden" id="changedMphone" name="mphone" value="${good_member.phone}">
											</div>
											<button id="modalOpenButton2" class="secession_btn btn white" type="button" data-bs-toggle="modal" data-bs-target="#changePhoneModal" style="margin-left: 10px;">휴대폰 번호 변경</button>
										</div>
									</div>
								</div>
								<div class="tr">
									<div class="th">
										<p class="form_label">이메일</p>
									</div>
									<div class="td">
										<div class="input_clear">
											<input type="text" 
											readonly="readonly" 
											title="이메일 주소 입력" 
											name="mbr.mbrEmail" 
											id="mbrEmail" 
											value="${member.memail}" 
											placeholder="이메일 주소 입력">
											<button type="button" class="clear_btn"><span class="blind">삭제</span></button>
											<p class="err_txt" id="descMbrEmail"></p>
										</div>
									</div>
								</div>
								<div class="container btncont">
									<button id="modalOpenButton3" class="secession_btn" type="button" data-bs-toggle="modal" data-bs-target="#removeMemberModal">회원탈퇴</button>
								</div>
							</div>
						</div>
						<div class="btn_big_wrap btn_size_fix mt60">
							<button type="button" onclick="location.href='myPage'" class="white btn_cancle">취소</button>
							<button type="submit" class="btn_submit">완료</button>
						</div>
					</form>
				<!-- 회원 탈퇴 모달 -->
				<div class="modal" id="removeMemberModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title">탈퇴 주의사항</h4>
				        <h3>탈퇴하면 복구 되지 않습니다.</h3>
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
				      </div>
				      <input id="pwdCheck1" value="" style="width:70%; margin-left: auto; margin-right: auto;" type="password" placeholder="알파벳 대소문자, 숫자를 혼용해서 10자 이상 15자 이하"></input>
				      <span id="passwordSpan1"></span>
				      <input id="pwdCheck2" value="" style="width:70%; margin-left: auto; margin-right: auto;" type="password" placeholder="다시 한 번 입력해주세요."></input>
				      <span id="passwordSpan2"></span>
				      <div class="modal-footer">
				        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
						<button type="button" id="changePasswordButton" onclick="changePassword()">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전화번호 변경 모달 -->
				<div class="modal" id="changePhoneModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title">전화번호 변경</h4>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				      <div class="modal-body">
				        <p>새로운 전화번호를 입력해주세요.</p>
				      </div>
				      <input id="phoneCheck" style="width:70%; margin-left: auto; margin-right: auto;" type="text" value="" placeholder="'-' 없이 입력해주세요."></input>
				      <div class="modal-footer">
				        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
						<button type="button" id="changePhoneButton" onclick="changeMphone()">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>