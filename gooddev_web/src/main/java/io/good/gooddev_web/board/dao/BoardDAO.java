package io.good.gooddev_web.board.dao;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.BoardCategoryVO;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface  BoardDAO {
    List<BoardCategoryVO> getTotalCategory();
    List<BoardVO> getList(PageRequestDTO pageRequestDTO);
    List<BoardVO> getList();
    int getTotalCount(PageRequestDTO pageRequestDTO);
	public int remove(long mid);
    Optional<BoardVO> getRead(int bno);
    void viewCount(int num); 
    int insert(BoardVO boardVO);
    boolean existsLike(@Param("mid") String mid, @Param("bno") int bno);
    void insertLike(@Param("mid") String mid, @Param("bno") int bno, @Param("likeValue") int likeValue);
    void updateDeleteYN(@Param("mid") String mid, @Param("bno") int bno, @Param("deleteYN") char deleteYN);
    void updateLikeCount(@Param("bno") int bno, @Param("likeValue") int likeValue);
    int getLikeCount(int bno);
    int getHateCount(int bno);
    List<BoardVO> topTenList();
}
