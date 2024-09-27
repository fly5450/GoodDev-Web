package io.good.gooddev_web.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebFilter("/*") // 모든 요청에 대해 필터 적용
public class CommonFilter implements Filter {

    private static final Logger log = LoggerFactory.getLogger(CommonFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("Commonfilter 초기화");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 요청 URL 및 메서드 로깅
        log.info("요청 URL: {}, 메서드: {}", httpRequest.getRequestURI(), httpRequest.getMethod());

        // 세션을 통한 인증 검사
        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("loginInfo") == null) {
            log.warn("인증되지 않은 접근 시도: {}", httpRequest.getRequestURI());
            httpResponse.sendRedirect("/member/login"); // 인증되지 않은 사용자 리다이렉트
            return;
        }

        // 필터 체인 계속 진행
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        log.info("CustomFilter 종료");
    }
}
