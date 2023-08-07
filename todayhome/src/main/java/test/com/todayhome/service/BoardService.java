package test.com.todayhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.mapper.BoardDAO;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.MemberVO;

@Service
@Slf4j
public class BoardService {

	@Autowired
	private BoardDAO dao;

	public BoardVO bSelectOne(BoardVO pBoard) {
		log.info("BoardService_bSelectOne");

		return dao.bSelectOne(pBoard);
	}

	public int bUpdate(BoardVO board) {
		log.info("BoardService_bUpdate");

		return dao.bUpdate(board);
	}

	public int bDelete(BoardVO board) {
		log.info("BoardService_bDelete");

		return dao.bDelete(board);
	}

	public void bViewCountUpdate(BoardVO pBoard) {
		log.info("BoardService_bViewCountUpdate");

		dao.bViewCountUpdate(pBoard);
	}

	public List<BoardVO> bSelectMyBoard(MemberVO pMember) {
		log.info("BoardService_bSelectMyBoard");

		return dao.bSelectMyBoard(pMember);
	}

	public List<BoardVO> bSelectFavorBoard(MemberVO pMember) {
		log.info("BoardService_bSelectFavorBoard");

		return dao.bSelectFavorBoard(pMember);
	}

	public List<BoardVO> selectIntersection(BoardVO vo, String sortKey, String typeKey, String familytypeKey, String workingareaKey,
			String workerKey) {
		return dao.selectIntersection(vo, sortKey, typeKey, familytypeKey, workingareaKey, workerKey);
	}

	public List<BoardVO> select2(BoardVO vo,String sortKey, String livingKey) {
		return dao.select2(vo,sortKey, livingKey);
	}

	public List<BoardVO> select3(BoardVO vo,String sortKey, String cookKey) {
		return dao.select3(vo,sortKey, cookKey);
	}

	public List<BoardVO> select4(BoardVO vo,String sortKey, String dailyKey) {
		return dao.select4(vo,sortKey, dailyKey);
	}

	public int insert(BoardVO vo) {
		return dao.insert(vo);
	}

	public List<BoardVO> views() {
		return dao.views();
	}

	public List<BoardVO> viewsFree() {
		return dao.viewsFree();
	}

	public List<BoardVO> views2() {
		return dao.views2();
	}

	public List<BoardVO> viewsFree2() {
		return dao.viewsFree2();
	}

	public BoardVO random(BoardVO vo) {
		return dao.random(vo);
	}

	public List<BoardVO> bSelectAll(BoardVO pBoard) {
		log.info("BoardService_bSelectAll");
		return dao.bSelectAll(pBoard);
	}

	public List<BoardVO> searchList(String searchKey, String searchWord) {
		return dao.searchList(searchKey, searchWord);
	}

	public List<BoardVO> bSelectAllForRandom() {
		return dao.bSelectAllForRandom();
	}

    public void deleteBoardWithDeleteMember(MemberVO vo) {
		dao.deleteBoardWithDeleteMember(vo);
    }
}
