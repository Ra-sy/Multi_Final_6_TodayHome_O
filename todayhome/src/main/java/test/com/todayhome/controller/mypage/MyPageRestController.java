package test.com.todayhome.controller.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;

import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FavorVO;
import test.com.todayhome.model.FollowVO;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class MyPageRestController {


	@Autowired
	private BoardService boardService;

	@Autowired
	private FollowService followService;

	@Autowired
	private FavorService favorService;

	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/myPage/user/{num}", method = RequestMethod.GET)
	public String myPageProfileMain(@PathVariable("num") int num, Model model, MemberVO pMember, HttpSession session) throws IOException {
		log.info("myPageProfileMain ==> {}", pMember);

		//logged in user_number
		int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

		//DB Connection
		MemberVO member = memberService.mSelectOneUserProfile(pMember);
		List<BoardVO> myBoard = boardService.bSelectMyBoard(pMember);
		List<BoardVO> myFavorBoard = boardService.bSelectFavorBoard(pMember);
		List<FavorVO> favor = favorService.fvSelectAllFromMbr(pMember);
		BoardVO pBoard = new BoardVO();
		pBoard.setUsrMnum(currUserNum);
		List<FollowVO> followTo = followService.flwSelectAllNum(pBoard);
		List<FollowVO> followFrom = followService.flwSelectAllMbrNum(pMember);

		//팔로우 수
		Map<String, Integer> followMap = new HashMap<>();
		followMap.put("followToCnt",followTo.size() == 0 ? 0 : getFollowCnt(followTo));
		followMap.put("followFromCnt",followFrom.size() == 0 ? 0 : getFollowCnt(followFrom));

		//좋아요 목록 및 좋아요 수
		int favorCnt = 0;
		if(favor.size() != 0){
			favorCnt = favor.get(0).getCnt();
		}
		Map<String, Object> favorMap = new HashMap<>();
		favorMap.put("favor", favor);
		favorMap.put("favorCnt", favorCnt);

		model.addAttribute("memberModel", member);
		model.addAttribute("followMap", followMap);
		model.addAttribute("favorMap", favorMap);
		model.addAttribute("myBoardModel", myBoard);
		model.addAttribute("myFavorBoardModel", myFavorBoard);

		return "myPage/myPageProfileMain";
	}

	@RequestMapping(value = "/myPage/user/{num}/myBoard", method = RequestMethod.GET)
	public String myPageProfileMyBoard(@PathVariable("num") int num, Model model, MemberVO pMember, HttpSession session) throws IOException {
		log.info("myPageProfileMyBoard ==> {}", pMember);

		//logged in user_number
		int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

		//DB Connection
		MemberVO member = memberService.mSelectOneUserProfile(pMember);
		List<BoardVO> myBoard = boardService.bSelectMyBoard(pMember);
		List<FavorVO> favor = favorService.fvSelectAllFromMbr(pMember);
		BoardVO pBoard = new BoardVO();
		pBoard.setUsrMnum(currUserNum);
		List<FollowVO> followTo = followService.flwSelectAllNum(pBoard);
		List<FollowVO> followFrom = followService.flwSelectAllMbrNum(pMember);

		//팔로우 수
		Map<String, Integer> followMap = new HashMap<>();
		followMap.put("followToCnt",followTo.size() == 0 ? 0 : getFollowCnt(followTo));
		followMap.put("followFromCnt",followFrom.size() == 0 ? 0 : getFollowCnt(followFrom));

		//좋아요 목록 및 좋아요 수
		int favorCnt = 0;
		if(favor.size() != 0){
			favorCnt = favor.get(0).getCnt();
		}
		Map<String, Object> favorMap = new HashMap<>();
		favorMap.put("favor", favor);
		favorMap.put("favorCnt", favorCnt);

		model.addAttribute("memberModel", member);
		model.addAttribute("followMap", followMap);
		model.addAttribute("favorMap", favorMap);
		model.addAttribute("myBoardModel", myBoard);

		return "myPage/myPageProfileMyBoard";
	}

	@RequestMapping(value = "/myPage/user/{num}/myFavor", method = RequestMethod.GET)
	public String myPageProfileMyFavor(@PathVariable("num") int num, Model model, MemberVO pMember, HttpSession session) throws IOException {
		log.info("myPageProfileMyFavor ==> {}", pMember);

		//logged in user_number
		int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

		//DB Connection
		MemberVO member = memberService.mSelectOneUserProfile(pMember);
		List<BoardVO> myFavorBoard = boardService.bSelectFavorBoard(pMember);
		List<FavorVO> favor = favorService.fvSelectAllFromMbr(pMember);
		BoardVO pBoard = new BoardVO();
		pBoard.setUsrMnum(currUserNum);
		List<FollowVO> followTo = followService.flwSelectAllNum(pBoard);
		List<FollowVO> followFrom = followService.flwSelectAllMbrNum(pMember);

		//팔로우 수
		Map<String, Integer> followMap = new HashMap<>();
		followMap.put("followToCnt",followTo.size() == 0 ? 0 : getFollowCnt(followTo));
		followMap.put("followFromCnt",followFrom.size() == 0 ? 0 : getFollowCnt(followFrom));

		//좋아요 목록 및 좋아요 수
		int favorCnt = 0;
		if(favor.size() != 0){
			favorCnt = favor.get(0).getCnt();
		}
		Map<String, Object> favorMap = new HashMap<>();
		favorMap.put("favor", favor);
		favorMap.put("favorCnt", favorCnt);

		model.addAttribute("memberModel", member);
		model.addAttribute("followMap", followMap);
		model.addAttribute("favorMap", favorMap);
		model.addAttribute("myFavorBoardModel", myFavorBoard);

		return "myPage/myPageProfileMyFavor";
	}

	@RequestMapping(value = "/myPage/user/{num}/myFollow", method = RequestMethod.GET)
	public String myPageProfileMyFollow(@PathVariable("num") int num, Model model, MemberVO pMember, HttpSession session) throws IOException {
		log.info("myPageProfileMyFollow ==> {}", pMember);

		//logged in user_number
		int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

		//DB Connection
		MemberVO member = memberService.mSelectOneUserProfile(pMember);
		List<FavorVO> favor = favorService.fvSelectAllFromMbr(pMember);
		BoardVO pBoard = new BoardVO();
		pBoard.setUsrMnum(currUserNum);
		List<FollowVO> followTo = followService.flwSelectAllNum(pBoard);
		List<FollowVO> followFrom = followService.flwSelectAllMbrNum(pMember);

		//팔로우 수
		Map<String, Object> followMap = new HashMap<>();
		followMap.put("followToCnt",followTo.size() == 0 ? 0 : getFollowCnt(followTo));
		followMap.put("followFromCnt",followFrom.size() == 0 ? 0 : getFollowCnt(followFrom));
		followMap.put("followTo", followTo);
		followMap.put("followFrom", followFrom);

		//좋아요 목록 및 좋아요 수
		int favorCnt = 0;
		if(favor.size() != 0){
			favorCnt = favor.get(0).getCnt();
		}
		Map<String, Object> favorMap = new HashMap<>();
		favorMap.put("favor", favor);
		favorMap.put("favorCnt", favorCnt);

		model.addAttribute("memberModel", member);
		model.addAttribute("followMap", followMap);
		model.addAttribute("favorMap", favorMap);

		return "myPage/myPageProfileMyFollow";
	}

	private int getFollowCnt(List<FollowVO> followList) {
		int cnt = 0;

		if(followList != null){
			cnt = followList.get(0).getCnt();
		}

		return cnt;
	}

}
