package io.good.gooddev_web.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {
	
	private final MapperUtil mapper;
	private final BoardService boardService;
	
	@GetMapping("/board/list")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		List<BoardDTO> topTenList = boardService.topTenList();
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
		model.addAttribute("topTenList", topTenList);
	}
	
	@GetMapping("/board/read")
	public void boardRead(@RequestParam int bno, PageRequestDTO pageRequestDTO, Model model) {
		boardService.viewCount(bno);
	    model.addAttribute("board", boardService.getRead(bno));
	}
	
	@GetMapping("/board/update")
	public void boardUpdate(int bno, Model model) {
		model.addAttribute("board", boardService.getRead(bno));
	}
	
	@GetMapping("/board/insert")
	public void boardInsertView(Model model) {
		
	}
	
	@PostMapping("/board/insert")
	public String boardInsert(BoardDTO boardDTO, Model model, MemberDTO memberDTO) {
		boardService.insert(mapper.map(boardDTO, BoardVO.class));
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/board/like")
	@ResponseBody
	public ResponseEntity<Map<String, Integer>> likeBoard(@RequestParam int bno, HttpSession session) {
	    Map<String, Integer> response = new HashMap<>();
	    MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
		String mid = member.getMid();
	    if (mid != null) {
	        // 좋아요 상태 확인
	        boolean hasLiked = boardService.hasUserLiked(bno, mid);

	        if (hasLiked) {
	            // 이미 좋아요를 누른 경우 -> 취소 (DELETEYN 'Y' 처리)
	            boardService.cancelLike(bno, mid);
	        } else {
	            // 좋아요를 누르지 않은 경우 -> 추가 (DELETEYN 'N' 처리)
	            boardService.addLike(bno, mid);
	        }

	        // 최신 좋아요/싫어요 수 반환
	        response.put("likeCount", boardService.getLikeCount(bno));
	    }

	    return ResponseEntity.ok(response);
	}
	
	@PostMapping("/board/hate")
	@ResponseBody
	public ResponseEntity<Map<String, Integer>> hateBoard(@RequestParam int bno, HttpSession session) {
	    Map<String, Integer> response = new HashMap<>();
	    MemberDTO member = (MemberDTO) session.getAttribute("loginInfo");
		String mid = member.getMid();
	    if (mid != null) {
	        // 싫어요 상태 확인
	        boolean hasLiked = boardService.hasUserLiked(bno, mid);

	        if (hasLiked) {
	            // 이미 싫어요를 누른 경우 -> 취소 (DELETEYN 'Y' 처리)
	            boardService.cancelLike(bno, mid);
	        } else {
	            // 싫어요를 누르지 않은 경우 -> 추가 (DELETEYN 'N' 처리)
	            boardService.addLike(bno, mid);
	        }

	        // 최신 싫어요 수 반환
	        response.put("hateCount", boardService.getHateCount(bno));
	    }

	    return ResponseEntity.ok(response);
	}
	
}
