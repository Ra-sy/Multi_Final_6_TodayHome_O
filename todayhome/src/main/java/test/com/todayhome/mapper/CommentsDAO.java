package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.CommentsVO;
import test.com.todayhome.model.MemberVO;

public interface CommentsDAO {

	List<CommentsVO> getCommentsList(CommentsVO vo);

	int addComment(CommentsVO vo);

	int updateComment(CommentsVO vo);

	int deleteComment(CommentsVO vo);

	List<CommentsVO> bcSelectAll(BoardVO pBoard);

    void deleteCommentsWithDeleteMember(MemberVO vo);

    void cmtDeleteBoardDelete(BoardVO board);
}
