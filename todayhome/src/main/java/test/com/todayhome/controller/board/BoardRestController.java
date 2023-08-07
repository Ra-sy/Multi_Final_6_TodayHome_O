package test.com.todayhome.controller.board;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.CommentsVO;
import test.com.todayhome.model.FavorVO;
import test.com.todayhome.model.FollowVO;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.BoardService;
import test.com.todayhome.service.CommentsService;
import test.com.todayhome.service.FavorService;
import test.com.todayhome.service.FollowService;
import test.com.todayhome.service.MemberService;

@Slf4j
@Controller
public class BoardRestController {


	@Autowired
	private BoardService boardService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CommentsService commentsService;

	@Autowired
	private FollowService followService;

	@Autowired
	private FavorService favorService;

	@Autowired
	private ServletContext sContext;

	private static final String RESULT_KEY = "result";

	@RequestMapping(value = "/bSelectOne/{num}", method = RequestMethod.GET)
	public String bSelectOne(@PathVariable("num") int num, HttpSession session,Model model, BoardVO pBoard) throws IOException {
		log.info("bSelectOne ==> {}", pBoard);

		//logged in user_number
		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));
		pBoard.setUsrMnum(currUserNum);

		//DB Connection
		BoardVO board = boardService.bSelectOne(pBoard);

		if(board == null){
			return "notFound";
		}

		board.setUsrMnum(currUserNum);
		boardService.bViewCountUpdate(pBoard);
		List<CommentsVO> comments = commentsService.bcSelectAll(pBoard);
		List<FollowVO> follow = followService.flwSelectAllNum(pBoard);
		List<FavorVO> favor = favorService.fvSelectAll(pBoard);

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);
		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);


		//팔로우 여부
		String followYn = getFollowYn(follow, board); //followYn

		//좋아요 여부 및 좋아요 수
		Map<String, Object> favorMap = getFavorYnCnt(favor, board); //favorYn, favorCnt

		//댓글 및 댓글 수
		Map<String, Object> commentsMap = new HashMap<>();
		int commentsCnt = 0;
		if(comments.size() != 0){
			commentsCnt = comments.get(0).getCnt();
		}
		commentsMap.put("comments", comments);
		commentsMap.put("commentsCnt", commentsCnt);

		//작성 경과 시간 표시
		String elapsedTimestampString = calcElapsed(board);


		model.addAttribute("currMbr", currMbr);
		model.addAttribute("boardModel", board);
		model.addAttribute("commentsMap", commentsMap);
		model.addAttribute("followYn", followYn);
		model.addAttribute("favorMap", favorMap);
		model.addAttribute("elapsedTime", elapsedTimestampString);

		if(board.getBoardNo() >= 1 && board.getBoardNo() <= 4){
			return "board/selectOne";
		}
		else{
			return "notFound";
		}
	}

	@RequestMapping(value = "/bSelectAll", method = RequestMethod.GET)
	public String bSelectAll(Model model, HttpServletRequest request, HttpSession session, BoardVO pBoard) {
		log.info("/bSelectAll");

		String user_id = (String) session.getAttribute("user_id");
		log.info("session user_id: "+ user_id);
		int memberId = 0;
		if(user_id != null){
			memberId = Integer.parseInt(user_id);
		}
		pBoard.setUsrMnum(memberId);	//회원번호
		List<BoardVO> boardList = boardService.bSelectAll(pBoard);

		model.addAttribute("boardList",boardList);
		model.addAttribute("usrMnum",memberId);

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		BoardVO vo2 = new BoardVO();
		model.addAttribute("vo2",vo2);

		return "board/selectAll";
	}

	//교집합 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/bJsonSelectIntersection", method = RequestMethod.GET)
	public List<BoardVO> bJsonSelectIntersection(String sortKey, HttpSession session, String typeKey, String familytypeKey, String workingareaKey, String workerKey) {
		log.info("/bJsonSelectIntersection()....");
		log.info("sortKey:{}",sortKey);
		log.info("typeKey:{},familytypeKey:{}",typeKey,familytypeKey);
		log.info("workingareaKey:{},workerKey:{}",workingareaKey,workerKey);

		// null인 경우에 대한 처리
//	    sortKey = (sortKey == null) ? "" : sortKey;
//	    typeKey = (typeKey == null) ? "" : typeKey;
//	    familytypeKey = (familytypeKey == null) ? "" : familytypeKey;
//	    workingareaKey = (workingareaKey == null) ? "" : workingareaKey;
//	    workerKey = (workerKey == null) ? "" : workerKey;

		//logged in user_number
		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		BoardVO vo = new BoardVO();
		vo.setUsrMnum(currUserNum);
		List<BoardVO> vos = boardService.selectIntersection(vo,sortKey, typeKey, familytypeKey, workingareaKey, workerKey);

		return vos;
	}

	@RequestMapping(value = "/bUpdate/{num}", method = RequestMethod.GET)
	public String bUpdate(@PathVariable("num") int num, Model model, BoardVO pBoard) {
		log.info("bUpdate");

		BoardVO board = boardService.bSelectOne(pBoard);

		model.addAttribute("board", board);

		return "board/update";
	}

	@RequestMapping(value = "/topics/living", method = RequestMethod.GET)
	public String living(Model model, HttpSession session,BoardVO pBoard) {
		log.info("/topics/living...");
		
		String user_id = (String) session.getAttribute("user_id");
		log.info("session user_id: "+ user_id);
		int memberId = 0;
		if(user_id != null){
			memberId = Integer.parseInt(user_id);
		}
		pBoard.setUsrMnum(memberId);	//회원번호
		List<BoardVO> boardList = boardService.bSelectAll(pBoard);

		model.addAttribute("boardList",boardList);
		model.addAttribute("usrMnum",memberId);

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		BoardVO vo2 = new BoardVO();
		model.addAttribute("vo2",vo2);

		return "board/living";
	}
	//교집합 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/bJsonSelect2", method = RequestMethod.GET)
	public List<BoardVO> bJsonSelect2(HttpSession session, String sortKey, String livingKey) {
		log.info("/bJsonSelect2()....");
		log.info("sortKey:{},livingKey:{}",sortKey,livingKey);

		
		//logged in user_number
		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		BoardVO vo = new BoardVO();
		vo.setUsrMnum(currUserNum);
		List<BoardVO> vos = boardService.select2(vo, sortKey, livingKey);
		
		return vos;
	}

	//	홈스토랑
	@RequestMapping(value = "/topics/cook", method = RequestMethod.GET)
	public String cook(Model model, HttpSession session,BoardVO pBoard) {
		log.info("/topics/cook...");

		String user_id = (String) session.getAttribute("user_id");
		log.info("session user_id: "+ user_id);
		int memberId = 0;
		if(user_id != null){
			memberId = Integer.parseInt(user_id);
		}
		pBoard.setUsrMnum(memberId);	//회원번호
		List<BoardVO> boardList = boardService.bSelectAll(pBoard);

		model.addAttribute("boardList",boardList);
		model.addAttribute("usrMnum",memberId);

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		BoardVO vo2 = new BoardVO();
		model.addAttribute("vo2",vo2);

		return "board/cook";
	}
	//교집합 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/bJsonSelect3", method = RequestMethod.GET)
	public List<BoardVO> bJsonSelect3(HttpSession session,String sortKey, String cookKey) {
		log.info("/bJsonSelect3()....");
		log.info("sortKey:{},cookKey:{}",sortKey,cookKey);

		//logged in user_number
		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		BoardVO vo = new BoardVO();
		vo.setUsrMnum(currUserNum);
		List<BoardVO> vos = boardService.select3(vo,sortKey, cookKey);

		return vos;
	}

	//	취미일상
	@RequestMapping(value = "/topics/dailylife", method = RequestMethod.GET)
	public String dailylife(Model model, HttpSession session,BoardVO pBoard) {
		log.info("/topics/dailylife...");

		String user_id = (String) session.getAttribute("user_id");
		log.info("session user_id: "+ user_id);
		int memberId = 0;
		if(user_id != null){
			memberId = Integer.parseInt(user_id);
		}
		pBoard.setUsrMnum(memberId);	//회원번호
		List<BoardVO> boardList = boardService.bSelectAll(pBoard);

		model.addAttribute("boardList",boardList);
		model.addAttribute("usrMnum",memberId);

		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		MemberVO pMember =  new MemberVO();
		pMember.setNum(currUserNum);

		MemberVO currMbr = memberService.mSelectOneUserProfile(pMember);
		model.addAttribute("currMbr", currMbr);

		BoardVO vo2 = new BoardVO();
		model.addAttribute("vo2",vo2);

		return "board/dailylife";
	}
	//교집합 데이터 출력
	@ResponseBody
	@RequestMapping(value = "/bJsonSelect4", method = RequestMethod.GET)
	public List<BoardVO> bJsonSelect4(HttpSession session,String sortKey, String dailyKey) {
		log.info("/bJsonSelect4()....");
		log.info("sortKey:{},dailyKey:{}",sortKey,dailyKey);

		//logged in user_number
		Object flag = session.getAttribute("user_id");
		int currUserNum = flag == null ? 0 : Integer.parseInt(String.valueOf(flag));

		BoardVO vo = new BoardVO();
		vo.setUsrMnum(currUserNum);
		List<BoardVO> vos = boardService.select4(vo,sortKey, dailyKey);

		return vos;
	}

	@RequestMapping(value = "/bJsonUpdate", method = RequestMethod.POST)
	public String bJsonUpdate(BoardVO board) throws IllegalStateException, IOException {
		log.info("bJsonUpdate");

		String getOriginalFilename = board.getThumbFile().getOriginalFilename();
		int fileNameLength = board.getThumbFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() != 0) {

			board.setImgThumb(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath, board.getImgThumb());
			board.getThumbFile().transferTo(f);

			/*BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);

			File thumb_file = new File(realPath + "/thumb_" + board.getImgThumb());
			String formatName = board.getImgThumb().substring(board.getImgThumb().lastIndexOf(".") + 1);

			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);*/

		} else {
			board.setImgThumb("default.png");
		}

		int result = boardService.bUpdate(board);
		StringBuilder sb = new StringBuilder();

		if(result==1) {
			return "redirect:"+sb.append("/bSelectOne/").append(board.getNum());
		}
		else {
			return "redirect:"+sb.append("/bUpdate/").append(board.getNum());
		}
	}

	@RequestMapping(value = "/bJsonDelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> bJsonDelete(@RequestBody BoardVO board) {
		log.info("bJsonDelete");

		commentsService.cmtDeleteBoardDelete(board);
		favorService.fvDeleteBoardDelete(board);
		int result = boardService.bDelete(board);

		StringBuilder sb = new StringBuilder();
		Map<String, Object> map = new HashMap<>();

		if(result==1) {
			sb.append("/bSelectAll");
			map.put(RESULT_KEY, result);
			map.put("url", sb.toString());
			return map;
		}
		else {
			sb.append("/bSelectOne/").append(board.getNum());
			map.put(RESULT_KEY, result);
			map.put("url", sb.toString());
			return map;
		}

	}

	@RequestMapping(value = "/bJsonSelectOneFvClick", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> bJsonSelectOneFvClick(@RequestBody BoardVO pBoard) {
		log.info("bJsonSelectOneFvClick ==> {}", pBoard);

		FavorVO favor = favorService.fvCheck(pBoard);

		if(favor == null){
			favorService.fvClickInsert(pBoard);
		}
		else{
			favorService.fvClickDelete(pBoard);
		}

		List<FavorVO> favorList = favorService.fvSelectAll(pBoard);

		Map<String, Object> favorMap = getFavorYnCnt(favorList, pBoard);

		return favorMap;
	}

	@RequestMapping(value = "/bJsonSelectOneFlwClick", method = RequestMethod.POST)
	@ResponseBody
	public String bJsonSelectOneFlwClick(@RequestBody BoardVO pBoard) {
		log.info("bJsonSelectOneFlwClick ==> {}", pBoard);

		FollowVO follow = followService.flwCheck(pBoard);

		if (follow == null) {
			followService.flwClickInsert(pBoard);
		} else {
			followService.flwClickDelete(pBoard);
		}

		return follow == null ? "Y" : "N";
	}

	@RequestMapping(value = "/bInsertOK", method = RequestMethod.POST)
	public String bInsertOK(BoardVO vo) throws IllegalStateException, IOException {
		log.info("/bInsertOK...{}", vo);

		String getOriginalFilename = vo.getThumbFile().getOriginalFilename();
		int fileNameLength = vo.getThumbFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() != 0) {

			vo.setImgThumb(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath, vo.getImgThumb());
			log.info(f.toString());
			vo.getThumbFile().transferTo(f);

			/*//// create thumbnail image/////////
			BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);

			File thumb_file = new File(realPath + "/thumb_" + vo.getImgThumb());
			String formatName = vo.getImgThumb().substring(vo.getImgThumb().lastIndexOf(".") + 1);

			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);*/

		} else {
			vo.setImgThumb("default.png");
		}
		log.info("{}", vo);

		int result = boardService.insert(vo);
		log.info("result:{}", result);
		log.info("getSeqNxtVal:{}", vo.getSeqNxtVal());

		return "redirect:bSelectOne/"+vo.getSeqNxtVal();
	}
	@RequestMapping(value = "/bInsertCKEditor", method = RequestMethod.POST)
	public void bInsertCKEditor(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {

		OutputStream out = null;
		PrintWriter printWriter = null;

		// 클라이언트의 브라우저에게 보내는 정보
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");

		try {
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 업로드한 원본파일명
			byte[] bytes = upload.getBytes(); // 업로드 파일

			String uploadPath = req.getSession().getServletContext().getRealPath("/") + "resources/uploadimg/";
			log.info("톰캣 물리적 경로 : " + uploadPath);

			uploadPath = uploadPath + fileName;

			out = new FileOutputStream(new File(uploadPath)); // 파일입출력스트림 객체생성(실제폴더에 파일생성됨)
			out.write(bytes); // 출력스트림에 업로드된 파일을 가르키는 바이트배열을 쓴다. 업로드된 파일크기

			printWriter = res.getWriter();

			String fileUrl = "../../../resources/uploadimg/" + fileName; // 톰캣의 server.xml에 설정정보 참고

			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				} catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}

	}

	@RequestMapping(value = "/json_b_random", method = RequestMethod.GET)
	@ResponseBody
	public BoardVO json_b_random(BoardVO vo, Model model) {
		log.info("/json_b_random...vo: {}",vo);
		//selectAll, searchList
		List<BoardVO> boardList = boardService.bSelectAllForRandom();

		BoardVO vo2 = boardList.size() == 0 ? new BoardVO() : boardList.get(0);

		return vo2;
	}

	@RequestMapping(value = "/json_b_views", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> json_b_views() {
		log.info("/json_b_views...");
		//selectAll, searchList
		List<BoardVO> vos = boardService.views();
		//log.info("vos.size():{}", vos.size());

		return vos;
	}
	@RequestMapping(value = "/json_b_viewsFree", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> json_b_viewsFree() {
		log.info("/json_b_viewsFree...");
		//selectAll, searchList
		List<BoardVO> vos = boardService.viewsFree();
		//log.info("vos.size():{}", vos.size());

		return vos;
	}
	@RequestMapping(value = "/json_b_views2", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> json_b_views2() {
		log.info("/json_b_views2...");
		//selectAll, searchList
		List<BoardVO> vos = boardService.views2();
		//log.info("vos.size():{}", vos.size());

		return vos;
	}
	@RequestMapping(value = "/json_b_viewsFree2", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> json_b_viewsFree2() {
		log.info("/json_b_viewsFree2...");
		//selectAll, searchList
		List<BoardVO> vos = boardService.viewsFree2();
		//log.info("vos.size():{}", vos.size());

		return vos;
	}

	//=========================================

	private String getFollowYn(List<FollowVO> followList, BoardVO board) {
		String followYn = "N";

		for (FollowVO f : followList) {
			if (f.getMbrNum() == board.getBrdMnum() && f.getNum() == board.getUsrMnum()) {
				followYn = "Y";
			}
		}
		return followYn;
	}

	private Map<String, Object> getFavorYnCnt(List<FavorVO> favorList, BoardVO board){
		String favorYn = "N";
		int favorCnt = 0;

		for(FavorVO f : favorList){
			if (f.getMyMbrNum() != 0 && f.getMyMbrNum() == board.getUsrMnum()){
				favorYn = "Y";
			}
		}

		if(favorList.size() != 0){
			favorCnt = favorList.get(0).getCnt();
		}

		Map<String, Object> map = new HashMap<>();
		map.put("favorYn", favorYn);
		map.put("favorCnt", favorCnt);

		return map;
	}

	private String calcElapsed(BoardVO board) {
		long currTimestamp = System.currentTimeMillis();
		long boardTimestamp = board.getWdate().getTime();
		long elapsed = currTimestamp - boardTimestamp;

		long msgTime = 0;

		if(elapsed/1000 < 60){
			msgTime = elapsed/1000;

			return msgTime+"초 전";
		}
		else if(elapsed/60000 < 60){
			msgTime = elapsed/60000;

			return msgTime+"분 전";
		}
		else if(elapsed/3600000 < 24){
			msgTime = elapsed/3600000;

			return msgTime+"시간 전";
		}
		else if(elapsed/86400000 >= 1){
			msgTime = elapsed/86400000;

			if(msgTime > 30 && msgTime <= 365){
				msgTime /= 30;

				return msgTime+"개월 전";
			}
			else if(msgTime > 365){
				msgTime /= 365;

				return msgTime+"년 전";
			}
			else{
				return msgTime+"일 전";
			}
		}
		else{
			return "알 수 없음 시간 전";
		}
	}
}



