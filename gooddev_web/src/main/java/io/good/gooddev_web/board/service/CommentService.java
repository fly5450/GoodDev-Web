package io.good.gooddev_web.board.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.board.dao.CommentDAO;
import io.good.gooddev_web.board.dto.CommentDTO;
import io.good.gooddev_web.board.vo.CommentVO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommentService {
	
//	public List<CommentDTO> getCommentByBno(int bno) {
//		List<CommentVO> commentList = commentDAO.findAllByBno(bno);
//		List<CommentVO> cocommentList = new ArrayList<CommentVO>();
//		for (CommentVO commentVO : commentList) {
//			cocommentList.addAll(commentDAO.notNullCommentList(commentVO.getCno()));
//		}
//		commentList.addAll(cocommentList);
//		return commentList.stream().map(comment -> mapper.map(comment, CommentDTO.class)).collect(Collectors.toList());
//	}

	private final CommentDAO commentDAO;
	private final MapperUtil mapper;

	public List<CommentDTO> getCommentByBno(int bno) {
		return commentDAO.findAllByBno(bno).stream().map(comment -> mapper.map(comment, CommentDTO.class)).collect(Collectors.toList()); 
	}
	
	public int insert(final CommentVO commentVO) {
		return commentDAO.insert(commentVO);
	}
	
	public List<CommentDTO> getNotNullCommentByBnoAndCno(int bno, int cno) {
		return commentDAO.notNullCommentList(bno, cno).stream().map(comment -> mapper.map(comment, CommentDTO.class)).collect(Collectors.toList());
	}
	
	public CommentDTO getComment(int cno) {
		CommentVO comment = commentDAO.getComment(cno).orElse(null);
		return comment != null ? mapper.map(comment, CommentDTO.class) : null;
	}
}
