package io.good.gooddev_web.member.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class ExceptionController {

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception e) {
        log.error("예외 발생: ", e);
        
        ModelAndView mav = new ModelAndView("error/globalError");
        mav.addObject("errorMessage", "시스템 오류가 발생했습니다. 관리자에게 문의해주세요.");
        return mav;
    }

    @ExceptionHandler(RuntimeException.class)
    public ModelAndView handleRuntimeException(RuntimeException e) {
        log.error("런타임 예외 발생: ", e);
        
        ModelAndView mav = new ModelAndView("error/runtimeError");
        mav.addObject("errorMessage", "처리 중 오류가 발생했습니다. 다시 시도해주세요.");
        return mav;
    }
}
