package io.good.gooddev_web.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface  BoardDAO {
    List<Integer> getTotalCategory();
    List<BoardVO> getList(PageRequestDTO pageRequestDTO);
    public List<BoardVO> getList();
    int getTotalCount(PageRequestDTO pageRequestDTO);
	public int remove(long mid);
}
