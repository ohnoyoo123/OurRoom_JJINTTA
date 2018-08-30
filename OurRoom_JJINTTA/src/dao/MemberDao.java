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
	
	// 비밀번호 수정
	public int updatePw(Member member);
	
	// 키워드로 회원 조회 (아이디 또는 닉네임)
	public List<Member> selectMemberByKeyword(String keyword);
}
