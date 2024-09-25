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

    // 회원 등록 페이지로 이동
    @GetMapping("/register") //  HTTP GET 요청을 처리
    //사용자가 브라우저에서 ..../member/register URL을 요청했을 때 이 메서드가 호출된다.
    public String showRegisterForm(Model model) //Controller -> View(JSP)로 데이터를 전달
    {
        model.addAttribute("memberVO", new MemberVO()); //익명객체 사용(사용자가 폼을 요청할때에 초기화된 상태의 객체를 전달받는다.)
        return "member/register"; //register.jsp로 이동한다.
    }

    // 회원 등록 처리
    @PostMapping("/register")
    public String registerMember(@Validated @ModelAttribute("memberVO") MemberVO memberVO, BindingResult result) {
        if (result.hasErrors()) {
            return "member/register";
        }
        
        // MemberVO에서 MemberDTO로 변환
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setMid(memberVO.getMid());
        memberDTO.setPassword(memberVO.getPassword());
        memberDTO.setMemberName(memberVO.getMemberName());
        memberDTO.setEmail(memberVO.getEmail());

        memberService.registerMember(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:member/list";
    }

    // 회원 목록 조회
    @GetMapping("/list")
    public String showlistMembers(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
        // 예시로 전체 회원 조회 기능
        if (bindingResult.hasErrors()) {
          pageRequestDTO = new PageRequestDTO();
        }
		model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));
		
        // model.addAttribute("members", memberService.getAllMembers());
        return "member/list";  // 회원 목록을 보여주는 JSP 페이지
    }
	
		
	
    // 회원 정보 수정
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
        return "redirect:member/list";
    }

    // 회원 삭제 처리
    @PostMapping("/delete/{mid}")
    public String deleteMember(@PathVariable String mid) {
        memberService.removeMember(mid);
        return "redirect:member/list";
    }

   @GetMapping("/login")
    public String loginGet(HttpServletRequest request,HttpServletResponse response) {
      if(request.getCookies() != null){
        for (Cookie cookie : request.getCookies()) {
          if (cookie.getName().equals("autoLoginTrue")) {
            MemberDTO member = memberService.getRead_Auto_Login(cookie.getValue());
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
      return "member/login";
    }

    @PostMapping("/login")
    public String loginPost(HttpServletRequest request,HttpServletResponse response) {
      HttpSession session = request.getSession();
      String mid = request.getParameter("mid");
      String password = request.getParameter("password");
      String auto_login_check = request.getParameter("auto_login_check");
      if(auto_login_check==null) auto_login_check="false";
      MemberDTO inMember = new MemberDTO(mid, password);
      MemberDTO member = memberService.login(mapperUtil.map(inMember,MemberVO.class),auto_login_check);
      if (member != null) {
        if (auto_login_check.equals("on")) {
          Cookie cookie = new Cookie("autoLoginTrue", member.getAuto_Login());
          cookie.setMaxAge(60 * 10);
          cookie.setPath("/");
          response.addCookie(cookie);
        }
        session.setAttribute("loginInfo", member);
        return "redirect:/";
      } else {

        return "redirect:login?error=error";
      }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
        member.setAuto_Login("");
        memberService.modify_Auto_Login(mapperUtil.map(member, MemberVO.class));
        session.invalidate();
        return "redirect:/";
    }
}

