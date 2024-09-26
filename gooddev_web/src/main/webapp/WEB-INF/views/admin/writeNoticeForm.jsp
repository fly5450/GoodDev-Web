<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지(공지사항 작성) - goodDev</title>

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
		
		<!-- 사용자 정의 자바스크립트 -->
		<script>
		
		</script>
		
</head>
<body>
	<h1>공지사항 작성</h1>
	<div class="wrapper">
		<!-- contents -->
		<div class="main p-3">
			<div class="item-section mt-2 mb-2" style="font-size: 12px">
				게시판 관리 > 공지사항 등록
			</div>

			<div class="headingArea">
				<div class="title">
					<h1 id="itemTitle">공지사항 등록</h1>
				</div>
			</div>
			<div class="form_table no_line">
				<form name="writeNoticeForm" id="writeNoticeForm" method="post" action="writeNotice" enctype="multipart/form-data">
					<div class="tr">
						<div class="th">
							<p class="form_label required">분류 </p>
						</div>
						<div class="td">	
							<select name="category" id="category">
								<option value="general" selected>일반</option>
							</select>			
						</div>
					</div>
							
					<div class="tr">
						<div class="th">
							<p class="form_label required">게시글 제목</p>
						</div>
						<div class="td">
							<div class="textarea_group_title sm">
								<textarea id="btitle" name="btitle" title="게시글 제목 입력" placeholder="게시글 제목을 입력해주세요." maxlength="" ></textarea>
								<p class="form_bytes"><span class="byte">0</span>/100</p>
							</div>
						</div>
					</div>
					<div class="tr">
						<div class="th">
							<p class="form_label required">게시글 내용</p>
						</div>
						<div class="td">
							<div class="textarea_group_content lg">
								<textarea id="bcontent" name="bcontent" placeholder="게시글 내용을 입력해주세요." title="게시글 내용 입력" maxlength="1000"></textarea>
								<p class="form_bytes"><span class="byte">0</span>/1,000</p>
							</div>
							 <div class="attach_wrap">
								<div class="attach_top">
									<input type="hidden" name="uploadType" value="notice">
									<label class="attach_img" for="battach">사진 첨부</label>
									<p class="guide_txt">파일 1개당 10MB까지 첨부 가능합니다. (JPG, JPEG, PNG, GIF만 첨부 가능)</p>
									<input class="input_file" id="battach" name="battach" type="file">
								</div>
								<div class="attached" data-file="battach" id="inputUploadFile"></div>
							</div> 
							
						</div>
					</div>
					
					<div class="btn_big_wrap btn_size_fix">
						<button type="button" class="white" onclick="location.href='noticeList'">취소</button>
						<button type="submit" class="btnInsert">등록</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
</body>
</html>