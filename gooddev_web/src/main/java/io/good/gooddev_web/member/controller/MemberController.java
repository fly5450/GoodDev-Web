package io.good.gooddev_web.member.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.util.EmailValidator;
import io.good.gooddev_web.util.IdMasker;
import io.good.gooddev_web.util.IdValidator;
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
	private final BoardService boardService; 

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
    log.info("회원가입 요청 처리 중");

    // 유효성 검사 오류 발생 시
    if (bindingResult.hasErrors()) {
            log.error("유효성 검사 오류: {}", bindingResult.getAllErrors()); // 오류 로그 출력
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.memberDTO", bindingResult);
            redirectAttributes.addFlashAttribute("memberDTO", memberDTO);
            return "redirect:/member/register";
        }

        // 아이디와 이메일 유효성 검사
        if (!memberService.validateIdAndEmail(memberDTO.getMid(), memberDTO.getEmail())) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 아이디 또는 이메일입니다.");
            redirectAttributes.addFlashAttribute("memberDTO", memberDTO);
            return "redirect:/member/register";
        }

        // 회원 등록
        memberService.register(mapperUtil.map(memberDTO, MemberVO.class));
        log.info("새 회원 등록: {}", memberDTO.getMid());
        redirectAttributes.addFlashAttribute("message", "회원 가입이 성공적으로 완료되었습니다.");
        return "redirect:/member/login";
    }

    // 회원 정보 수정 GET
    @GetMapping("modify/{mid}")
    public String modifyMemberForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getRead(mid);
        model.addAttribute("memberDTO", member);
        return "member/modify";
    }
    // 회원 정보 수정 POST처리
    @PostMapping("modify")
    public String modifyMember(@Validated @ModelAttribute("memberVO") MemberDTO memberDTO, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.memberVO", bindingResult);
            redirectAttributes.addFlashAttribute("memberVO", memberDTO);
            return "redirect:/member/modify/" + memberDTO.getMid();
        } 
        // MemberDTO 객체 생성 및 매핑
        memberService.modifyMemberInfo(mapperUtil.map(memberDTO, MemberVO.class));
        return "redirect:/member/list";
    }
    // // 회원 탈퇴 POST처리
    // @PostMapping("remove/{mid}")
    // public String removeMember(@PathVariable String mid, HttpSession session, RedirectAttributes redirectAttributes) {
    //     MemberDTO loginMember = (MemberDTO) session.getAttribute("loginInfo");
        
    //     if (loginMember == null || !loginMember.getMid().equals(mid)) {
    //         redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
    //         return "redirect:/";
    //     }
        
    //     memberService.remove(mid); // 회원 탈퇴 처리
    //     session.invalidate(); // 로그아웃 처리 (세션 무효화)
    //     redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
        
    //     return "redirect:/";
    // }
   
      //---------------- 아이디/비밀번호 찾기 ------------------
    // 아이디 찾기 : 사용자가 아이디 찾기 페이지를 요청할 때 호출됨
       // 아이디 찾기 폼 GET 요청 처리
       @GetMapping("findid")
       public String findIdForm(Model model) {
           model.addAttribute("memberDTO", new MemberDTO());
           return "member/findid"; // 아이디 찾기 페이지로 이동
       }
   
        // 아이디 찾기 POST 요청 처리
    @PostMapping("findid")
    public String findIdByEmail(@RequestParam("email") String email, RedirectAttributes redirectAttributes) {
        // 이메일 유효성 검사
        if (email == null || email.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "이메일을 입력해 주세요.");
            return "redirect:/member/findid";
        }

        if (!EmailValidator.isValidEmailREGEX(email)) {
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 이메일 형식입니다.");
            return "redirect:/member/findid";
        }

        // 이메일로 아이디 찾기
        String foundId = memberService.findIdByEmail(email);
        if (foundId != null) {
            // 아이디 마스킹 처리 (ex: ab****cd)
            String maskedId = IdMasker.maskId(foundId);
            redirectAttributes.addFlashAttribute("message", "찾은 아이디: " + maskedId);
        } else {
            redirectAttributes.addFlashAttribute("message", "해당 이메일로 등록된 아이디가 없습니다.");
        }

        return "redirect:/member/findid"; // 결과 페이지로 리다이렉트
    }


     // 아이디 중복 체크와 유효성 검사 수행
    // @PostMapping("/checkIdDuplicate")
    // public String checkIdDuplicate(@RequestParam("mid") String mid, RedirectAttributes redirectAttributes) {
        
    //     // 먼저 유효성 검사 (아이디 형식에 대한 정규식 검사) 수행
    //     if (!IdValidator.isValidId(mid)) {
    //         redirectAttributes.addFlashAttribute("message", "아이디는 4~20자의 영문, 숫자만 가능합니다.");
    //         return "redirect:/member/register";
    //     }
    //     // 서비스 메서드 활용하여 중복 여부 확인
    //     boolean isDuplicate = memberService.isIdDuplicate(mid);
        
    //     if (isDuplicate) //중복된 아이디가 있으면
    //     {
    //         redirectAttributes.addFlashAttribute("message", "이미 사용 중인 아이디입니다.");
    //     } 
    //     else //중복된 아이디가 없으면
    //     {
    //         redirectAttributes.addFlashAttribute("message", "사용 가능한 아이디입니다.");
    //         redirectAttributes.addFlashAttribute("checkedId", mid);
    //     }
    //     return "redirect:/member/register";
    // }   
    
    // 아이디 중복 체크 : 비동기 통신 사용
        @PostMapping("/checkIdDuplicate")    
        @ResponseBody // json 형식으로 데이터를 반환
        public String checkIdDuplicate(@RequestParam("mid") String mid) {
            // 먼저 유효성 검사 (아이디 형식에 대한 정규식 검사) 수행
            if (!IdValidator.isValidIdREGEX(mid)) {
                return "invalid";
            }
            // 서비스 메서드 활용하여 중복 여부 확인
            boolean isDuplicate = memberService.isIdDuplicate(mid);
            // 중복된 아이디가 있으면 "duplicate" 반환, 없으면 "available" 반환
            if (isDuplicate) {
                return "duplicate";
            } else {
                return "available";
            }
        }   

    // 비밀번호 찾기 페이지로 이동 GET
    @GetMapping("findpwd")
    public String FindPwdForm() {
        return "member/findpwd"; // findpwd.jsp로 이동
    }

   // 비밀번호 찾기 처리 POST
   @PostMapping("findpwd")
   public String findPwdPost(@RequestParam("mid") String mid,
                             @RequestParam("email") String email,
                             @RequestParam("newPassword") String newPassword,
                             RedirectAttributes redirectAttributes) {
       if (!EmailValidator.isValidEmailREGEX(email)) {
           redirectAttributes.addFlashAttribute("message", "유효하지 않은 이메일 형식입니다.");
           redirectAttributes.addFlashAttribute("mid", mid);
           redirectAttributes.addFlashAttribute("email", email);
           return "redirect:/member/findpwd";
       }
   
       Boolean success = memberService.resetPasswordByIdAndEmail(mid, email, newPassword);
       if (success) {
           redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 재설정되었습니다.");
           redirectAttributes.addFlashAttribute("mid", mid);
       } else {
           redirectAttributes.addFlashAttribute("message", "아이디 또는 이메일이 일치하지 않습니다.");
           redirectAttributes.addFlashAttribute("mid", mid);
           redirectAttributes.addFlashAttribute("email", email);
       }
       return "redirect:/member/login";
   }


 //---------------- 로그인/로그아웃 ------------------
    //로그아웃
    @RequestMapping("logout")
    public String logout(HttpServletRequest request,HttpSession session) {
        try{
        String link = request.getParameter("redirect");
        MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
        member.setAuto_Login("");
        memberService.modify_Auto_Login(mapperUtil.map(member, MemberVO.class));
        session.invalidate();
        return "redirect:"+(link != null&&!link.equals("null") ? URLDecoder.decode(link, "UTF-8") : "/");
        }catch(Exception e){
            e.getStackTrace();
            return "redirect:/";
        }
    }

    @GetMapping("login")
	public String loginGet(HttpServletRequest request, HttpServletResponse response,Model model) {
        try{
            String link = request.getParameter("redirect");
            log.info("link는"+link);
            if (request.getCookies() != null) {
                for (Cookie cookie : request.getCookies()) {
                    if (cookie.getName().equals("autoLoginTrue")) {
                        MemberDTO member = memberService.getRead_Auto_Login(cookie.getValue());
                        if (member != null) {
                            HttpSession session = request.getSession();
                            session.setAttribute("mid", member.getMid());
                            session.setAttribute("loginInfo", member);
                            cookie.setMaxAge(60 * 10);
                            response.addCookie(cookie);
                            return "redirect:"+(link != null&& !link.equals("null")? URLDecoder.decode(link, "UTF-8") : "/");
                        }
                    }
                }
            }
            String redirectLink = link != null && !link.equals("null") ? link : "/";
            model.addAttribute("redirect", URLEncoder.encode(redirectLink,"UTF-8"));
            return "member/login";
        }
        catch(Exception e){
            e.getStackTrace();
            return "redirect:/";
        }
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
                session.setAttribute("mid", member.getMid());
                session.setAttribute("loginInfo", member);
                // isAdminYn 값을 세션에 추가
                session.setAttribute("isAdminYn", String.valueOf(member.getIsAdminYn()));
                log.info("로그인 성공: " + mid + " 세션에 저장된 mid: " + session.getAttribute("mid"));
                return "redirect:"+(link != null&&!link.equals("null") ? URLDecoder.decode(link, "UTF-8") : "/");

            } else {
                return "redirect:login?error=error&redirect=" + (link != null && !link.equals("null")? URLEncoder.encode(link,"UTF-8") : "/");
            }
        } catch (Exception e) {
            e.printStackTrace(); // 로그에 오류 기록
            return "redirect:/";
        }
    }

//---------------- 마이페이지 ------------------
    
    //회원 마이페이지
    @RequestMapping("/myPage")
    public String myPage(Model model, HttpServletRequest request) {
    	HttpSession session = request.getSession();
        String mid = (String) session.getAttribute("mid");
        
        if (mid == null) {
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }

        // DB에서 사용자 정보를 가져오는 서비스 호출
        MemberDTO memberInfo = memberService.getMemberInfo(mid);
        log.info("mid 정보 보기" + mid);
        model.addAttribute("member", memberInfo); // JSP에서 사용하기 위해 모델에 추가
        
        return "member/mypage/myPage";
    }
        
    //나의 게시물 가져오기
    @RequestMapping("/myBoardList")
    public String myBoardList(Model model, HttpServletRequest request) {
    	HttpSession session = request.getSession();
        String mid = (String) session.getAttribute("mid");

        if (mid == null) {
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }

        // 게시물 객체 가져오기
        List<BoardDTO> myBoards = boardService.getBoardsByMid(mid); // 사용자 게시물 가져오기
        model.addAttribute("myBoards", myBoards); // 모델에 추가
        
    	return "member/mypage/myBoardList";
    }
    
    //회원 정보 수정
    @GetMapping("/updateMember")
    public String updateMember(Model model, HttpServletRequest request) {
    	
    	String mid = request.getParameter("mid");
    	log.info("Received mid: " + mid);
    	
        MemberDTO member = memberService.getRead(mid); // 회원 정보 조회
        model.addAttribute("member", member); // 모델에 추가
        
        log.info("updateMid() 실행" + mid);
    	log.info("updateMember() 실행" + member);
    	return "member/mypage/updateMember";
    }
    
    //회원 정보 수정
    @PostMapping("/updateMember")
    public String updateMemberForm(MemberVO memberVO) {
    	log.info("Received memberVO: " + memberVO);
    	
    	memberService.modifyMemberInfo(memberVO); // 회원 정보 수정
        log.info("updateMemberPost() 실행 - POST");
        
    	return "member/mypage/updateMember";
    }
    //회원 탈퇴
    @RequestMapping("/removeMember")
    public String removeMember(HttpServletRequest request) {
    	HttpSession session = request.getSession();
        String mid = (String) session.getAttribute("mid");
        
        if (mid == null) {
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }
        
        memberService.remove(mid);
        
        // 세션 무효화
        session.invalidate();
    	
    	return "member/mypage/removeMember";
    }
}