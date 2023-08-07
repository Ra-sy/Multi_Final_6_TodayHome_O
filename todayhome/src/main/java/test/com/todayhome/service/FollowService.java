package test.com.todayhome.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.todayhome.mapper.FollowDAO;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FollowVO;
import test.com.todayhome.model.MemberVO;

import java.util.List;

@Service
@Slf4j
public class FollowService {


	@Autowired
	private FollowDAO dao;

	public List<FollowVO> flwSelectAllNum(BoardVO pBoard) {
		log.info("FollowService_flwSelectAllNum");

		return dao.flwSelectAllNum(pBoard);
	}

	public List<FollowVO> flwSelectAllMbrNum(MemberVO pMember) {
		log.info("FollowService_flwSelectAllMbrNum");

		return dao.flwSelectAllMbrNum(pMember);
	}

	public FollowVO flwCheck(BoardVO pBoard) {
		log.info("FollowService_flwCheck");

		return dao.flwCheck(pBoard);
	}

	public int flwClickInsert(BoardVO board) {
		log.info("FollowService_flwClickInsert");

		return dao.flwClickInsert(board);
	}

	public int flwClickDelete(BoardVO board) {
		log.info("FollowService_flwClickDelete");

		return dao.flwClickDelete(board);
	}

    public void deleteFollowWithDeleteMember(MemberVO vo) {
		dao.deleteFollowWithDeleteMember(vo);
    }
}
