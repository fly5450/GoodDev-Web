package io.good.gooddev_web.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.member.dto.MemberDTO;
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
	
	//
	private final MapperUtil mapperUtil;
	private final MemberService memberService;
	private final BoardService boardService;
	
	@RequestMapping("")
	public String main() {
		return "admin/admin_main";
	}
	
	
	//전체 회원목록 조회
	@GetMapping("/memberList")
	public String getMemberList(PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
	    if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	    }
	    
	    PageResponseDTO<MemberDTO> responseDTO = memberService.getList(pageRequestDTO);
	    
	    model.addAttribute("pageResponseDTO", responseDTO);

	    return "admin/memberList";  
	}
	//전체 공지사항 조회
	@GetMapping("/noticeList")
	public void getBoardList(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
	}
	//공지사항 삭제
	@RequestMapping(value="/todo/remove", method = RequestMethod.GET)
	public String remove(int bno, PageRequestDTO pageRequestDTO) {
		
		boardService.remove(bno);
		
		return "redirect:noticeList" + pageRequestDTO.getLink();
	}
	
	//공지사항 상세보기
	@RequestMapping("/detailNotice")
	public String detailNotice(int bno, Model model, PageRequestDTO pageRequestDTO) {
		
		model.addAttribute("board", boardService.getRead(bno));
		
		return "/admin/detailNotice";
	}
	
	//공지사항 수정
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model) {
		
		return "/admin/updateNoticeForm";
	}
	
	//공지사항 수정
	@PostMapping("/updateNoticeForm")
	public String updateNotice(PageRequestDTO pageRequestDTO) {
		
		return "/admin/detailNotice";
	}
	
	//공지사항 삭제
	@RequestMapping("/removeNotice")
	public String removeNotice(long mid ,Model model) {
		
		boardService.remove(mid);
		
		return "redirect:/noticeList";
	}
	
	//공지사항 등록
	@GetMapping("/insertNotice")
	public String insertNoticeGet() {
		log.info("insertNotice 진행중()...");
		
		return "redirect:/noticeList";
	}
	//공지사항 등록
	@PostMapping("/insertNotice")
	public String insertNotice(BoardDTO boardDTO, Model model, MemberDTO memberDTO) {
		boardService.insert(mapperUtil.map(boardDTO, BoardVO.class));
		
		return "redirect:/noticeList";
	}
	
	
	
}
