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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    // 회원 가입 페이지로 이동
    @GetMapping("/register") //  HTTP GET 요청을 처리
    //사용자가 브라우저에서 ..../member/register URL을 요청했을 때 이 메서드가 호출된다.
    public String RegisterForm(Model model) //Controller -> View(JSP)로 데이터를 전달
    {
        model.addAttribute("memberVO", new MemberVO()); 
        return "member/register"; 
    }

     // 회원 가입 처리 //@Validated 로 유효성검증 수행
    @PostMapping("/register")
    public String registerMember(@Validated @ModelAttribute("memberVO") MemberVO memberVO, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) { 
            // 유효성 검사 오류가 있는 경우 
            //addFlashAttribute세션에 저장되어 사용된 뒤에 자동으로 삭제, 주소 창에 표기되지 않으므로 addAttribute() 보다 폐쇄적)
            redirectAttributes.addFlashAttribute("message", bindingResult.getFieldError().getDefaultMessage()); //에러메시지를 출력하고
            return "redirect:/member/register"; // 등록 페이지로 리다이렉트 한다.
        }

        MemberDTO memberDTO = mapperUtil.map(memberVO, MemberDTO.class); //MemverVO를 DTO로 변환하고
        memberService.registerMember(memberVO); //회원등록 처리를 요청하고
        return "redirect:/member/list"; // 회원 목록 페이지로 리다이렉트한다.
    }
    // public String registerMember(@ModelAttribute("memberVO") MemberVO memberVO, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
    // if (!isValid(memberVO)) {
    //     redirectAttributes.addFlashAttribute("message", "모든 필드를 올바르게 입력하세요.");
    //     return "redirect:/member/register";
    // }

    // 아이디 찾기 페이지로 이동 GET
    @GetMapping("/findId")
    public String FindIdForm() {
        return "member/findId"; // findId.jsp로 이동
    }
     // 아이디 찾기 처리 POST
   @PostMapping("/findId")
    public String findIdPost(@RequestParam("email") String email, RedirectAttributes redirectAttributes) {
      String findId = memberService.findIdByEmail(email); // 이메일로 아이디 찾기
      if (findId != null) {
          redirectAttributes.addFlashAttribute("message", "찾은 아이디: " + findId);
      } else {
          redirectAttributes.addFlashAttribute("message", "해당 이메일에 등록된 아이디가 없습니다.");
      }
      
      return "redirect:/member/login"; // login.jsp로 이동
    }

    // 비밀번호 찾기 페이지로 이동 Get
    @GetMapping("/findPwd")
    public String moveFindPwdForm() {
        return "member/findPwd"; // findPassword.jsp로 이동
    }

   // 비밀번호 찾기 처리 POST
   @PostMapping("/findPwd")
   public String findPwdPost(@ModelAttribute("mid") String mid,
                              @RequestParam("email") String email,
                              @RequestParam("newPassword") String newPassword, // 수정: @ModelAttribute -> @RequestParam
                              RedirectAttributes redirectAttributes) {
       Boolean success = memberService.findPwd(mid, email, newPassword); // 비밀번호 찾기 성공시
       if (success) {
           redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 재설정되었습니다.");
       } else {
           redirectAttributes.addFlashAttribute("message", "아이디 또는 이메일이 일치하지 않습니다.");
       }
       return "redirect:/member/login"; // 다시 비밀번호 찾기 페이지로 리다이렉트
   }
   
	 // 회원 목록 조회
    @GetMapping("/list")
    public String listMembers(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
        // 예시로 전체 회원 조회 기능
        if (bindingResult.hasErrors()) {
          pageRequestDTO = new PageRequestDTO();
        }
		model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));
        // model.addAttribute("members", memberService.getAllMembers());
        return "member/list";  
    }
		
    @GetMapping("/edit/{mid}")
    public String EditForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getRead(mid);
        model.addAttribute("memberDTO", member);
        return "member/edit";
    }
    // 회원 정보 수정 POST처리
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

        memberService.modifyMemberInfo(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:member/list";
    }

    @PostMapping("/delete/{mid}")
    public String deleteMember(@PathVariable String mid) {
        memberService.removeMember(mid);
        return "redirect:member/list";
    }

    //로그아웃
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
        member.setAuto_Login("");
        memberService.modify_Auto_Login(mapperUtil.map(member, MemberVO.class));
        session.invalidate();
        return "redirect:/main.jsp"; 
    }
    //로그인 POST처리
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
        return "redirect:/login";
      } else {

        return "redirect:/login?error=error";
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
    
    //---------------- 마이페이지 ------------------
    
    //회원 마이페이지
    @RequestMapping("/mypage")
    public String myPage(Model model) {
    	
    	return "member/mypage/myPage";
    }
        
    //나의 게시물 가져오기
    @RequestMapping("/myBoardList")
    public String myBoardList(Model model) {
    	//게시물 객체 가져오기
    	return "member/mypage/myBoardList";
    }
    
    //회원 정보 수정
    @RequestMapping("/updateMember")
    public String updateMember(Model model) {
    	log.info("updateMember() 실행");
    	return "member/mypage/updateMember";
    }
    
    @RequestMapping("/removeMember")
    public String removeMember() {
    	
    	return "member/mypage/removeMember";
    }
}

