package io.good.gooddev_web.admin.controller;


import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.good.gooddev_web.board.dao.BoardDAO;
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
	private final MapperUtil mapper;
	private final MemberService memberService;
	private final BoardService boardService;
	private final BoardDAO boardDAO;
	
	@RequestMapping("")
	public String main() {
		return "admin/admin_main";
	}
	
	//전체 회원목록 조회
	@GetMapping("/memberList")
	public String getMemberList(PageRequestDTO pageRequestDTO, BindingResult bindingResult ,Model model) {
		 if (bindingResult.hasErrors()) {
	            log.error("Binding errors: {}", bindingResult.getAllErrors());
	        }
		 
	    PageResponseDTO<MemberDTO> responseDTO = memberService.getList(pageRequestDTO);
	    model.addAttribute("pageResponseDTO", responseDTO);
	    
	    return "admin/memberList";  
	}
	
	//전체 게시물 조회
	@GetMapping("/boardList")
	public PageResponseDTO<BoardDTO> getBoardList(PageRequestDTO pageRequestDTO, Model model) {
		
		List<BoardDTO> boards = boardDAO.getList(pageRequestDTO).stream()
	            .filter(board -> board.getCategory_no() != 10) // category_no가 10이 아닌 게시물만 필터링
	            .map(board -> mapper.map(board, BoardDTO.class))
	            .collect(Collectors.toList());

	    return new PageResponseDTO<>(pageRequestDTO, boards, boards.size()); // 총 개수는 필터링된 개수로 설정
	}
	
	//전체 공지사항 조회
	@GetMapping("/noticeList")
	public String getNoticeList(PageRequestDTO pageRequestDTO, Model model) {
	    
		String category = "10"; // 공지사항 카테고리
	    pageRequestDTO.setCategory_no(category); // category_no 설정

	    // 전체 게시물 가져오기
	    PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);

	    // 필터링된 공지사항 목록
	    List<BoardDTO> noticeList = pageResponseDTO.getList();

	    log.info("Filtered Notice List Size값 한글: {}", noticeList.size());

	    // 모델에 추가
	    model.addAttribute("pageRequestDTO", pageRequestDTO);
	    model.addAttribute("pageResponseDTO", pageResponseDTO);
	    
	    return "admin/noticeList"; // JSP 경로
	}
	
	//게시물 삭제
	@GetMapping("/remove")
	public String remove(int bno, PageRequestDTO pageRequestDTO) {
		
		boardService.remove(bno);
		
		return "redirect:/admin/boardList";
	}
	
	//공지사항 상세보기
	@RequestMapping("/detailNotice")
	public String detailNotice(int bno, Model model) {
		
		model.addAttribute("board", boardService.getRead(bno));
		
		return "/admin/detailNotice";
	}
	
	//공지사항 수정 폼
	@GetMapping("/updateNotice")
	public String updateNotice(Model model) {
		
		return "/admin/updateNotice";
	}
	
	//공지사항 수정 처리
	@PostMapping("/updateNoticeForm")
	public String updateNotice(BoardDTO boardDTO, BindingResult bindingResult, Model model) {
		
		if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	        // 오류가 있을 경우 수정 폼으로 다시 이동
	        model.addAttribute("board", boardDTO);
	        return "admin/updateNoticeForm";
	    }

//	    // 공지사항 수정
//	    boardService.update(mapper.map(boardDTO, BoardVO.class));
		
		return "redirect:/admin/noticeList";
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
		
		return "admin/insertNotice";
	}
	//공지사항 등록
	@PostMapping("/insertNotice")
	public String insertNotice(BoardDTO boardDTO) {
		boardService.insert(mapper.map(boardDTO, BoardVO.class));
		
		return "redirect:/admin/noticeList";
	}
	
	
	
}
