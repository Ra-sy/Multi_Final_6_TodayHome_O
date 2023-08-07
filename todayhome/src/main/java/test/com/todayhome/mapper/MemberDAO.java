package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.MemberVO;

public interface MemberDAO {

	MemberVO mSelectOneUserProfile(MemberVO pMember);

	MemberVO selectOne(MemberVO vo);

	MemberVO emailCheck(MemberVO vo);

	int pwUpdate(MemberVO vo);

	MemberVO login(MemberVO vo);

	List<MemberVO> mSelectAll();

	MemberVO mSelectOne(MemberVO vo);

	MemberVO pwCheck(MemberVO vo);

	int mUpdate(MemberVO vo);

	int mDelete(MemberVO vo);

	MemberVO nicknameCheck(MemberVO vo);

    void insertMember(MemberVO member);

    void updateMember(MemberVO member);

    boolean checkEmailExists(String email);

    boolean checkNicknameExists(String nickname);

    MemberVO getMemberByEmail(String email);
    
	int insert(MemberVO vo);

}
