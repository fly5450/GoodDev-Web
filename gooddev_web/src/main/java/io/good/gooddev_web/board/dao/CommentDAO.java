package io.good.gooddev_web.board.dao;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.CommentVO;

@Repository
public interface CommentDAO {
	List<CommentVO> findAllByBno(@Param("bno") int bno);
	int insert(CommentVO commentVO);
	List<CommentVO> notNullCommentList(@Param("bno") int bno, @Param("cno") int cno);
	Optional<CommentVO> getComment(int cno);
}
