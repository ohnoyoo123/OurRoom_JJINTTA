package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.Member;

@Service
public class MemberService {

	@Autowired
	private MemberDao mDao;

	/* test 용 */
	public List<Member> select() {
		// TODO Auto-generated method stub
		return mDao.selectMember();
	}

	/* 회원가입시 아이디 중복 체크 */
	public boolean idCheck(String mId) {
		System.out.println("[MemberService > idCheck] : " + mDao.selectById(mId));
		return (mDao.selectById(mId) == null) ? false : true;
	}

	/* 회원가입시 닉네임 중복 체크 */
	public boolean nicknameCheck(String mNickname) {
		System.out.println("[MemberService > nicknameCheck] : " + mDao.selectByNickname(mNickname));
		return (mDao.selectByNickname(mNickname) == null) ? false : true;
	}

	/* 회원가입 기능 */
	public int join(Member member) {

		return mDao.insertMember(member);

	}

	/* 로그인 회원 체크 */
	public boolean loginMemberCheck(Member member) {
			
		System.out.println("[MemberService > loginMemberCheck] : " + mDao.selectByIdAndPw(member));
		return (mDao.selectByIdAndPw(member) == null ) ? false : true;
	}

}
