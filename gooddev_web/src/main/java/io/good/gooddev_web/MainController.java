package io.good.gooddev_web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {
    private final MemberService memberService;

    @GetMapping("/")
    public String main(HttpServletRequest request,Model model,HttpServletResponse response) {
        HttpSession session = request.getSession();
        if(request.getCookies() != null){
            for(Cookie cookie : request.getCookies()){
                if(cookie.getName().equals("autoLoginTrue")){
                    MemberDTO member = memberService.getRead_Auto_Login(cookie.getValue());
                    if(member!=null){
                        session.setAttribute("loginInfo", member);
                        cookie.setMaxAge(60 * 10);
                        response.addCookie(cookie);
                    }
                }
            }
        }
        MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
        model.addAttribute("loginInfo",member);
        return "main";
    }
}
