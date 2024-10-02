// $(document).ready(function() {
//     let isValidId = false;
//     let isEmailValid = false;
//     let isPasswordValid = false;

//     // 아이디 중복 확인
//     $("#checkIdBtn").click(function() {
//         const checkMid = $("#mid").val();
//         if (!checkMid) {
//             $("#idCheckMessage").text("아이디를 입력해주세요.");
//             isValidId = false;
//             return;
//         }

//         $.ajax({
//             url: contextPath + '/member/checkIdDuplicate',
//             type: 'POST',
//             data: { mid: checkMid },
//             success: function(response) {
//                 if (response === "invalid") {
//                     $("#idCheckMessage").text("유효하지 않은 아이디 형식입니다.");
//                     isValidId = false;
//                 } else if (response === "duplicate") {
//                     $("#idCheckMessage").text("이미 사용 중인 아이디입니다.");
//                     isValidId = false;
//                 } else if (response === "available") {
//                     $("#idCheckMessage").text("사용 가능한 아이디입니다.");
//                     isValidId = true;
//                 }
//             },
//             error: function() {
//                 $("#idCheckMessage").text("서버 오류가 발생했습니다. 다시 시도해주세요.");
//                 isValidId = false;
//             }
//         });
//     });

//     // 비밀번호 유효성 검사
//     $("#password").blur(function() {
//         const password = $(this).val();
//         const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
//         if (passwordRegex.test(password)) {
//             $("#passwordCheckMessage").text("유효한 비밀번호 형식입니다.");
//             isPasswordValid = true;
//         } else {
//             $("#passwordCheckMessage").text("비밀번호는 8자 이상이어야 하며, 영문자와 숫자를 포함해야 합니다.");
//             isPasswordValid = false;
//         }
//     });

//     // 이메일 유효성 검사 추가
//     $("#email").blur(function() {
//         const email = $(this).val();
//         const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

//         if (emailRegex.test(email)) {
//             $("#emailCheckMessage").text("유효한 이메일 형식입니다.");
//             isEmailValid = true;
//         } else {
//             $("#emailCheckMessage").text("유효하지 않은 이메일 형식입니다.");
//             isEmailValid = false;
//         }
//     });

//     // 폼 제출 전 유효성 검사
//     $("#registerForm").submit(function(e) {
//         e.preventDefault(); // 기본 동작을 막음

//         if (!isValidId) {
//             $("#idCheckMessage").text("아이디 중복 확인을 해주세요.");
//         } else if (!isEmailValid) {
//             $("#emailCheckMessage").text("유효한 이메일을 입력해주세요.");
//         } else if (!isPasswordValid) {
//             $("#passwordCheckMessage").text("비밀번호를 확인해주세요.");
//         } else {
//             this.submit(); // 모든 유효성 검사가 통과되면 폼을 제출
//         }
//     });
// });
