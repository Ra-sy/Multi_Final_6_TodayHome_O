package test.com.todayhome.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.CommentsVO;
import test.com.todayhome.model.MemberVO;

@Repository
@Slf4j
public class CommentsDAOimpl implements CommentsDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CommentsVO> getCommentsList(CommentsVO vo) {
		log.info("getCommentsList()...{}",vo);
		return sqlSession.selectList("getcommentList", vo);
	}

	@Override
	public int addComment(CommentsVO vo) {
		log.info("addComment()...{}",vo);
		return sqlSession.insert("addComment", vo);
	}

	@Override
	public int updateComment(CommentsVO vo) {
		log.info("updateComment()...{}",vo);
		return sqlSession.update("updateComment", vo);
	}

	@Override
	public int deleteComment(CommentsVO vo) {
		log.info("deleteComment()...{}",vo);
		return sqlSession.delete("deleteComment", vo);
	}
//---------------------
	@Override
	public List<CommentsVO> bcSelectAll(BoardVO pBoard) {
		return sqlSession.selectList("bcSelectAll", pBoard);
	}

	@Override
	public void deleteCommentsWithDeleteMember(MemberVO vo) {
		sqlSession.delete("deleteCommentsWithDeleteMember", vo);
	}

	@Override
	public void cmtDeleteBoardDelete(BoardVO board) {
		sqlSession.delete("cmtDeleteBoardDelete", board);
	}
}
