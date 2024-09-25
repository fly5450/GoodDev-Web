package io.good.gooddev_web.board.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface  BoardDAO {
    List<Integer> getTotalCategory();
    List<BoardVO> getList(PageRequestDTO pageRequestDTO);
    List<BoardVO> getList();
    int getTotalCount(PageRequestDTO pageRequestDTO);
    Optional<BoardVO> getRead(int bno);
    void viewCount(int num); 
    int insert(BoardVO boardVO);
}
