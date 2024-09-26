package io.good.gooddev_web.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private MapperUtil mapperUtil;
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardService boardService;
	

	@GetMapping("/memberList")
	public String getMemberList(@Validated PageRequestDTO pageRequestDTO, BindingResult bindingResult, Model model) {
	    if (bindingResult.hasErrors()) {
	        log.error("Binding errors: {}", bindingResult.getAllErrors());
	    }
	    
	    log.info("PageRequestDTO�� Ȯ��: page={}, size={}", pageRequestDTO.getPage(), pageRequestDTO.getSize());

	    PageResponseDTO<MemberDTO> responseDTO = memberService.getList(pageRequestDTO);
	    log.info("Total members ��: {}", responseDTO.getTotal());
	    log.info("Member list size ��: {}", responseDTO.getList().size());
	    
	    model.addAttribute("pageResponseDTO", memberService.getList(pageRequestDTO));

	    return "admin/memberList";  
	}
	
	@GetMapping("/noticeList")
	public void boardListView(PageRequestDTO pageRequestDTO, Model model) {
		
		PageResponseDTO<BoardDTO> pageResponseDTO = boardService.getList(pageRequestDTO);
		model.addAttribute("pageResponseDTO", pageResponseDTO);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
	}
	
	@RequestMapping(value="/todo/remove", method = RequestMethod.GET)
	public String remove(long mid, PageRequestDTO pageRequestDTO) {
		
		boardService.remove(mid);
		
		return "redirect:noticeList" + pageRequestDTO.getLink();
	}

	@RequestMapping("/detailNotice")
	public String detailNotice(Model model) {
		
		return "/admin/detailNotice";
	}

	@RequestMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model) {
		return "/admin/updateNoticeForm";
	}

	@RequestMapping("/removeNotice")
	public String removeNotice(Model model) {
		
		return "redirect:/board/list";
	}
	
	
}
