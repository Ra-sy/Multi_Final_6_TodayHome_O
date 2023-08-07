package test.com.todayhome.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.MemberVO;

@Repository
@Slf4j
public class BoardDAOimpl implements BoardDAO{

    @Autowired
    private SqlSession sqlSession;

    @Override
    public BoardVO bSelectOne(BoardVO pBoard) {

        return sqlSession.selectOne("bSelectOne", pBoard);
    }

    @Override
    public int bUpdate(BoardVO board) {

        return sqlSession.update("bUpdate", board);
    }

    @Override
    public int bDelete(BoardVO board) {

        return sqlSession.delete("bDelete", board);
    }

    @Override
    public void bViewCountUpdate(BoardVO pBoard) {

        sqlSession.update("bViewCountUpdate", pBoard);
    }

    @Override
    public List<BoardVO> bSelectMyBoard(MemberVO pMember) {

        return sqlSession.selectList("bSelectMyBoard", pMember);
    }

    @Override
    public List<BoardVO> bSelectFavorBoard(MemberVO pMember) {


		return sqlSession.selectList("bSelectFavorBoard", pMember);
	}


	@Override
	public List<BoardVO> selectIntersection(BoardVO vo, String sortKey, String typeKey, String familytypeKey, String workingareaKey, String workerKey) {
		log.info("/selectIntersection()....");
		log.info("sortKey:{}",sortKey);
		log.info("typeKey:{},familytypeKey:{}",typeKey,familytypeKey);
		log.info("workingareaKey:{},workerKey:{}",workingareaKey,workerKey);

		Map<String, Object> params = new HashMap<>();
		params.put("usrMnum", vo.getUsrMnum());
	    params.put("sortKey", sortKey);
	    params.put("typeKey", typeKey);
	    params.put("familytypeKey", familytypeKey);
	    params.put("workingareaKey", workingareaKey);
	    params.put("workerKey", workerKey);

	    return sqlSession.selectList("BSELECT_ALL_INTERSECTION", params);
	}

	@Override
	public List<BoardVO> select2(BoardVO vo,String sortKey, String livingKey) {
		log.info("/select2()....");
		log.info("sortKey:{},livingKey:{}",sortKey,livingKey);

		Map<String, Object> params = new HashMap<>();
		params.put("usrMnum", vo.getUsrMnum());
	    params.put("sortKey", sortKey);
	    params.put("livingKey", livingKey);

		return sqlSession.selectList("BSELECT_ALL_2", params);
	}

	@Override
	public List<BoardVO> select3(BoardVO vo,String sortKey, String cookKey) {
		log.info("/select3()....");
		log.info("sortKey:{},cookKey:{}",sortKey,cookKey);

		Map<String, Object> params = new HashMap<>();
		params.put("usrMnum", vo.getUsrMnum());
	    params.put("sortKey", sortKey);
	    params.put("cookKey", cookKey);

		return sqlSession.selectList("BSELECT_ALL_3", params);
	}

	@Override
	public List<BoardVO> select4(BoardVO vo,String sortKey, String dailyKey) {
		log.info("/select4()....");
		log.info("sortKey:{},dailyKey:{}",sortKey,dailyKey);

		Map<String, Object> params = new HashMap<>();
		params.put("usrMnum", vo.getUsrMnum());
	    params.put("sortKey", sortKey);
	    params.put("dailyKey", dailyKey);

		return sqlSession.selectList("BSELECT_ALL_4", params);
	}

	@Override
	public int insert(BoardVO vo) {
		log.info("insert()...vo: {}",vo);
		return sqlSession.insert("B_INSERT",vo);
	}

	@Override
	public List<BoardVO> views() {
		log.info("views()...");
		return sqlSession.selectList("B_VIEWS");
	}

	@Override
	public List<BoardVO> viewsFree() {
		log.info("viewsFree()...");
		return sqlSession.selectList("B_VIEWS_FREE");
	}
	@Override
	public List<BoardVO> views2() {
		log.info("views2()...");
		return sqlSession.selectList("B_VIEWS2");
	}

	@Override
	public List<BoardVO> viewsFree2() {
		log.info("viewsFree2()...");
		return sqlSession.selectList("B_VIEWS_FREE2");
	}

	@Override
	public BoardVO random(BoardVO vo) {
		log.info("random()...", vo);
		return sqlSession.selectOne("B_RANDOM",vo);
	}

    @Override
    public List<BoardVO> bSelectAll(BoardVO pBoard) {
        return  sqlSession.selectList("bSelectAll", pBoard);
    }
    
	@Override
	public List<BoardVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()....searchKey:{}",searchKey);
		log.info("searchList()....searchWord:{}",searchWord);
		String key = "";
		if(searchKey.equals("title")) {
			key = "BSEARCHLIST_TITLE";
		}else 
			key = "BSEARCHLIST_MBRNICKNAME";
		return sqlSession.selectList(key,"%"+searchWord+"%");
	}

	@Override
	public List<BoardVO> bSelectAllForRandom() {
		return sqlSession.selectList("bSelectAllForRandom");
	}

	@Override
	public void deleteBoardWithDeleteMember(MemberVO vo) {
		sqlSession.delete("deleteBoardWithDeleteMember",vo);
	}

}
