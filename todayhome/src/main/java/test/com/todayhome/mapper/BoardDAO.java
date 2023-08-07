package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.MemberVO;

public interface BoardDAO {

	BoardVO bSelectOne(BoardVO pBoard);

	int bUpdate(BoardVO board);

	int bDelete(BoardVO board);

	void bViewCountUpdate(BoardVO pBoard);

	List<BoardVO> bSelectMyBoard(MemberVO pMember);

	List<BoardVO> bSelectFavorBoard(MemberVO pMember);

	public List<BoardVO> selectIntersection(BoardVO vo, String sortKey, String typeKey, String familytypeKey, String workingareaKey,String workerKey);
	public List<BoardVO> select2(BoardVO vo,String sortKey, String livingKey);
	public List<BoardVO> select3(BoardVO vo,String sortKey, String cookKey);
	public List<BoardVO> select4(BoardVO vo,String sortKey, String dailyKey);

	int insert(BoardVO vo);
	List<BoardVO> views();
	List<BoardVO> views2();
	List<BoardVO> viewsFree();
	List<BoardVO> viewsFree2();
	BoardVO random(BoardVO vo);

	List<BoardVO> bSelectAll(BoardVO pBoard);
	
	public List<BoardVO> searchList(String searchKey, String searchWord);

	List<BoardVO> bSelectAllForRandom();

    void deleteBoardWithDeleteMember(MemberVO vo);
}
