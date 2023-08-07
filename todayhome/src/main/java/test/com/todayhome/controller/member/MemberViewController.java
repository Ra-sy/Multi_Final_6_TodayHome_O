package test.com.todayhome.controller.member;

import java.io.File;
import java.io.IOException;
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
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.*;

@Slf4j
@Controller
public class MemberViewController {
	
	@Autowired
	MemberService memberService;

	@Autowired
	CommentsService commentsService;

	@Autowired
	FavorService favorService;

	@Autowired
	FollowService followService;

	@Autowired
	BoardService boardService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	ServletContext sContext;
	
	@RequestMapping(value = "/findpw", method = RequestMethod.GET)
	public String findpw(MemberVO vo, Model model) {
		log.info("findpw...");

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		return "member/findpw";
	}
	
	@RequestMapping(value = "/pwUpdate/{num}", method = RequestMethod.GET)
	public String pwUpdate(@PathVariable("num") int num, MemberVO vo, Model model) {
	    log.info("pwUpdate...vo:{}", vo);

	    MemberVO vo2 = memberService.selectOne(vo);
	    log.info(vo2.toString());

	    model.addAttribute("vo2", vo2);

	    return "member/pwUpdate";
	}
	
	@RequestMapping(value = "/pwUpdateOK", method = RequestMethod.POST)
	public String pwUpdateOK(MemberVO vo, HttpServletRequest request) {	//request를 해줘야 POST한 값을 받아올 수 있음
		log.info("pwUpdateOK...vo:{}", vo);	//vo에 값을 가져오려면 jsp파일의 input태그안에 name=""이 MemberVO와 같아야 함
		
		int result = memberService.pwUpdate(vo);
		log.info("result: {}",result);
		if(result==1) {
			return "redirect:login";
		}else {
			return "redirect:pwUpdate/"+vo.getNum();
		}
		
		
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(String message,Model model) {
		log.info("/login....{}",message);
		
		if(message!=null) message = "이메일 주소나 비밀번호가 틀립니다.";
		model.addAttribute("message", message);
		
		return "member/login";

	}
	
	@RequestMapping(value = "/loginOK", method = RequestMethod.POST)
	public String loginOK(MemberVO vo, String email, String pw, HttpSession session) {
		log.info("/loginOK....vo:{}", vo);
		log.info("email:{},pw:{}",email,pw);
		
		MemberVO vo2 = memberService.login(vo);
		log.info("vo2", vo2);
		
		if(vo2 == null) {
			return "redirect:login?message=fail";
		}else {
	        session.setAttribute("user_id", String.valueOf(vo2.getNum()));	        
	        return "redirect:/"; 
		}    
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		log.info("/logout");
		
		session.invalidate();

		return "redirect:/";
	}
	
	
	
	@RequestMapping(value = "/mSelectAll", method = RequestMethod.GET)
	public String mSelectAll() {
		log.info("m_selectAll()...");

		return "member/selectAll";
	}
	
	@RequestMapping(value = "/mSelectOne", method = RequestMethod.GET)
	public String mSelectOne(MemberVO vo,Model model) {
		log.info("m_selectOne()...");
		log.info("{}",vo);

		return "member/selectOne";
	}
	
	@RequestMapping(value = "/pwCheck/{num}", method = RequestMethod.GET)
	public String pwCheck(@PathVariable("num") int num,String email, String pw, MemberVO vo, Model model) {
		log.info("pwCheck...vo:{}", vo);

		MemberVO vo2 = memberService.mSelectOne(vo);
		log.info(vo2.toString());

		model.addAttribute("vo2", vo2);

		return "member/pwCheck";
	}
	
	@RequestMapping(value = "/mUpdate/{num}", method = RequestMethod.GET)
	public String mUpdate(@PathVariable("num") int num,MemberVO vo, Model model) {
		log.info("mUpdate...vo:{}",vo);

		MemberVO vo2 = memberService.mSelectOne(vo);
		log.info(vo2.toString());

		model.addAttribute("vo2",vo2);

		return "member/update";
	}

	@RequestMapping(value = "/mUpdateOK", method = RequestMethod.POST)
	public String mUpdateOK(MemberVO vo) throws IllegalStateException, IOException {
	    log.info("mupdateOK");
	    log.info("{}", vo);

		String getOriginalFilename = vo.getImgFile().getOriginalFilename();
		int fileNameLength = vo.getImgFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

	    if (getOriginalFilename.length() != 0) {
			vo.setImg(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath, vo.getImg());
			vo.getImgFile().transferTo(f);
			
	    } else {
	        // 파일이 업로드되지 않은 경우 기본 이미지 설정
	        vo.setImg("default-profile.png");
	    }

	    int result = memberService.mUpdate(vo);
	    log.info("updateOK_result = {}", result);

	    if (result == 1) {
	        return "redirect:/myPage/user/" + vo.getNum();
	    } else {
	        return "redirect:/mUpdate/" + vo.getNum();
	    }
	}

	@RequestMapping(value = "/myPage/user/{num}/mDeleteOK", method = RequestMethod.GET)
	public String mDeleteOK(@PathVariable("num") int num, MemberVO vo, HttpSession session) {
		log.info("/mDeleteOK");
		log.info("{}",vo);

		favorService.deleteFavorWithDeleteMember(vo);
		followService.deleteFollowWithDeleteMember(vo);
		commentsService.deleteCommentsWithDeleteMember(vo);

		List<BoardVO> boardList = boardService.bSelectMyBoard(vo);
		if(boardList.size() != 0){
			for ( BoardVO board : boardList) {
				commentsService.cmtDeleteBoardDelete(board);
				favorService.fvDeleteBoardDelete(board);
				int result = boardService.bDelete(board);
			}
		}

		int result = memberService.mDelete(vo);
		log.info("result:{}",result);

		if(result==1){
			session.invalidate();
			return "redirect:/";
		}
		else
			return "redirect:myPage/user/" + num + "/mUpdate/" + num;
	}
	
	@RequestMapping(value = "/mInsert", method = RequestMethod.GET)
	public String mInsert() {
		log.info("/mInsert");
		return "member/insert";
	}
	
	@RequestMapping(value = "/mInsertOK", method = RequestMethod.POST)
	public String mInsertOK(MemberVO vo) {
		log.info("mInsertOK...{}",vo);
		
		int result = memberService.insert(vo);
		log.info("result : {}",result);	//{}가 result로 대체됨
		if(result==1) {
			session.setAttribute("user_id", String.valueOf(vo.getSeqNxtVal()));
			return "redirect:/";
		}else {
			return "redirect:/mInsert";
		}
		
	}//end m_insertOK
}
