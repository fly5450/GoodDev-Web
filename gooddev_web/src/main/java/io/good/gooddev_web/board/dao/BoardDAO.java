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
    int update(BoardVO boardVO);
    int delete(@Param("bno") int bno, @Param("board_password") String board_password);
    boolean existsHate(@Param("mid") String mid, @Param("bno") int bno);
    void updateHateCount(@Param("bno") int bno, @Param("hateValue") int hateValue);
    void insertHate(@Param("mid") String mid, @Param("bno") int bno, @Param("hateValue") int hateValue);
	List<BoardVO> getBoardsByMid(String mid);
    int deleteBoard(int bno);
}
