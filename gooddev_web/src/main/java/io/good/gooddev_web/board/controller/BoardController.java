package io.good.gooddev_web.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final MapperUtil mapperUtil;
	private final BoardService boardService;
	
	@GetMapping("/board/list")
	public void boardListView(Model model) {
		model.addAttribute("boardList", boardService.getList());
	}
	
//	@GetMapping("board/read")
//	public void boardRead(Long bno, Model model) {
//		model.addAttribute("board", boardService.getRead(bno));
//	}
}
