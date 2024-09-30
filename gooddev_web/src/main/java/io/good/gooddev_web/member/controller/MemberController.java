package io.good.gooddev_web.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

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
import io.good.gooddev_web.util.EmailValidator;
import io.good.gooddev_web.util.IdMasker;
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

//---------------- 회원 CRUD ------------------ 1) Read 2) Create 3) Update 4) Delete  
    // 회원 목록 GET
    @GetMapping("list")
    public String getlist(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
          pageRequestDTO = new PageRequestDTO();
        }
        model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));
        return "member/list";
    }

    // 회원 가입 페이지로 이동
    @GetMapping("register") //  HTTP GET 요청을 처리
    //사용자가 브라우저에서 ..../member/register URL을 요청했을 때 이 메서드가 호출된다.
    public String registerForm(Model model) //Controller -> View(JSP)로 데이터를 전달
    {
        model.addAttribute("memberDTO", new MemberDTO());
        return "member/register";
    }
    
    // 회원 가입 처리
    @PostMapping("register")
    public String register(@Validated @ModelAttribute("memberDTO") MemberDTO memberDTO, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.memberDTO", bindingResult);
            redirectAttributes.addFlashAttribute("memberDTO", memberDTO);
            return "redirect:/member/register";   // 회원가입 페이지로 리다이렉트
        }
        memberService.register(mapperUtil.map(memberDTO, MemberVO.class));
        log.info("새 회원 등록: {}",memberDTO.getMid());
        redirectAttributes.addFlashAttribute("message", "회원 가입이 성공적으로 완료되었습니다."); // 회원가입 성공 메시지 추가
        redirectAttributes.addFlashAttribute("mid", memberDTO.getMid());
        redirectAttributes.addFlashAttribute("email", memberDTO.getEmail()); 
        return "redirect:/member/login";
    }
    // 회원 정보 수정 GET
    @GetMapping("edit/{mid}")
    public String editMemberForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getRead(mid);
        model.addAttribute("memberDTO", member);
        return "member/edit";
    }
    // 회원 정보 수정 POST처리
    @PostMapping("edit")
    public String editMember(@Validated @ModelAttribute("memberVO") MemberDTO memberDTO, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.memberVO", bindingResult);
            redirectAttributes.addFlashAttribute("memberVO", memberDTO);
            return "redirect:/member/edit/" + memberDTO.getMid();
        } 
        // MemberDTO 객체 생성 및 매핑
        memberService.modifyMemberInfo(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:/member/list";
    }
    // 회원 탈퇴 POST처리
    @PostMapping("delete/{mid}")
    public String removeMember(@PathVariable String mid, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginInfo");
        
        if (loginMember == null || !loginMember.getMid().equals(mid)) {
            redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
            return "redirect:/";
        }
        
        memberService.remove(mid); // 회원 탈퇴 처리
        session.invalidate(); // 로그아웃 처리 (세션 무효화)
        redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
        
        return "redirect:/";
    }
   
      //---------------- 아이디/비밀번호 찾기 ------------------
    // 아이디 찾기 : 사용자가 아이디 찾기 페이지를 요청할 때 호출됨
    @GetMapping("findid")
    public String FindIdForm(Model model) {
        model.addAttribute("memberDTO", new MemberDTO());
        return "member/findid"; // findid.jsp로 이동
    }
     //아이디 찾기 POST : 사용자가 아이디 찾기 페이지에서 아이디 찾기 버튼을 클릭했을 때 호출됨
     @PostMapping("findid")
     public String findIdPost(@RequestParam("email") String email, RedirectAttributes redirectAttributes) {
         if (!EmailValidator.isValidEmail(email)) // 이메일 유효성 검사
         {
             redirectAttributes.addFlashAttribute("message", "유효하지 않은 이메일 형식입니다."); // 유효하지 않은 이메일 형식일 때 메시지 추가
             return "redirect:/member/findid"; // 아이디 찾기 페이지로 리다이렉트
         }
 
         String findId = memberService.findIdByEmail(email);
         if (findId != null) {
             redirectAttributes.addFlashAttribute("message", "찾은 아이디: " + IdMasker.maskId(findId)); // 찾은 아이디를 마스킹하여 메시지에 추가
             redirectAttributes.addFlashAttribute("mid", findId); // 찾은 아이디를 모델에 추가
             redirectAttributes.addFlashAttribute("email", email); // 이메일을 모델에 추가  
             return "redirect:/member/login"; // 로그인 페이지로 리다이렉트
         } else {
             redirectAttributes.addFlashAttribute("message", "해당 이메일에 등록된 아이디가 없습니다."); // 이메일에 등록된 아이디가 없을 때 메시지 추가
             redirectAttributes.addFlashAttribute("email", email); // 이메일을 모델에 추가
             return "redirect:/member/findId"; // 아이디 찾기 페이지로 리다이렉트
         }
     }

    // 비밀번호 찾기 페이지로 이동 GET
    @GetMapping("findpwd")
    public String FindPwdForm() {
        return "member/findpwd"; // findpwdjsp로 이동
    }

   // 비밀번호 찾기 처리 POST
   @PostMapping("findpwd")
   public String findPwdPost(@RequestParam("mid") String mid,
                              @RequestParam("email") String email,
                              @RequestParam("newPassword") String newPassword, // 수정: @ModelAttribute -> @RequestParam
                              RedirectAttributes redirectAttributes) {
        if (!EmailValidator.isValidEmail(email)) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 이메일 형식입니다.");
            redirectAttributes.addFlashAttribute("mid", mid);
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/member/findpwd";
        }

        Boolean success = memberService.findPwd(mid, email, newPassword);
         // 비밀번호 재설정 성공 여부 확인
        if (success) {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 재설정되었습니다.");
            redirectAttributes.addFlashAttribute("mid", mid);
            redirectAttributes.addFlashAttribute("email", email);
        } else {
            redirectAttributes.addFlashAttribute("message", "아이디 또는 이메일이 일치하지 않습니다.");
            redirectAttributes.addFlashAttribute("mid", mid);
            redirectAttributes.addFlashAttribute("email", email);
        }
        return "redirect:/member/login";  // 로그인 페이지로 리다이렉트
    }


 //---------------- 로그인/로그아웃 ------------------
    //로그아웃
    @PostMapping("logout")
    public String logout(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
        member.setAuto_Login("");
        memberService.modify_Auto_Login(mapperUtil.map(member, MemberVO.class));
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("login")
	public String loginGet(HttpServletRequest request, HttpServletResponse response) {
		if (request.getCookies() != null) {
			for (Cookie cookie : request.getCookies()) {
				if (cookie.getName().equals("autoLoginTrue")) {
					MemberDTO member = memberService.getRead_Auto_Login(cookie.getValue());
					if (member != null) {
                        String link = request.getParameter("redirect");
						HttpSession session = request.getSession();
						session.setAttribute("mid", member.getMid());
						session.setAttribute("loginInfo", member);
						cookie.setMaxAge(60 * 10);
						response.addCookie(cookie);
                        try {
                            String decodedLink = URLDecoder.decode(link, "UTF-8");;
                            return "redirect:"+(link != null ? decodedLink : "/");
                        } catch (UnsupportedEncodingException e) {
                            e.printStackTrace();
                        }
						return "redirect:/";
					}
				}
			}
		}
		return "member/login";
	}
    
    //로그인 POST처리
    @PostMapping("/login")
    public String loginPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            HttpSession session = request.getSession();
            String mid = request.getParameter("mid");
            String password = request.getParameter("password");
            String auto_login_check = request.getParameter("auto_login_check");
            String link = request.getParameter("redirect");
            log.info("로그는 "+link);
            if (auto_login_check == null) auto_login_check = "false";
            MemberDTO inMember = new MemberDTO(mid, password);
            MemberDTO member = memberService.login(mapperUtil.map(inMember, MemberVO.class), auto_login_check);
            if (member != null) {
                if (auto_login_check.equals("on")) {
                    Cookie cookie = new Cookie("autoLoginTrue", member.getAuto_Login());
                    cookie.setMaxAge(60 * 10);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
                session.setAttribute("loginInfo", member);
                return "redirect:"+(link != null&&!link.equals("null") ? URLDecoder.decode(link, "UTF-8") : "/");

            } else {
                return "redirect:login?error=error&redirect=" + (link != null && !link.equals("null")? URLDecoder.decode(link, "UTF-8") : "/");
            }
        } catch (Exception e) {
            e.printStackTrace(); // 로그에 오류 기록
            return "redirect:/";
        }
    }

//---------------- 마이페이지 ------------------
    
    //회원 마이페이지
    @RequestMapping("/myPage")
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
    //회원 탈퇴
    @RequestMapping("/removeMember")
    public String removeMember() {
    	return "member/mypage/removeMember";
    }
}
