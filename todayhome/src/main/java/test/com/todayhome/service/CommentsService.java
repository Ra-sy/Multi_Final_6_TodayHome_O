package test.com.todayhome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.todayhome.mapper.CommentsDAO;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.CommentsVO;
import test.com.todayhome.model.MemberVO;

import java.util.List;

@Service
public class CommentsService {

	@Autowired
	CommentsDAO dao;

	public List<CommentsVO> getCommentsList(CommentsVO vo) {
		return dao.getCommentsList(vo);
	}

	public int addComment(CommentsVO vo) {
		return dao.addComment(vo);
	}

	public int updateComment(CommentsVO vo){
		return dao.updateComment(vo);
	}
	public int deleteComment(CommentsVO vo){
		return dao.deleteComment(vo);
	}

	public List<CommentsVO> bcSelectAll(BoardVO pBoard){
		return dao.bcSelectAll(pBoard);
	}

    public void deleteCommentsWithDeleteMember(MemberVO vo) {
		dao.deleteCommentsWithDeleteMember(vo);
    }

	public void cmtDeleteBoardDelete(BoardVO board) {
		dao.cmtDeleteBoardDelete(board);
	}
}
