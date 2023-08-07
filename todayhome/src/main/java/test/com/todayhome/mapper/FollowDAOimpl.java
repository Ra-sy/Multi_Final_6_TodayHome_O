package test.com.todayhome.mapper;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import test.com.todayhome.model.BoardVO;
import test.com.todayhome.model.FollowVO;
import test.com.todayhome.model.MemberVO;

import java.util.List;

@Repository
@Slf4j
public class FollowDAOimpl implements FollowDAO{

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<FollowVO> flwSelectAllNum(BoardVO pBoard) {

        return sqlSession.selectList("flwSelectAllNum", pBoard);
    }

    @Override
    public List<FollowVO> flwSelectAllMbrNum(MemberVO pMember) {

        return sqlSession.selectList("flwSelectAllMbrNum", pMember);
    }

    @Override
    public FollowVO flwCheck(BoardVO pBoard) {

        return sqlSession.selectOne("flwCheck", pBoard);
    }

    @Override
    public int flwClickInsert(BoardVO board) {

        return sqlSession.insert("flwClickInsert", board);
    }

    @Override
    public int flwClickDelete(BoardVO board) {

        return sqlSession.delete("flwClickDelete", board);
    }

    @Override
    public void deleteFollowWithDeleteMember(MemberVO vo) {
        sqlSession.delete("deleteFollowWithDeleteMember", vo);
    }

}
