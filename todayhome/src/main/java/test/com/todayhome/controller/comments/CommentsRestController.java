package test.com.todayhome.controller.comments;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.CommentsVO;
import test.com.todayhome.service.BoardService;
import test.com.todayhome.service.CommentsService;

@Controller
@Slf4j
public class CommentsRestController {

	@Autowired
	CommentsService commentsService;

	@Autowired
	BoardService boardService;

	// 댓글 등록
	@ResponseBody
	@RequestMapping(value = "/bSelectOne/addcomments", method = RequestMethod.GET)
	public Map addCommentsList(CommentsVO vo) {
		log.info("/comments...brdNum:{}", vo);
		int result = commentsService.addComment(vo);

		log.info("voGetCnt:{}",vo.getCnt());
		Map<String, Object> map = new HashMap<>();
		map.put("cnt", vo.getCnt());

		if (result == 1) {
			map.put("result", "댓글이 등록되었습니다.");
			return map;
		} else {
			map.put("result", "댓글이 실패했습니다.");
			return map;
		}
	}
	
	// 댓글 목록
	@ResponseBody
	@RequestMapping(value = "/bSelectOne/getcomments", method = RequestMethod.GET)
	public List<CommentsVO> getcomments(CommentsVO vo) {
		log.info("/getcomments...brdNum:{}", vo);
		
		List<CommentsVO> vos = commentsService.getCommentsList(vo);
		
		return vos;
	}

	// 댓글 수정
	@ResponseBody
	@RequestMapping(value = "/bSelectOne/updatecomments", method = RequestMethod.GET)
	public String updateCommentsList(CommentsVO vo) {
		log.info("/comments...brdNum:{}", vo);
		int result = commentsService.updateComment(vo);
		if (result == 1) {
			return "{\"result\":\"댓글이 수정되었습니다.\"}";
		} else {
			return "{\"result\":\"댓글 수정에 실패했습니다.\"}";
		}
	}

	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/bSelectOne/deletecomments", method = RequestMethod.GET)
	public Map deleteCommentsList(CommentsVO vo) {
		log.info("/deleteCommentsList...num:{}", vo);
		int result = commentsService.deleteComment(vo);

		log.info("Hi:{}",vo.getNum());
		log.info("Bye:{}",vo.getBrdNum());

		BoardVO brd = new BoardVO();
		brd.setNum(vo.getBrdNum());
		List<CommentsVO> cmt = commentsService.bcSelectAll(brd);
		int cnt = 0;
		cnt = cmt.size()==0 ? 0 : cmt.get(0).getCnt();

		Map<String, Object> map = new HashMap<>();
		map.put("cnt", cnt);

		if (result == 1) {
			map.put("result", "댓글이 삭제되었습니다.");
			return map;
		} else {
			map.put("result", "댓글 삭제에 실패했습니다.");
			return map;
		}
	}

}
// -----------------------------------------------------------
//	@RequestMapping(value = "/{brdNum}/addcomment", method = RequestMethod.POST)
//	public ResponseEntity<String> addComment(@RequestBody CommentsVO content) {
//		int result = commentsService.addComment(content);
//		if (result == 1) {
//			return new ResponseEntity<>("댓글이 등록되었습니다.", HttpStatus.OK);
//		} else {
//			return new ResponseEntity<>("댓글 등록에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//
//	@RequestMapping(value = "/{brdNum}/updatecomment", method = RequestMethod.PUT)
//	public ResponseEntity<String> updateComment(@RequestBody CommentsVO content) {
//		int result = commentsService.updateComment(content);
//		if (result == 1) {
//			return new ResponseEntity<>("댓글이 수정되었습니다.", HttpStatus.OK);
//		} else {
//			return new ResponseEntity<>("댓글 수정에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//
//	@RequestMapping(value = "/deletecomment/{num}", method = RequestMethod.DELETE)
//	public ResponseEntity<String> deleteComment(@PathVariable int num) {
//		int result = commentsService.deleteComment(num);
//		if (result == 1) {
//			return new ResponseEntity<>("댓글이 삭제되었습니다.", HttpStatus.OK);
//		} else {
//			return new ResponseEntity<>("댓글 삭제에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}