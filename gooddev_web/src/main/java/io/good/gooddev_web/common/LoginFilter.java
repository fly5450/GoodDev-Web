package io.good.gooddev_web.common;

import java.io.IOException;
import java.net.URLEncoder;

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
@WebFilter("/*") //  경로 하위 요청에 대해 필터 적용
public class LoginFilter implements Filter {

    // 필터 초기화 메서드
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("LoginFilter 초기화");
    }

    // 실제 필터링 작업을 수행하는 메서드
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // ServletRequest를 HttpServletRequest로 캐스팅
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
    
        String contextPath = httpRequest.getContextPath();
        
        String relativeURI = requestURI.substring(contextPath.length());
        
        // 현재 세션을 가져오고 세션이 없으면 null을 반환한다.
        HttpSession session = httpRequest.getSession(false);
        
        // 로그인 체크가 필요한 경로인지 확인
        if (isLoginCheckRequired(requestURI)&&session.getAttribute("loginInfo")==null) {
            log.warn("로그인되지 않은 접근 시도: {}", relativeURI);
            
            String queryString = httpRequest.getQueryString();

            if (queryString != null && !queryString.isEmpty()) {
                relativeURI += "?" + queryString; // 쿼리 스트링을 relativeURI에 추가
            }
            String encodedURI = URLEncoder.encode(relativeURI, "UTF-8");
            
            String redirectUrl = httpRequest.getContextPath() + "/member/login?redirect=" + encodedURI;
        
            // 리다이렉트
            httpResponse.sendRedirect(redirectUrl);
            return;
        }
        
        // 로그인 체크를 통과하거나 필요없는 경우, 다음 필터 또는 서블릿으로 요청을 전달
        chain.doFilter(request, response);
    }

    // 로그인 체크가 필요한 경로인지 확인하는 메서드
    private boolean isLoginCheckRequired(String requestURI) {
        return requestURI.equals("/gooddev_web/board/insert") || //게시글 작성 페이지
               requestURI.startsWith("/gooddev_web/board/like") || //게시글 좋아요 페이지
               requestURI.equals("/gooddev_web/member/updateMember") || //회원 정보 수정 페이지
               requestURI.equals("/gooddev_web/member/myBoardList") || //내가 쓴 게시글 목록 페이지
               requestURI.equals("/gooddev_web/member/removeMember") || //회원 탈퇴 페이지
               requestURI.startsWith("/gooddev_web/member/myPage") || //myPage 하위 경로 포함
               requestURI.startsWith("/gooddev_web/admin/"); //admin 하위 경로 포함
    }

    // 필터 종료 메서드
    @Override
    public void destroy() {
        log.info("LoginCheckFilter 종료");
    }
}
