package test.com.todayhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.mapper.MemberDAO;
import test.com.todayhome.model.MemberVO;

@Slf4j
@Service
public class MemberService {

	@Autowired
	MemberDAO dao;

	public MemberVO mSelectOneUserProfile(MemberVO pMember) {
		log.info("MemberService_mSelectOneUserProfile");

		return dao.mSelectOneUserProfile(pMember);
	}

	public MemberVO selectOne(MemberVO vo) {
		return dao.selectOne(vo);
	}

	public MemberVO emailCheck(MemberVO vo) {
		return dao.emailCheck(vo);
	}

	public int pwUpdate(MemberVO vo) {
		return dao.pwUpdate(vo);
	}

	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public List<MemberVO> mSelectAll() {
		return dao.mSelectAll();
	}

	public MemberVO mSelectOne(MemberVO vo) {
		return dao.mSelectOne(vo);
	}

	public MemberVO pwCheck(MemberVO vo) {
		return dao.pwCheck(vo);
	}

	public int mUpdate(MemberVO vo) {
		return dao.mUpdate(vo);
	}

	public int mDelete(MemberVO vo) {
		return dao.mDelete(vo);
	}

	public MemberVO nicknameCheck(MemberVO vo) {
		return dao.nicknameCheck(vo);
	}
	public void insertMember(MemberVO member) {
		// 회원가입 로직 구현 (이메일 인증, 비밀번호 확인 등)
		dao.insertMember(member);
	}

	public void updateMember(MemberVO member) {
		// 회원정보 수정 로직 구현 (성별, 생년월일, 프로필 이미지, 한줄 소개)
		dao.updateMember(member);
	}

	public boolean checkEmailExists(String email) {
		// 이메일 중복 체크 로직 구현
		return dao.checkEmailExists(email);
	}

	public boolean checkNicknameExists(String nickname) {
		// 닉네임 중복 체크 로직 구현
		return dao.checkNicknameExists(nickname);
	}

	public MemberVO getMemberByEmail(String email) {
		// 이메일로 회원 정보 조회 로직 구현
		return dao.getMemberByEmail(email);
	}
	
	public int insert(MemberVO vo) {
		return dao.insert(vo);
	}
}
