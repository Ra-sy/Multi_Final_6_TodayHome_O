package test.com.todayhome.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.MemberService;

@Controller
@Slf4j
public class HomeController {

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) { 
		log.info("HOME");

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		return "home/home";
	}

}
