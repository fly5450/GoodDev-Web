package io.good.gooddev_web;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class home {
	
	@GetMapping("/home")
	public void homeView(Model model) {
		model.addAttribute("serverTime", LocalDateTime.now());
	}
}
