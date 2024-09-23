package com.gooddev.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.member.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

    //생성자 주입
    @Autowired
    private MemberService memberService;

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
    public String registerMember(@Valid @ModelAttribute("memberVO") MemberVO memberVO, BindingResult result) {
        if (result.hasErrors()) {
            //로그 기록
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
    public String listMembers(Model model) {
        // 예시로 전체 회원 조회 기능
        // model.addAttribute("members", memberService.getAllMembers());
        return "member/list";  // 회원 목록을 보여주는 JSP 페이지
    }

    // 회원 정보 수정
    @GetMapping("/edit/{mid}")
    public String showEditForm(@PathVariable String mid, Model model) {
        MemberDTO member = memberService.getMemberById(mid);
        model.addAttribute("memberVO", member);
        return "member/edit";
    }

    @PostMapping("/edit")
    public String editMember(@Valid @ModelAttribute("memberVO") MemberVO memberVO, BindingResult result) {
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
