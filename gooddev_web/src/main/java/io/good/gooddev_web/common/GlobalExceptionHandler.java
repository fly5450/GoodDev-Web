package io.good.gooddev_web.common;

import java.nio.file.AccessDeniedException;

import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({
        Exception.class,   // 일반 예외 / 에러코드 500
        RuntimeException.class,  // 런타임 예외 / 에러코드 400
        MethodArgumentNotValidException.class,  // 메서드 인자 유효성 검사 예외 /  에러코드 400
        HttpMessageNotReadableException.class,  // 메시지 읽기 / 에러코드 400
        AccessDeniedException.class,  // 접근 권한 / 에러코드 403
        ResourceNotFoundException.class,  // 리소스 없음 / 에러코드 500
        DataIntegrityViolationException.class,  // 데이터 제약 조건 위반 / 에러코드 409
        NoHandlerFoundException.class,  // 요청하신 페이지를 찾을 수 없습니다./에러코드 404 
        IllegalArgumentException.class  // 잘못된 요청입니다. 입력값을 확인해주세요./ 에러코드 400
    })
    public ResponseEntity<ErrorResponse> handleAllExceptions(Exception ex) {
        ExceptionInfo exceptionInfo = getExceptionInfo(ex);
        log.error(
            "예외 발생 - 유형: {}, 메시지: {}, 상태 코드: {}", 
            ex.getClass().getSimpleName(), ex.getMessage(), exceptionInfo.getStatus().value(), ex
        );
        return createErrorResponse(exceptionInfo.getMessage(), exceptionInfo.getStatus());
    }

    // 예외 유형에 따라 예외 정보를 반환하는 메서드
    private ExceptionInfo getExceptionInfo(Exception ex) {
        if (ex instanceof RuntimeException) { // 런타임 예외 발생
            return new ExceptionInfo(HttpStatus.BAD_REQUEST, "잘못된 요청입니다."); // 잘못된 요청 예외 발생
        } else if (ex instanceof MethodArgumentNotValidException) { // 메서드 인자 유효성 검사 예외 발생
            String message = ((MethodArgumentNotValidException) ex).getBindingResult().getAllErrors().get(0).getDefaultMessage(); // 예외 메시지 추출
            return new ExceptionInfo(HttpStatus.BAD_REQUEST, message); // 잘못된 요청 예외 발생
        } else if (ex instanceof HttpMessageNotReadableException) { // 메시지 읽기 예외 발생
            return new ExceptionInfo(HttpStatus.BAD_REQUEST, "잘못된 요청 형식입니다."); // 잘못된 요청 형식 예외 발생
        } else if (ex instanceof AccessDeniedException) { // 접근 권한 예외 발생
            return new ExceptionInfo(HttpStatus.FORBIDDEN, "접근 권한이 없습니다."); // 접근 권한 없음 예외 발생
        } else if (ex instanceof ResourceNotFoundException) { // 리소스 없음 예외 발생
            return new ExceptionInfo(HttpStatus.NOT_FOUND, "요청한 리소스를 찾을 수 없습니다."); // 리소스 없음 예외 발생
        } else if (ex instanceof DataIntegrityViolationException) { // 데이터 제약 조건 위반 예외 발생
            return new ExceptionInfo(HttpStatus.CONFLICT, "데이터 제약 조건 위반이 발생했습니다."); // 데이터 제약 조건 위반 예외 발생
        } else if (ex instanceof NoHandlerFoundException) { // 요청하신 페이지를 찾을 수 없습니다.
            return new ExceptionInfo(HttpStatus.NOT_FOUND, "요청하신 페이지를 찾을 수 없습니다.");
        } else if (ex instanceof IllegalArgumentException) { // 잘못된 요청입니다. 입력값을 확인해주세요.
            return new ExceptionInfo(HttpStatus.BAD_REQUEST, "잘못된 요청입니다. 입력값을 확인해주세요.");
        } else { // 기타 예외 발생
            return new ExceptionInfo(HttpStatus.INTERNAL_SERVER_ERROR, "예기치 않은 오류가 발생했습니다."); // 서버 오류 예외 발생
        }
    }
    // 예외 응답 생성 메서드
    private ResponseEntity<ErrorResponse> createErrorResponse(String message, HttpStatus status) {
        ErrorResponse errorResponse = new ErrorResponse(message);
        return new ResponseEntity<>(errorResponse, status);
    }
  
    @Getter  // 예외 응답 클래스
    private static class ErrorResponse {
        private String errorMessage;
        // 생성자
        public ErrorResponse(String errorMessage) {
            this.errorMessage = errorMessage;
        }
        // 에러 메시지 반환 메서드
        @JsonProperty("error_message")
        public String getErrorMessage() {
            return errorMessage;
        }
    }

    @Getter
    private static class ExceptionInfo {
        private final HttpStatus status;
        private final String message;

        public ExceptionInfo(HttpStatus status, String message) {
            this.status = status;
            this.message = message;
        }
    }
}
