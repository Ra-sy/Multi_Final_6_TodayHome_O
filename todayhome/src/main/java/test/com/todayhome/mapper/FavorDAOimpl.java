package test.com.todayhome.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FavorVO;
import test.com.todayhome.model.MemberVO;

@Repository
@Slf4j
public class FavorDAOimpl implements FavorDAO{

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<FavorVO> fvSelectAll(BoardVO pBoard) {

        return sqlSession.selectList("fvSelectAll", pBoard);
    }

    @Override
    public FavorVO fvCheck(BoardVO pBoard) {

        return sqlSession.selectOne("fvCheck", pBoard);
    }

    @Override
    public int fvClickInsert(BoardVO board) {

        return sqlSession.insert("fvClickInsert", board);
    }

    @Override
    public int fvClickDelete(BoardVO board) {

        return sqlSession.delete("fvClickDelete", board);
    }

    @Override
    public List<FavorVO> fvSelectAllFromMbr(MemberVO pMember) {

        return sqlSession.selectList("fvSelectAllFromMbr", pMember);
    }

    @Override
    public void fvDeleteBoardDelete(BoardVO board) {

        sqlSession.delete("fvDeleteBoardDelete", board);
    }

    @Override
    public void deleteFavorWithDeleteMember(MemberVO vo) {
        sqlSession.delete("deleteFavorWithDeleteMember",vo);
    }

}
