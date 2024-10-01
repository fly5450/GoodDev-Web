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
	private final CommentDAO commentDAO;
	private final MapperUtil mapper;

	public List<CommentDTO> getList(CommentVO commentVO) {
		log.info(commentVO.getParent_cno());
		return commentDAO.getList(commentVO).stream().map(comment -> mapper.map(comment, CommentDTO.class)).collect(Collectors.toList()); 
	}

	public CommentDTO insert(final CommentVO commentVO) {
		commentDAO.insert(commentVO);
		return mapper.map(commentVO,CommentDTO.class);
	}
}
