package io.good.gooddev_web.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.board.dao.BoardDAO;
import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.vo.BoardVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {
    private final BoardDAO boardDAO;
    private final MapperUtil mapper;

    public HashMap<String,List<BoardDTO>> getTotalList(PageRequestDTO pageRequestDTO) {
        HashMap<String,List<BoardDTO>> map = new HashMap<>();
        List<Integer> totalCategory= boardDAO.getTotalCategory();
        for(int category : totalCategory){
            String categoryName = String.valueOf(category);
            pageRequestDTO.setCategory_no(String.valueOf(category));
            List <BoardDTO> boardlist = boardDAO.getList(pageRequestDTO).stream().map(board -> mapper.map(board, BoardDTO.class)).collect(Collectors.toList());
            map.put(categoryName,boardlist);
        }
        return map;
    }

    public PageResponseDTO<BoardDTO> getList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> getList = boardDAO.getList(pageRequestDTO).stream().map(board -> mapper.map(board, BoardDTO.class)).collect(Collectors.toList());
		return new PageResponseDTO(pageRequestDTO, getList, boardDAO.getTotalCount(pageRequestDTO));
	}
    
	public int remove(long mid) {
		return boardDAO.remove(mid);
	}
    
    public BoardDTO getRead(int bno) {
    	BoardVO board = boardDAO.getRead(bno).orElse(null);
    	return board != null ? mapper.map(board, BoardDTO.class) : null;
    }
    
    public void viewCount(int num) {
    	boardDAO.viewCount(num);
    }
    
    public int insert(final BoardVO boardVO) {
    	return boardDAO.insert(boardVO);
    }
    
    public void addLike(final int bno, String mid) {
        if (!boardDAO.existsLike(mid, bno)) {
            // 좋아요가 없으면 추가 (DELETEYN 'N' 설정 및 like_board 1)
            boardDAO.insertLike(mid, bno, 1);
            boardDAO.updateLikeCount(bno, 1);
        }
    }

    public void cancelLike(int bno, String mid) {
        // 좋아요가 있으면 취소 (DELETEYN 'Y' 설정 및 like_board 0)
        boardDAO.updateDeleteYN(mid, bno, 'Y');
        boardDAO.updateLikeCount(bno, -1);
    }

    public boolean hasUserLiked(int bno, String mid) {
        return boardDAO.existsLike(mid, bno);
    }
    
    public int getLikeCount(int bno) {
        return boardDAO.getLikeCount(bno);
    }

    public int getHateCount(int bno) {
        return boardDAO.getHateCount(bno);
    }

    public List<BoardDTO> topTenList() {
        return boardDAO.topTenList().stream()
                       .map(board -> mapper.map(board, BoardDTO.class))
                       .collect(Collectors.toList());
        
    }

}
