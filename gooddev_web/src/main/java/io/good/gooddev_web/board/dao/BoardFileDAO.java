package io.good.gooddev_web.board.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.BoardFileVO;

@Repository
public interface BoardFileDAO {
    int insert(BoardFileVO boardFileVO);

	List<BoardFileVO> getList(int bno);

	Optional<BoardFileVO> getRead(String fid);

	int delete(int bno);
}
