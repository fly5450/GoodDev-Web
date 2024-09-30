$(document).ready(function() {
    // 아이디 중복 체크
    $('#mid').blur(function() {
        $.ajax({
            url: contextPath + '/member/checkId',
            type: 'POST',
            data: {mid: $('#mid').val()},
            success: function(result) {
                if(result === 'available') {
                    $('#idCheck').text('사용 가능한 아이디입니다.').removeClass('text-danger').addClass('text-success');
                } else {
                    $('#idCheck').text('이미 사용 중인 아이디입니다.').removeClass('text-success').addClass('text-danger');
                }
            },
            error: function(xhr, status, error) {
                console.error("Error occurred: " + error);
                // 아이디 중복 체크 중 오류 메시지 표시
                $('#idCheck').text('아이디 중복 체크 중 오류가 발생했습니다.')
                             .removeClass('text-success')
                             .addClass('text-danger'); 
            }
        });
    });

    // 비밀번호 일치 확인
    $('#confirmPassword').keyup(function() {
        if($('#password').val() && $('#password').val() === $('#confirmPassword').val()) {
            $('#passwordMatch').text('비밀번호가 일치합니다.').removeClass('text-danger').addClass('text-success'); // 비밀번호 일치 확인 메시지 표시
        } else {
            $('#passwordMatch').text('비밀번호가 일치하지 않습니다.').removeClass('text-success').addClass('text-danger'); // 비밀번호 불일치 메시지 표시
        }
    });

    // 폼 제출 전 유효성 검사
    $('#registerForm').submit(function(e) {
        if(!this.checkValidity()) {
            e.preventDefault(); // 폼 제출 중지
            e.stopPropagation(); // 이벤트 전파 중지
        }
        // 비밀번호 일치 확인
        if($('#password').val() !== $('#confirmPassword').val()) {
            alert('비밀번호가 일치하지 않습니다.');
            e.preventDefault(); 
        }
        // 폼 유효성 검사 상태 추가
        $(this).addClass('was-validated'); 
    });
});
