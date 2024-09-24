package io.good.gooddev_web.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import io.good.gooddev_web.page.PageRequestDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    //생성자 주입
    @Autowired
    private MemberService memberService;

    @Autowired
	private MapperUtil mapperUtil;

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
            //로그 기록
            log.debug(registerMember(memberVO, result));
            return "member/register";
        }
        
        // MemberVO에서 MemberDTO로 변환
        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setMid(memberVO.getMid());
        memberDTO.setPassword(memberVO.getPassword());
        memberDTO.setMemberName(memberVO.getMemberName());
        memberDTO.setEmail(memberVO.getEmail());

        memberService.registerMember(memberDTO);
        return "redirect:/member/list";
    }

    // 회원 목록 조회
    @GetMapping("/list")
    public String showlistMembers(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
        // 예시로 전체 회원 조회 기능
        if (bindingResult.hasErrors()) {
			pageRequestDTO = PageRequestDTO.builder().build();
		}
		model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));
		
        // model.addAttribute("members", memberService.getAllMembers());
        return "member/list";  // 회원 목록을 보여주는 JSP 페이지
    }
	
		
	
    // 회원 정보 수정
    @GetMapping("/edit/{mid}")
    public String showEditForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getMemberList(mid);
        model.addAttribute("memberVO", member);
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

        memberService.modifyMember(memberDTO);
        return "redirect:/member/list";
    }

    // 회원 삭제 처리
    @PostMapping("/delete/{mid}")
    public String deleteMember(@PathVariable String mid) {
        memberService.removeMember(mid);
        return "redirect:/member/list";
    }
}
/*

	@Autowired
	private MemberService memberService;
	
	//@RequestMapping(value = "list", method = RequestMethod.GET)
	@GetMapping("list")

	
	@RequestMapping(value="insert", method = RequestMethod.GET)
	public String insertGet() {
		log.info("member/insert() ..... ");
		
		return "/member/insert";
	}

	@RequestMapping(value="insert", method = RequestMethod.POST)
	public String insert(MemberDTO member) {
		memberService.insert(mapperUtil.map(member, MemberVO.class));
		
		return "redirect:list";
	}
	
	@RequestMapping(value="read", method = RequestMethod.GET)
	public String read(String uid, Model model) {
		
		model.addAttribute("member", memberService.getRead(uid));
		
		return "/member/read";
	}
	
	@RequestMapping(value="remove", method = RequestMethod.GET)
	public String remove(String uid) {
		
		memberService.remove(uid);
		
		return "redirect:list";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.GET)
	public String modifyForm(String uid, Model model) {
		
		model.addAttribute("member", memberService.getRead(uid));
		
		return "/member/modify";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modify(MemberDTO member) {
		
		memberService.modify(mapperUtil.map(member, MemberVO.class));
		
		return "redirect:read?uid=" + member.getUid();
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String loginForm() {
		HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getResponse();
		
		System.out.println("로그인 화면");
		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equals("remember_me")) {
				MemberDTO member = memberService.getRead_uuid(cookie.getValue());
				if (member != null) {
					HttpSession session = request.getSession();
					
					session.setAttribute("loginInfo", member);
					cookie.setMaxAge(60 * 10);
					response.addCookie(cookie);
					
					return "redirect:/todo/list";
				}
			}
		}
		return "/member/login";
	}
	
	@RequestMapping(value="login", method = RequestMethod.POST)
	public String login(MemberDTO inMember, HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberDTO member = memberService.login(inMember);
		if (member != null) { 
			if (inMember.isAuto_login()) {
				//3. 쿠키 값을 추가한다
				Cookie cookie = new Cookie("remember_me", member.getUuid());
				cookie.setMaxAge(60 * 10);//10분만 사용됨
				cookie.setPath("/");
				
				response.addCookie(cookie);
			}
			session.setAttribute("loginInfo", member);
			return "redirect:/todo/list";
		} else {
			return "redirect:/member/login?error=error";
		}
	}
	
	@RequestMapping(value="logout", method = RequestMethod.GET)
	//public String logout(HttpServletRequest request, HttpServletResponse response) {
	public String logout(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
		member.setUuid("");
		memberService.modify_uuid(mapperUtil.map(member, MemberVO.class));

		//세션에 저장된 모든 정보를 무효하 한다 
		session.invalidate();
		return "redirect:/member/login";
	} */