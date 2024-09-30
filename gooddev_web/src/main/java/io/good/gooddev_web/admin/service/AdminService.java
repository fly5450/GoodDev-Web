package io.good.gooddev_web.admin.service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import io.good.gooddev_web.board.dao.BoardDAO;
import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class AdminService {
	
	private final MapperUtil mapperUtil;
	private final MemberDAO memberDAO;
	private final BoardService boardService;
	private final BoardDAO boardDAO;
	
	//멤버 조회
	public PageResponseDTO<MemberDTO> getMemberList(PageRequestDTO pageRequestDTO) {
		List<MemberDTO> list = memberDAO.getList(pageRequestDTO).stream().map(member -> mapperUtil.map(member, MemberDTO.class)).collect(Collectors.toList());
		return new PageResponseDTO<MemberDTO>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
	}
	
	public int remove(String uid) {
		return memberDAO.remove(uid);
	}
	
//	//전체 게시물 조회 (category_no이 20,30,40,50 인 것만 가져옴)
//	public PageResponseDTO<BoardDTO> getBoardList(PageRequestDTO pageRequestDTO, Model model) {
//		List<Integer> categoryNo = Arrays.asList(20,30,40,50);
//		List<BoardDTO> list = boardDAO.getListByCategories(pageRequestDTO, categoryNo)
//									  .stream()
//									  .map(board -> mapperUtil.map(board, BoardDTO.class))
//									  .collect(Collectors.toList());
//		
//		int totalCount = boardDAO.getTotalCountByCategories(pageRequestDTO, categoryNo);
//		
//		return new PageResponseDTO<>(pageRequestDTO, list, totalCount);
//	}
//	
//	//공지사항 조회 (category_no이 10 인 것만 가져옴)
//	public PageResponseDTO<BoardDTO> getNoticeList(PageRequestDTO pageRequestDTO) {
//		List<BoardDTO> list = boardDAO.getListByCategory(pageRequestDTO, 10)
//						              .stream()
//						              .map(board -> mapperUtil.map(board, BoardDTO.class))
//						              .collect(Collectors.toList());
//
//	int totalCount = boardDAO.getTotalCountByCategory(pageRequestDTO, 10);
//	
//	return new PageResponseDTO<>(pageRequestDTO, list, totalCount);
//    }
}
