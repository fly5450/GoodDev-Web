package io.good.gooddev_web.common;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ExceptionController {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleException(Exception e) {
        log.error("예외 발생: ", e);
        ErrorResponse errorResponse = new ErrorResponse("시스템 오류가 발생했습니다. 관리자에게 문의해주세요.");
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException e) {
        log.error("런타임 예외 발생: ", e);
        ErrorResponse errorResponse = new ErrorResponse("처리 중 오류가 발생했습니다. 다시 시도해주세요.");
        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

    private static class ErrorResponse {
        private String errorMessage;

        public ErrorResponse(String errorMessage) {
            this.errorMessage = errorMessage;
        }

        public String getErrorMessage() {
            return errorMessage;
        }
    }
}
