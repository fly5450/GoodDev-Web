package io.good.gooddev_web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import io.good.gooddev_web.board.dto.BoardDTO;
import io.good.gooddev_web.board.service.BoardService;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {
    private final MemberService memberService;
    private final BoardService boardService;

    @GetMapping("/")
    public String main(HttpServletRequest request,Model model,HttpServletResponse response) {
        HttpSession session = request.getSession();
        if(request.getCookies() != null){
            for(Cookie cookie : request.getCookies()){
                if(cookie.getName().equals("autoLoginTrue")){
                    MemberDTO member = memberService.getRead_Auto_Login(cookie.getValue());
                    if(member!=null){
                        session.setAttribute("loginInfo", member);
                        cookie.setMaxAge(60 * 10);
                        response.addCookie(cookie);
                    }
                }
            }
        }
        List<BoardDTO> noticeList = boardService.getNoticeList();
        List<BoardDTO> galleryList  = boardService.getGalleryList();
        Map<String,List<BoardDTO>> mainMap = boardService.getMainList();
        List<BoardDTO> topTenList = boardService.topTenList();
        model.addAttribute("noticeList",noticeList);
        model.addAttribute("mainMap", mainMap);
        model.addAttribute("galleryList",galleryList);
        model.addAttribute("topTenList", topTenList);
        return "main";
    }
}
