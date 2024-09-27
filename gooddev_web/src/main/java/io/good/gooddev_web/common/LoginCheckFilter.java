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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/member/*") // /member/ 경로 하위 요청에 대해 필터 적용
public class LoginCheckFilter implements Filter {

    // 필터 초기화 메서드
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("LoginCheckFilter 초기화");
    }

    // 실제 필터링 작업을 수행하는 메서드
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // ServletRequest를 HttpServletRequest로 캐스팅
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // 요청된 URI를 가져온다.
        String requestURI = httpRequest.getRequestURI();
        
        // 현재 세션을 가져오고 세션이 없으면 null을 반환한다.
        HttpSession session = httpRequest.getSession(false);
        
        // 로그인 체크가 필요한 경로인지 확인
        if (isLoginCheckRequired(requestURI)) {
            log.info("인증 체크 실행 경로: {}", requestURI);
            
            // 세션이 없거나 로그인 정보가 없는 경우
            if (session == null || session.getAttribute("loginInfo") == null) {
                log.warn("로그인되지 않은 접근 시도: {}", requestURI);
                // 로그인 페이지로 리다이렉트하고, 원래 요청 URL을 파라미터로 전달.
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/member/login?redirectURL=" + requestURI);
                return;
            }
        }
        
        // 로그인 체크를 통과하거나 필요없는 경우, 다음 필터 또는 서블릿으로 요청을 전달
        chain.doFilter(request, response);
    }

    // 로그인 체크가 필요한 경로인지 확인하는 메서드
    private boolean isLoginCheckRequired(String requestURI) {
        // CSS, JS, 이미지 파일이나 로그인, 회원가입 페이지는 로그인 체크에서 제외
        return !requestURI.startsWith("/css") &&
               !requestURI.startsWith("/js") &&
               !requestURI.startsWith("/img") &&
               !requestURI.equals("/member/login") &&
               !requestURI.equals("/member/register");
    }

    // 필터 종료 메서드
    @Override
    public void destroy() {
        log.info("LoginCheckFilter 종료");
    }
}
