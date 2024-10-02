package io.good.gooddev_web.admin.controller;

import java.util.Date;
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
	public String main(HttpSession session, Model model) {
	    String isAdminYn = (String) session.getAttribute("isAdminYn");
	    
	    // isAdminYn이 null일 경우 기본값을 "N"으로 설정
	    if (isAdminYn == null) {
	        isAdminYn = "N"; // 기본값 설정
	    }
	    
	    if (!isAdminYn.equals("Y")) {
	        return "redirect:/"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
	    }
	    
	    System.out.println("세션저장어떻게됏냐?: " + isAdminYn);
	    
	    return "admin/admin_main"; // 관리자 페이지로 이동
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
	
	//회원 상세보기
	@GetMapping("/detailMember")
	public String detailMember(@RequestParam String mid, Model model) {
		
	    MemberDTO member = memberService.getRead(mid);
	    model.addAttribute("member", member);
	    
	    return "/admin/detailMember";
	}
	
	//회원 삭제(비활성화)
	@GetMapping("/removeMember")
	public String removeMember(String mid) {
		
		memberService.remove(mid);
		
		return "redirect:/admin/memberList";
	}
	
	//전체 게시물 조회
	@GetMapping("/boardList")
	public PageResponseDTO<BoardDTO> getBoardList(PageRequestDTO pageRequestDTO, Model model) {
		
		int totalCount = boardDAO.getTotalCount(pageRequestDTO);
		
		// 전체 게시물 가져오기 (필터링은 하지 않음)
	    List<BoardDTO> boards = boardDAO.getList(pageRequestDTO).stream()
	            .map(board -> mapper.map(board, BoardDTO.class))
	            .collect(Collectors.toList());

	    return new PageResponseDTO<>(pageRequestDTO, boards, totalCount); // 총 개수는 필터링된 개수로 설정
	}
	
	//게시물 상세보기
	@GetMapping("/detailBoard")
	public String detailBoard(@RequestParam int bno,Model model) {
		
	    model.addAttribute("board", boardService.getRead(bno));
	    
	    return "admin/detailBoard";
	}
	
	//전체 공지사항 조회
	@GetMapping("/noticeList")
	public String getNoticeList(PageRequestDTO pageRequestDTO, Model model) {
		
		String category = "10"; // 공지사항 카테고리
	    pageRequestDTO.setCategory_no(category); // category_no 설정

	    // 전체 게시물 가져오기
	    PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);

	    // 모델에 추가
	    model.addAttribute("pageRequestDTO", pageRequestDTO);
	    model.addAttribute("pageResponseDTO", pageResponseDTO);
	    
	    return "admin/noticeList"; // JSP 경로
	}
	
	//게시물 삭제
	@GetMapping("/removeBoard")
	public String removeBoard(int bno) {
		
		boardService.deleteBoard(bno);


		
		return "redirect:/admin/boardList";
	}
	
	//공지사항 상세보기
	@RequestMapping("/detailNotice")
	public String detailNotice(int bno, Model model) {
		
		model.addAttribute("board", boardService.getRead(bno));
		
		return "/admin/detailNotice";
	}
	
	//공지사항 수정 폼
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model, int bno) {
	    BoardDTO boardDTO = boardService.getRead(bno);
	    model.addAttribute("board", boardDTO); // 가져온 게시글 정보를 모델에 추가
		
		return "admin/updateNoticeForm";
	}
	
	//공지사항 수정 처리
	@PostMapping("/updateNotice")
	public String updateNotice(BoardDTO boardDTO, BindingResult bindingResult, Model model) {
		
		if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	        // 오류가 있을 경우 수정 폼으로 다시 이동
	        model.addAttribute("board", boardDTO);
	        return "admin/updateNoticeForm";
	    }

	    // 공지사항 수정
	    boardService.update(mapper.map(boardDTO, BoardVO.class));
		
		return "redirect:/admin/noticeList";
	}
	
	//공지사항 삭제
	@GetMapping("/removeNotice")
	public String removeNotice(int bno) {
		log.info("bno값:    " + bno);
		boardService.deleteBoard(bno);

		
		return "redirect:/admin/noticeList";
	}
	
	//공지사항 등록
	@GetMapping("/insertNotice")
	public String insertNoticeGet(HttpSession session) {
		String isAdminYn = (String) session.getAttribute("isAdminYn"); // 세션에서 관리자 여부를 가져옴
		if (isAdminYn == null || !isAdminYn.equals("Y")) {
	        return "redirect:/"; // 관리자 권한이 없을 경우 에러 페이지로 리다이렉트
		}
		
		log.info("insertNotice 진행중()...");
		
		return "admin/insertNotice";
	}
	
	//공지사항 등록
	@PostMapping("/insertNotice")
	public String insertNotice(BoardDTO boardDTO, BoardVO boardVO, HttpSession session, Model model) {

	    try {
	        // 세션에서 사용자 ID 가져오기
	        String getMid = (String) session.getAttribute("mid");
	        boardVO.setMid(getMid);
	        log.info("현재 세션의 mid 값: " + getMid);
	        if (getMid == null) {
	            throw new RuntimeException("사용자 ID(mid)가 세션에 존재하지 않습니다.");
	        }
	        boardDTO.setMid(getMid); // BoardDTO에 mid 설정
	        // 현재 날짜와 시간 설정
	        boardDTO.setInsert_date(new Date()); // 현재 날짜를 Date로 직접 설정
	        // 삭제 여부 기본값 설정
	        boardDTO.setDeleteYn("N"); // 신규 게시물은 삭제되지 않음
	        
	        boardDAO.insert(boardVO);
	        
	        
	        return "redirect:/admin/noticeList"; // 공지사항 목록으로 리다이렉트
	    } catch (Exception e) {
	    	log.error("공지작성중 오류: " , e);
	        return "admin/insertNotice"; // 공지사항 등록 페이지로 돌아가기
	    }
	}
	
	
	
}
