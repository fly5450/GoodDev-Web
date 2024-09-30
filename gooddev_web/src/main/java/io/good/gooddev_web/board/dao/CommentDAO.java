package io.good.gooddev_web.board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.board.vo.CommentVO;

@Repository
public interface CommentDAO {
	List<CommentVO> getList(CommentVO commentVO);
	int insert(CommentVO commentVO);
}
