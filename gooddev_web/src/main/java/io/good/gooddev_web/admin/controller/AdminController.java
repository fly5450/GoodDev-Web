package io.good.gooddev_web.admin.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String main(HttpSession session) {
	    Character isAdminYn = (Character) session.getAttribute("isAdminYn");
	    
	    // isAdminYn이 null일 경우 기본값을 'N'으로 설정
	    if (isAdminYn == null) {
	        isAdminYn = 'N'; // 기본값 설정
	    }
	    
	    if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
	    }
	    System.out.println("세션저장어떻게됏냐?: " + isAdminYn);
	    return "admin/admin_main"; // 관리자 페이지로 이동
	}
	
	//전체 회원목록 조회
	@GetMapping("/memberList")
	public String getMemberList(@RequestParam char isAdminYn, PageRequestDTO pageRequestDTO, BindingResult bindingResult ,Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	    }
		 
	    PageResponseDTO<MemberDTO> responseDTO = memberService.getList(pageRequestDTO);
	    model.addAttribute("pageResponseDTO", responseDTO);
	    
	    return "admin/memberList";  
	}
	
	//회원 상세보기
	@GetMapping("/detailMember")
	public String detailMember(@RequestParam char isAdminYn, @RequestParam String mid, Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
	    MemberDTO member = memberService.getRead(mid);
	    model.addAttribute("member", member);
	    
	    return "/admin/detailMember";
	}
	
	//전체 게시물 조회
	@GetMapping("/boardList")
	public PageResponseDTO<BoardDTO> getBoardList(@RequestParam char isAdminYn, PageRequestDTO pageRequestDTO, Model model) {
		if (isAdminYn != 'Y') {
	        return null; // 관리자 권한이 없을 경우 null 반환 또는 에러 처리
	    }
		
		int totalCount = boardDAO.getTotalCount(pageRequestDTO);
		
		// 전체 게시물 가져오기 (필터링은 하지 않음)
	    List<BoardDTO> boards = boardDAO.getList(pageRequestDTO).stream()
	            .map(board -> mapper.map(board, BoardDTO.class))
	            .collect(Collectors.toList());

	    return new PageResponseDTO<>(pageRequestDTO, boards, totalCount); // 총 개수는 필터링된 개수로 설정
	}
	
	//게시물 상세보기
	@GetMapping("/detailBoard")
	public String detailBoard(@RequestParam char isAdminYn, @RequestParam int bno,Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
	    model.addAttribute("board", boardService.getRead(bno));
	    
	    return "admin/detailBoard";
	}
	
	//전체 공지사항 조회
	@GetMapping("/noticeList")
	public String getNoticeList(@RequestParam char isAdminYn, PageRequestDTO pageRequestDTO, Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
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
	public String remove(@RequestParam char isAdminYn, int bno, PageRequestDTO pageRequestDTO) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		boardService.remove(bno);
		
		return "redirect:/admin/boardList" + pageRequestDTO.getLink();
	}
	
	//공지사항 상세보기
	@RequestMapping("/detailNotice")
	public String detailNotice(@RequestParam char isAdminYn, int bno, Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		model.addAttribute("board", boardService.getRead(bno));
		
		return "/admin/detailNotice";
	}
	
	//공지사항 수정 폼
	@GetMapping("/updateNotice")
	public String updateNotice(@RequestParam char isAdminYn, Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		return "/admin/updateNotice";
	}
	
	//공지사항 수정 처리
	@PostMapping("/updateNoticeForm")
	public String updateNotice(@RequestParam char isAdminYn, BoardDTO boardDTO, BindingResult bindingResult, Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
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
	public String removeNotice(@RequestParam char isAdminYn, long mid ,Model model) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		boardService.remove(mid);
		
		return "redirect:/noticeList";
	}
	
	//공지사항 등록
	@GetMapping("/insertNotice")
	public String insertNoticeGet(@RequestParam char isAdminYn) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		log.info("insertNotice 진행중()...");
		
		return "admin/insertNotice";
	}
	
	//공지사항 등록
	@PostMapping("/insertNotice")
	public String insertNotice(@RequestParam char isAdminYn, BoardDTO boardDTO) {
		if (isAdminYn != 'Y') {
	        return "redirect:/errorPage"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		boardService.insert(mapper.map(boardDTO, BoardVO.class));
		
		return "redirect:/admin/noticeList";
	}
	
	
	
}
