package io.good.gooddev_web.board.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.board.dao.BoardDAO;
import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final MapperUtil mapperUtil;
	private final BoardDAO boardDAO;
	
	public List<BoardDTO> getList() {
		List<BoardVO> getList = boardDAO.getList();
		System.out.println("boardServiceGetList : " + getList);
		return boardDAO.getList().stream().map(board -> mapperUtil.map(board, BoardDTO.class)).collect(Collectors.toList());
	}
	
//	public BoardDTO getRead(Long bno) {
//		BoardVO board = boardDAO.getRead(bno);
//		return board != null ? mapperUtil.map(board, BoardDTO.class) : null; 
//	}
}
