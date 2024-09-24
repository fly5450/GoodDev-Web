package io.good.gooddev_web.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.BoardVO;

@Repository
public interface BoardDAO {
	
	public List<BoardVO> getList();

//	public BoardVO getRead(Long bno);
}
