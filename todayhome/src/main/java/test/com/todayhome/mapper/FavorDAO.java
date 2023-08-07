package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FavorVO;
import test.com.todayhome.model.MemberVO;

public interface FavorDAO {

	List<FavorVO> fvSelectAll(BoardVO pBoard);

	FavorVO fvCheck(BoardVO pBoard);

	int fvClickInsert(BoardVO board);

	int fvClickDelete(BoardVO board);

	List<FavorVO> fvSelectAllFromMbr(MemberVO pMember);

	void fvDeleteBoardDelete(BoardVO board);

    void deleteFavorWithDeleteMember(MemberVO vo);
}
