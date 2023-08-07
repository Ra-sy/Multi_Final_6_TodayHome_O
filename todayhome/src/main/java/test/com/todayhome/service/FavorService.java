package test.com.todayhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.mapper.FavorDAO;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FavorVO;
import test.com.todayhome.model.MemberVO;

import java.util.List;

@Service
@Slf4j
public class FavorService {

	@Autowired
	private FavorDAO dao;

	public List<FavorVO> fvSelectAll(BoardVO pBoard) {
		log.info("FavorService_fvSelectAll");

//		return Optional.ofNullable(dao.fvSelectAll(pBoard)).orElse(Collections.emptyList());
		return dao.fvSelectAll(pBoard);
	}

	public FavorVO fvCheck(BoardVO pBoard){
		log.info("FavorService_fvCheck");
 
		return dao.fvCheck(pBoard);
	}

    public int fvClickInsert(BoardVO board) {
		log.info("FavorService_fvClickInsert");

		return dao.fvClickInsert(board);
    }

	public int fvClickDelete(BoardVO board) {
		log.info("FavorService_fvClickDelete");

		return dao.fvClickDelete(board);
	}

	public List<FavorVO> fvSelectAllFromMbr(MemberVO pMember) {
		log.info("FavorService_fvSelectAllFromMbr");

		return dao.fvSelectAllFromMbr(pMember);
	}

    public void fvDeleteBoardDelete(BoardVO board) {
		log.info("FavorService_fvDeleteBoardDelete");

		dao.fvDeleteBoardDelete(board);
    }

	public void deleteFavorWithDeleteMember(MemberVO vo) {
		dao.deleteFavorWithDeleteMember(vo);
	}
}
