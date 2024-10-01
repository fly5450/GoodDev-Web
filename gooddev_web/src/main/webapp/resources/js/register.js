$(document).ready(function() {
    // 비밀번호 일치 확인
    $('#confirmPassword').keyup(function() {
        if($('#password').val() && $('#password').val() === $('#confirmPassword').val()) {
            $('#passwordMatch').text('비밀번호가 일치합니다.').removeClass('text-danger').addClass('text-success');
        } else {
            $('#passwordMatch').text('비밀번호가 일치하지 않습니다.').removeClass('text-success').addClass('text-danger');
        }
    });

    // 폼 제출 전 유효성 검사
    $('#registerForm').submit(function(e) {
        if (!this.checkValidity()) {
            e.preventDefault(); // 폼 제출 중지
            e.stopPropagation(); // 이벤트 전파 중지
        }
        
        // 비밀번호 일치 확인
        if ($('#password').val() !== $('#confirmPassword').val()) {
            alert('비밀번호가 일치하지 않습니다.');
            e.preventDefault(); 
        }
        
        // 폼 유효성 검사 상태 추가
        $(this).addClass('was-validated'); 
    });

    // 아이디 중복 체크 버튼 클릭 이벤트
    $('#checkIdBtn').click(function() {
        var mid = $('#mid').val();
        if (mid) {
            $('#registerForm').attr('action', contextPath + '/member/checkIdDuplicate').submit();
        } else {
            alert('아이디를 입력해주세요.');
        }
    });
});
