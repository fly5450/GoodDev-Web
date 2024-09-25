package io.good.gooddev_web.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;
	private final MapperUtil mapperUtil;

    @GetMapping("/register") 
    public String showRegisterForm(Model model) 
    {
        model.addAttribute("memberVO", new MemberVO()); 
        return "member/register"; 
    }

    @PostMapping("/register")
    public String registerMember(@Validated @ModelAttribute("memberVO") MemberVO memberVO, BindingResult result) {
        if (result.hasErrors()) {
            return "member/register";
        }
        
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setMid(memberVO.getMid());
        memberDTO.setPassword(memberVO.getPassword());
        memberDTO.setMemberName(memberVO.getMemberName());
        memberDTO.setEmail(memberVO.getEmail());

        memberService.registerMember(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:/member/list";
    }

    @GetMapping("/list")
    public String showlistMembers(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
          pageRequestDTO = new PageRequestDTO();
        }
		model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));
		
        // model.addAttribute("members", memberService.getAllMembers());
        return "member/list";  
    }
	
		
	
    @GetMapping("/edit/{mid}")
    public String showEditForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getRead(mid);
        model.addAttribute("memberDTO", member);
        return "member/edit";
    }

    @PostMapping("/edit")
    public String editMember(@Validated @ModelAttribute("memberVO") MemberVO memberVO, BindingResult result) {
        if (result.hasErrors()) {
            return "member/edit";
        }
        
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setMid(memberVO.getMid());
        memberDTO.setPassword(memberVO.getPassword());
        memberDTO.setMemberName(memberVO.getMemberName());
        memberDTO.setEmail(memberVO.getEmail());

        memberService.modifyMember(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:/member/list";
    }

    @PostMapping("/delete/{mid}")
    public String deleteMember(@PathVariable String mid) {
        memberService.removeMember(mid);
        return "redirect:/member/list";
    }

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
      MemberDTO inMember = new MemberDTO(uid, pwd, auto_login);
      MemberDTO member = memberService.login(inMember);
      if (member != null) {
        if (!inMember.getAuto_Login().equals(null)) {
          Cookie cookie = new Cookie("remember_me", member.getAuto_Login());
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
        member.setAuto_Login("");
        memberService.modify_uuid(mapperUtil.map(member, MemberVO.class));
        session.invalidate();
        return "redirect:/main";
    }
    
    //회원 마이페이지
    @RequestMapping("/mypage")
    public String myPage(Model model) {
    	
    	return "member/mypage/myPage";
    }
        
    //나의 게시물 가져오기
    @RequestMapping("myBoardList")
    public String myBoardList(Model model) {
    	//게시물 객체 가져오기
    	
    	return "member/mypage/myBoardList";
    }
    
  //회원 정보 수정
    @RequestMapping("updateMember")
    public String updateMember(Model model) {
    	
    	return "member/mypage/updateMember";
    }
    
    @RequestMapping("removeMember")
    public String removeMember() {
    	
    	return "member/mypage/removeMember";
    }
}

