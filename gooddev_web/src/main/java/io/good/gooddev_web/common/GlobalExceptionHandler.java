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
import org.springframework.web.bind.annotation.ResponseStatus;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    // 일반적인 Exception을 처리하며, 500 Internal Server Error를 반환합니다.
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ResponseEntity<ErrorResponse> handleException(Exception e) {
        log.error("Severe exception occurred: ", e);
        return createErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, "An unexpected error occurred");
    }
    //RuntimeException을 처리하며, 400 Bad Request를 반환합니다.
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException e) {
        log.error("Runtime exception occurred: ", e);
        return createErrorResponse(HttpStatus.BAD_REQUEST, "Invalid request");
    }
    //예외 응답 생성 : 예외 정보를 바탕으로 ErrorResponse 객체를 생성
    private ResponseEntity<ErrorResponse> createErrorResponse(HttpStatus status, String message) {
        log.error("Error response created - Status: {}, Message: {}", status, message);
        ErrorResponse errorResponse = new ErrorResponse(status.value(), message);
        return ResponseEntity.status(status).body(errorResponse);
    }
    //메서드 인자 유효성 검사 실패 처리
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<ErrorResponse> handleValidationExceptions(MethodArgumentNotValidException ex) {
        log.error("유효성 검사 실패: ", ex);
        String errorMessage = ex.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        return createErrorResponse(HttpStatus.BAD_REQUEST, errorMessage);
    }
    //JSON 파싱 오류 처리
    @ExceptionHandler(HttpMessageNotReadableException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<ErrorResponse> handleHttpMessageNotReadable(HttpMessageNotReadableException ex) {
        log.error("JSON 파싱 오류: ", ex);
        return createErrorResponse(HttpStatus.BAD_REQUEST, "잘못된 요청 형식입니다");
    }
    //접근 권한 없음 처리
    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ResponseEntity<ErrorResponse> handleAccessDeniedException(AccessDeniedException ex) {
        log.error("접근 권한 없음: ", ex);
        return createErrorResponse(HttpStatus.FORBIDDEN, "접근 권한이 없습니다");
    }
    //리소스 없음 처리
    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseEntity<ErrorResponse> handleResourceNotFoundException(ResourceNotFoundException ex) {
        log.error("리소스를 찾을 수 없음: ", ex);
        return createErrorResponse(HttpStatus.NOT_FOUND, ex.getMessage());
    }
    //데이터 무결성 위반 처리
    @ExceptionHandler(DataIntegrityViolationException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ResponseEntity<ErrorResponse> handleDataIntegrityViolationException(DataIntegrityViolationException ex) {
        log.error("데이터 무결성 위반: ", ex);
        return createErrorResponse(HttpStatus.CONFLICT, "데이터 제약 조건 위반이 발생했습니다");
    }
}


