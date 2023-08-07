package test.com.todayhome.mapper;

import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FollowVO;
import test.com.todayhome.model.MemberVO;

import java.util.List;

public interface FollowDAO {

	List<FollowVO> flwSelectAllNum(BoardVO pBoard);

	List<FollowVO> flwSelectAllMbrNum(MemberVO pMember);

	FollowVO flwCheck(BoardVO pBoard);

	int flwClickInsert(BoardVO board);

	int flwClickDelete(BoardVO board);

    void deleteFollowWithDeleteMember(MemberVO vo);
}
