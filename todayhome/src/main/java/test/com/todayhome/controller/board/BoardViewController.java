package test.com.todayhome.controller.board;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.BoardService;
import test.com.todayhome.service.MemberService;

@Slf4j
@Controller
public class BoardViewController {

	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;

	@Autowired
	ServletContext sContext;

	@RequestMapping(value = "/bUpdate", method = RequestMethod.GET)
	public String bSelectAll(Model model) {
		log.info("/bSelectAll");
		return "board/selectAll";
	}

	@RequestMapping(value = "/bInsert", method = RequestMethod.GET)
	public String bInsert(Model model, BoardVO pBoard,HttpServletRequest request) {
		log.info("/bInsert...");
		
//		BoardVO board = boardService.bSelectOne(pBoard);
//		model.addAttribute("boardModel",board);
		
		//섹션 객체에 연결되어 있는 닉네임,프사 가져오기
		HttpSession session = request.getSession(); // 세션 객체 가져오기
		log.info("session:{}",session.toString());
		String memberIdString = (String) session.getAttribute("user_id");
		
		int memberId = Integer.parseInt(memberIdString);
		log.info("memberId:{}",memberId);
		MemberVO mvo = new MemberVO();
		mvo.setNum(memberId);
		MemberVO mvo2 = memberService.selectOne(mvo);
		model.addAttribute("mvo2",mvo2);
		
		return "board/insert";
	}

	@RequestMapping(value = "/bSearchList", method = RequestMethod.GET)
	public String bSearchList(Model model,String searchKey, String searchWord, HttpSession session) {
		log.info("/bsearchList");
		log.info("searchKey:{}",searchKey);
		log.info("searchWord:{}",searchWord);

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);
		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);

		List<BoardVO> vos = boardService.searchList(searchKey,searchWord);

		model.addAttribute("currMbr", currMbr);
		model.addAttribute("vos", vos);
		model.addAttribute("searchFlag", vos.size() != 0 ? 1 : 0);

		return "board/searchList";
	}


}
