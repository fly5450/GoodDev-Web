package io.good.gooddev_web.search;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequiredArgsConstructor
public class SearchController {
    private final BoardService boardService;

    @PostMapping("/search")
    public String serachPost(String keyword,Model model,RedirectAttributes redirectAttributes,PageRequestDTO pageRequestDTO){
        log.info(keyword);
        if (keyword == null) {
            redirectAttributes.addFlashAttribute("message", "검색어를 입력해 주세요");
            redirectAttributes.addAttribute("keyword", keyword);
            return "redirect:/";
		} else if (keyword.length() < 2){
            redirectAttributes.addFlashAttribute("message", "검색어를 2글자 이상 입력해 주세요");
            redirectAttributes.addAttribute("keyword", keyword);
            return "redirect:/";
		}
        HashMap<String,List<BoardDTO>> totalMap = boardService.getTotalList(pageRequestDTO);
		model.addAttribute("totalMap",totalMap);
		model.addAttribute("pageRequestDTO", pageRequestDTO);
        return "search";
    }
}
