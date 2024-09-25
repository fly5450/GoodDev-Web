package io.good.gooddev_web.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final MapperUtil mapper;
	private final BoardService boardService;
	
	@GetMapping("/board/list")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
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
}
