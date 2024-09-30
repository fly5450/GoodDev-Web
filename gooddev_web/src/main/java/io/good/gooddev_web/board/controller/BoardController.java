package io.good.gooddev_web.board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.dto.BoardFileDTO;
import io.good.gooddev_web.board.dto.CommentDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.board.service.CommentService;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.board.vo.CommentVO;
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

	@Qualifier("uploadPath")
    private final String uploadPath;

	private final MapperUtil mapper;
	private final BoardService boardService;
	private final CommentService commentService;
	
	@GetMapping("/board/list")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		List<BoardDTO> topTenList = boardService.topTenList();
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
		model.addAttribute("topTenList", topTenList);
	}
	
	@GetMapping("/board/read")
	public void boardRead(@RequestParam int bno,@RequestParam String link,Model model) {
		boardService.viewCount(bno);
		CommentVO commentVO = new CommentVO(String.valueOf(bno));

		List<CommentDTO> commentAllByBno = commentService.getList(commentVO);
		 if (link != null) {
			link = URLDecoder.decode(link, StandardCharsets.UTF_8);
		}
		
	    model.addAttribute("board", boardService.getRead(bno));
		model.addAttribute("comments", commentAllByBno);
		model.addAttribute("link", link);
	}
	
	@GetMapping("/board/update")
	public void boardUpdate(int bno, Model model) {
		model.addAttribute("board", boardService.getRead(bno));
	}
	
	@PostMapping("/board/update")
	public String update(BoardDTO boardDTO, PageRequestDTO pageRequestDTO) {
		boardService.update(mapper.map(boardDTO, BoardVO.class));
		return "redirect:/board/list?" + pageRequestDTO.getLink();
	}
	
	@GetMapping("/board/delete")
	public String delete(int bno, PageRequestDTO pageRequestDTO) {
		boardService.delete(bno);
		return "redirect:/board/list?" + pageRequestDTO.getLink();
	}
	
	@GetMapping("/board/insert")
	public void boardInsertView(@RequestParam("category_no") String category_no, Model model) {
		model.addAttribute("totalCategory", boardService.getTotalCategory());
		model.addAttribute("category_no", category_no);
	}
	
	@PostMapping("/board/insert")
	public String boardInsert(BoardDTO boardDTO, Model model, MemberDTO memberDTO, PageRequestDTO pageRequestDTO) {
		try{
			int result = boardService.insert(mapper.map(boardDTO, BoardVO.class));
			return "redirect:/board/read?bno="+result;
		}catch(Exception e){
			return "redirect:/board/list?" + pageRequestDTO.getLink();
		}
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

	@GetMapping(value="/board/download/{fid}")
	public void download(@PathVariable("fid") String fid, HttpServletResponse response) throws Exception {
		BoardFileDTO boardFileDTO = boardService.getBoardFile(fid);
		if (boardFileDTO == null) {
			response.setStatus(404);
		} else {
			String file_name = boardFileDTO.getFile_name();
			file_name = URLEncoder.encode(file_name, "utf-8");
			response.setContentLength(boardFileDTO.getFile_size());
			response.setContentType(boardFileDTO.getFile_type());
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Content-disposition", "attachment; fileName=" + file_name);
			try (
				BufferedInputStream bin = new BufferedInputStream((new FileInputStream(uploadPath + boardFileDTO.getFid())));
				BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			){
				bin.transferTo(bos);
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
	}

	@GetMapping("/board/gallery")
	public void gallery(PageRequestDTO pageRequestDTO, Model model) {
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getGalleryList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
	}
}


	

