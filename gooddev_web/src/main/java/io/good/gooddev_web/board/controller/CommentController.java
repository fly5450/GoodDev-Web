package io.good.gooddev_web.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.good.gooddev_web.board.dto.CommentDTO;
import io.good.gooddev_web.board.service.CommentService;
import io.good.gooddev_web.board.vo.CommentVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CommentController {

	public final CommentService commentService;
	public final MapperUtil mapper;
	
	@PostMapping("/board/comment/insert")
	public String insert(CommentDTO commentDTO, PageRequestDTO pageRequestDTO, Model model,@RequestParam String link) {
		commentService.insert(mapper.map(commentDTO, CommentVO.class));
		return "redirect:/board/read?bno=" + commentDTO.getBno() + "&" + pageRequestDTO.getLink() +"&link="+link;
	}
	
}
