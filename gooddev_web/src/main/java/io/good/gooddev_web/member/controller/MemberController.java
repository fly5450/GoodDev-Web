package io.good.gooddev_web.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MemberController {
    private final MapperUtil mapper;
    private final MemberService memberService;
    
     @GetMapping("/login")
	public String loginGet(HttpServletRequest request,HttpServletResponse response) {
		if(request.getCookies() != null){
			for (Cookie cookie : request.getCookies()) {
				if (cookie.getName().equals("remember_me")) {
					MemberDTO member = memberService.getRead_uuid(cookie.getValue());
					if (member != null) {
						HttpSession session = request.getSession();
						session.setAttribute("loginInfo", member);
						cookie.setMaxAge(60 * 10);
						response.addCookie(cookie);
						return "redirect:/";
					}
				}
			}
		}
		return "login";
	}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session = request.getSession();
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		String auto_login = request.getParameter("auto_login");
		MemberDTO inMember = new MemberDTO(uid, pwd, "y".equalsIgnoreCase(auto_login));
		MemberDTO member = memberService.login(inMember);
		if (member != null) {
			if (inMember.getAuto_login().equals("true")) {
				Cookie cookie = new Cookie("remember_me", member.getUuid());
				cookie.setMaxAge(60 * 10);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			session.setAttribute("loginInfo", member);
			return "redirect:/";
		} else {
			
			return "redirect:/login?error=error";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
	    member.setUuid("");
	    memberService.modify_uuid(mapper.map(member, MemberVO.class));
	    session.invalidate();
	    return "redirect:/main";
	}

}