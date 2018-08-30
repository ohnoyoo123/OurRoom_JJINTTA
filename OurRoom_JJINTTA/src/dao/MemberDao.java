package dao;

import java.util.List;

import model.Member;

public interface MemberDao {

	// 회원 정보 삽입
	public int insertMember(Member member);
	
	// 테스트용 전체조회
	public List<Member> selectMember();

	// 아이디로 조회
	public Member selectById(String mId);

	// 닉네임으로 조회
	public Member selectByNickname(String mNickname);
	
	// 아이디와 비밀번호로 조회
	public Member selectByIdAndPw(Member member);

	public int updatePw(Member member);
}
