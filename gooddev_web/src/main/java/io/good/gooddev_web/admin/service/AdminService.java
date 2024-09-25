package io.good.gooddev_web.admin.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import io.good.gooddev_web.board.dao.BoardDAO;
import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private MapperUtil mapperUtil;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private BoardService boardService;
	
	public PageResponseDTO<MemberDTO> getList(PageRequestDTO pageRequestDTO) {
		List<MemberDTO> list = memberDAO.getList(pageRequestDTO).stream().map(member -> mapperUtil.map(member, MemberDTO.class)).collect(Collectors.toList());
		
		return new PageResponseDTO<MemberDTO>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
	}
	
	public int remove(String uid) {
		return memberDAO.removeMember(uid);
	}
	
	
	@GetMapping("/board/list")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
	}
}
