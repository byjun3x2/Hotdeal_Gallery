package kr.co.hotdeal.member.controller;

import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.member.vo.MemberVO;

public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        
        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        // 1. 비로그인 상태이거나, 로그인했지만 관리자(ROLE_ADMIN)가 아닌 경우
        if (loginUser == null || !"ROLE_ADMIN".equals(loginUser.getRole())) {
            
            // 2. 메인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/list");
            return false; // 컨트롤러로 요청이 진행되지 않도록 막음
        }

        // 3. 관리자인 경우, 요청을 그대로 진행
        return true;
    }
}