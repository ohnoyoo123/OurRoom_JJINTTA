package dao;

import java.util.List;

import model.Member;

public interface MemberDao {

	// 회원 정보 삽입
	public int insertMember(Member member);

	public List<Member> selectMember();
}
