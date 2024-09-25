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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/updateMember.css">
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
		
</head>
<body>

	<div class="content">
		<form action="fixNewMemberInfo" method="post" id="updateForm">
		    <div class="tit_area line_thick">
				<strong class="tit_lv2">회원정보 수정</strong> 
			</div>
			<div class="section_block1">
				<div class="tit_area">
					<strong>회원 정보</strong>
				</div>
				<div class="form_table">
					<div class="tr">
						<div class="th">
							<p class="form_label">이름</p>
						</div>
						<div class="td">
							<div class="input_clear sm">
								<input type="text" id="masName" placeholder="${member.mname}" readonly>
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
							<input type="hidden" id="changedMpassword" name="mpassword" value="${member.mpassword}">
						</div>
					</div>
					<div class="tr">
						<div class="th">
							<p class="form_label">휴대폰 번호</p>
						</div>
						<div class="td">
							<div class="form_set">
								<div class="input_clear sm">
									<input type="text" id="orgMphone"  placeholder="${member.mphone}" readonly>
									<input type="hidden" id="changedMphone" name="mphone" value="${member.mphone}">
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
				<button type="button" onclick="location.href='mypage'" class="white btn_cancle">취소</button>
				<button type="submit" class="btn_submit">완료</button>
			</div>
		</form>
		<!-- 회원 탈퇴 모달 -->
		<div class="modal" id="removeMemberModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title">탈퇴 주의사항</h4>
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
		      <input id="pwcheck1" value="" type="password" placeholder="알파벳 대소문자, 숫자, 특수문자를 혼용해서 10자 이상 15자 이하"></input>
		      <span id="mpasswordSpan1"></span>
		      <input id="pwcheck2" value="" type="password" placeholder="한 번 더 입력해주세요."></input>
		      <span id="mpasswordSpan2"></span>
		      <div class="modal-footer">
		        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
				<button type="button" id="changePasswordButton" onclick="changeMpassword()">확인</button>
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
		      <input id="phoneCheck" type="text" value="" placeholder="'-' 없이 입력해주세요."></input>
		      <span id="mphoneSpan"></span>	
		      <div class="modal-footer">
		        <button type="button" id="modalCloseButton" data-bs-dismiss="modal">취소</button>
				<button type="button" id="changePhoneButton" onclick="changeMphone()">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>

</body>
</html>