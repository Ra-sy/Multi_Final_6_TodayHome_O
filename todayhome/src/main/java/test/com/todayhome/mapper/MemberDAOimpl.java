package test.com.todayhome.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.MemberVO;

@Repository
@Slf4j
public class MemberDAOimpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public MemberVO mSelectOneUserProfile(MemberVO pMember) {
		return sqlSession.selectOne("mSelectOneUserProfile", pMember);
	}

	@Override
	public MemberVO selectOne(MemberVO vo) {
		log.info("selectOne()..."+vo);
		MemberVO vo2 = sqlSession.selectOne("M_SELECT_ONE",vo);
		return vo2;
	}

	@Override
	public MemberVO emailCheck(MemberVO vo) {
		log.info("emailCheck()..."+vo);
		MemberVO vo2 = sqlSession.selectOne("EMAIL_CHECK",vo);
		return vo2;
	}

	@Override
	public int pwUpdate(MemberVO vo) {
		log.info("pwUpdate()..."+vo);
		int flag=sqlSession.update("PW_UPDATE",vo);
		return flag;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		log.info("login()..."+vo);
		return sqlSession.selectOne("LOGIN",vo);
	}

	@Override
	public List<MemberVO> mSelectAll() {
		log.info("mSelectAll()...");
		return sqlSession.selectList("MSELECTALL");
	}

	@Override
	public MemberVO mSelectOne(MemberVO vo) {
		log.info("mSelectOne()..."+vo);
		return sqlSession.selectOne("MSELECTONE",vo);
	}

	@Override
	public MemberVO pwCheck(MemberVO vo) {
		log.info("pwCheck()..."+vo);
		return sqlSession.selectOne("PWCHECK", vo);
	}

	@Override
	public int mUpdate(MemberVO vo) {
		log.info("mUpdate()..."+vo);
		return sqlSession.update("MUPDATE",vo);
	}

	@Override
	public int mDelete(MemberVO vo) {
		log.info("mDelete()..."+vo);
		return sqlSession.delete("MDELETE", vo);
	}
	
	@Override
	public MemberVO nicknameCheck(MemberVO vo) {
		log.info("nicknameCheck()..." + vo);
		return sqlSession.selectOne("NNCHECK", vo);
	}

    @Override
    public void insertMember(MemberVO member) {
        sqlSession.insert("insertMember", member);
    }

    @Override
    public void updateMember(MemberVO member) {
        sqlSession.update("updateMember", member);
    }

    @Override
    public boolean checkEmailExists(String email) {
        int count = sqlSession.selectOne("checkEmailExists", email);
        return count > 0;
    }

    @Override
    public boolean checkNicknameExists(String nickname) {
        int count = sqlSession.selectOne("checkNicknameExists", nickname);
        return count > 0;
    }

    @Override
    public MemberVO getMemberByEmail(String email) {
        return sqlSession.selectOne("getMemberByEmail", email);
    }

	@Override
	public int insert(MemberVO vo) {
		return sqlSession.insert("MINSERT",vo);
	}

}
