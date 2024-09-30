package io.good.gooddev_web.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("/comment/insert")
	public String insert(CommentDTO commentDTO, PageRequestDTO pageRequestDTO, Model model,@RequestParam String link) {
		commentService.insert(mapper.map(commentDTO, CommentVO.class));
		return "redirect:/board/read?bno=" + commentDTO.getBno() + "&" + pageRequestDTO.getLink() +"&link="+link;
	}
	
	@PostMapping("/comment/cocomment")
	@ResponseBody
	public ResponseEntity<Map<String, List<CommentDTO>>> likeBoard(CommentDTO commentDTO) {
	    Map<String, List<CommentDTO>> response = new HashMap<>();
		response.put("cocomments", commentService.getList(mapper.map(commentDTO,CommentVO.class)));
	    return ResponseEntity.ok(response);
	}
}

