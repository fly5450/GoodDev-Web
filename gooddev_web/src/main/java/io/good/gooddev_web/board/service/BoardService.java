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

@Service
@RequiredArgsConstructor
public class BoardService {
    private final BoardDAO boardDAO;
    private final MapperUtil mapper;

    public HashMap<String,List<BoardDTO>> getTotalList(PageRequestDTO pageRequestDTO) {
        HashMap<String,List<BoardDTO>> map = new HashMap<>();
        List<Integer> totalCategory= boardDAO.getTotalCategory();
        for(int category : totalCategory){
            String categoryName = String.valueOf(category);
            pageRequestDTO.setCategory(String.valueOf(category));
            List <BoardDTO> boardlist = boardDAO.getList(pageRequestDTO).stream().map(board -> mapper.map(board, BoardDTO.class)).collect(Collectors.toList());
            map.put(categoryName,boardlist);
        }
        return map;
    }

    public PageResponseDTO<BoardDTO> getList(PageRequestDTO pageRequestDTO) {
		List<BoardDTO> getList = boardDAO.getList(pageRequestDTO).stream().map(board -> mapper.map(board, BoardDTO.class)).collect(Collectors.toList());
		return new PageResponseDTO(pageRequestDTO, getList, boardDAO.getTotalCount(pageRequestDTO));
	}
    
}
