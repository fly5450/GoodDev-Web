package io.good.gooddev_web.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MapperUtil mapperUtil;
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardService boardService;
	
	//관리자 페이지 회원목록 가져오기
	@GetMapping("/memberList")
	public String getMemberList(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
	    // BindingResult에 오류가 있는 경우 기존 pageRequestDTO 유지
	    if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	    }

	    // 서비스에서 회원 목록과 전체 카운트 가져오기
	    model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));

	    return "admin/memberList";  
	}
	
	//관리자 페이지 게시물 목록 가져오기
	@GetMapping("/board/list")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
	}
	
	@RequestMapping(value="/todo/remove", method = RequestMethod.GET)
	public String remove(long mid, PageRequestDTO pageRequestDTO) {
		
		boardService.remove(mid);
		
		return "redirect:/board/list" + pageRequestDTO.getLink();
	}
	
	//공지사항 상세보기
	@RequestMapping("/detailNotice")
	public String detailNotice(Model model) {
		
		return "/admin/detailNotice";
	}
	
	//공지사항 수정
	@RequestMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model) {
		return "/admin/updateNoticeForm";
	}
	
	//공지사항 삭제
	@RequestMapping("/removeNotice")
	public String removeNotice(Model model) {
		
		return "redirect:/board/list";
	}
	
	
}
