package test.com.todayhome.controller.event;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.EventVO;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.EventService;
import test.com.todayhome.service.MemberService;

@Slf4j
@Controller
public class EventViewController {
	
	@Autowired
	EventService service;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ServletContext sContext;
	
	@RequestMapping(value = "/evSelectAll", method = RequestMethod.GET)
	public String evSelectAll(Model model, HttpSession session) {
		log.info("/evSelectAll");

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		List<EventVO> vos = service.selectAll();
		model.addAttribute("vos",vos);
		
		return "event/selectAll";
	}
	
	@RequestMapping(value = "/evSelectOne/{num}", method = RequestMethod.GET)
	public String selectOne(@PathVariable("num") int num, Model model, EventVO vo, HttpServletRequest request) {
		log.info("evSelectOne...{}", vo);
		
		EventVO vo2 = service.selectOne(vo);
		model.addAttribute("vo2", vo2);
		
			//섹션 객체에 연결되어 있는 닉네임,프사 가져오기
			HttpSession session = request.getSession(); // 세션 객체 가져오기
			log.info("session:{}",session.toString());
			String memberIdString = (String) session.getAttribute("user_id");
			
		    // 사용자 정보가 없는 경우 로그인 페이지로 리다이렉트
		    if (memberIdString == null) {
		        return "redirect:/login";
		    }
			
			int memberId = Integer.parseInt(memberIdString);
			log.info("memberId:{}",memberId);
			MemberVO mvo = new MemberVO();
			mvo.setNum(memberId);
			MemberVO mvo2 = memberService.selectOne(mvo);
			model.addAttribute("mvo2",mvo2);
		
		return "event/selectOne";
	}
	
	

	

}
