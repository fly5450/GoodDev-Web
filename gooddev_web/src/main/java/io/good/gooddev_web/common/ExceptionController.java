package io.good.gooddev_web.common;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ExceptionController {
    //일반 예외 처리
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleException(Exception e) {
        log.error("일반 예외 발생: ", e);
        return createErrorResponse("시스템 오류가 발생했습니다. 관리자에게 문의해주세요.", HttpStatus.INTERNAL_SERVER_ERROR, e);
    }
    //런타임 예외 처리
    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException e) {
        log.error("런타임 예외 발생: ", e);
        return createErrorResponse("처리 중 오류가 발생했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST, e);
    }
    //404 Not Found 오류 처리
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<ErrorResponse> handleNoHandlerFoundException(NoHandlerFoundException e) {
        log.error("404 오류 발생: ", e);
        return createErrorResponse("요청하신 페이지를 찾을 수 없습니다.", HttpStatus.NOT_FOUND, e);
    }
    //잘못된 접근에러 처리
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(IllegalArgumentException e) {
        log.error("잘못된 인자 예외 발생: ", e);
        return createErrorResponse("잘못된 요청입니다. 입력값을 확인해주세요.", HttpStatus.BAD_REQUEST, e);
    }

    private ResponseEntity<ErrorResponse> createErrorResponse(String message, HttpStatus status, Exception e) {
        String logMessage = String.format("예외 발생 - 유형: %s, 메시지: %s, 상태 코드: %d",
                e.getClass().getSimpleName(), e.getMessage(), status.value());
        log.error(logMessage);
        ErrorResponse errorResponse = new ErrorResponse(message);
        return new ResponseEntity<>(errorResponse, status);
    }

    @Getter
    private static class ErrorResponse {
        private String errorMessage;

        public ErrorResponse(String errorMessage) {
            this.errorMessage = errorMessage;
        }

        @JsonProperty("error_message")
        public String getErrorMessage() {
            return errorMessage;
        }
    }
}
