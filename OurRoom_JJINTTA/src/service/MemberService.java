package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.Address;
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
		return (mDao.selectByIdAndPw(member) == null) ? false : true;
	}

	/* 비밀번호 찾기 답변 여부 */
	public boolean forgetPw(Member member) {
		Member db_member = mDao.selectById(member.getmId());
		String message = "[MemberService > forgetPw] 아이디 : ";

		if (db_member == null) { // 아이디가 존재하지 않을 경우
			message += " 회원 없음";
		} else if (db_member.getmQuestion() != member.getmQuestion()) { // 질문이 다를 경우
			message += " 회원의 질문이 틀림";
		} else if (!db_member.getmAnswer().equals(member.getmAnswer())) { // 답변이 다를 경우
			message += " 회원의 답변이 틀림";
		} else { // 비밀번호 찾기 가능
			System.out.println(message + " 회원 비밀번호 찾기 가능");
			return true;
		}
		System.out.println(message);
		return false;
	}

	/* 비밀번호 변경 */
	public boolean updatePw(Member member) {
		int result = mDao.updatePw(member);
		System.out.println("[MemberService > updatePw] 아이디 : " + member.getmId() + " 비밀번호 변경 결과 (" + result + ")");
		return (result == 1) ? true : false;
	}

	/* 회원 검색 */
	// 키워드 : 아이디 또는 닉네임 해당하는 검색어
	public List<Member> memberSearch(String keyword) {
		return mDao.selectMemberByKeyword(keyword);
	}

	/* 주소록 조회 */
	public List<Member> selectAddress(String mId) {
		return mDao.selectAddressById(mId);
	}

	/* 주소록 추가 */
	public boolean addAddress(Address address) {

		Address searchAddressMember = mDao.selectAddressMemberBymId_aId(address);
		// 주소록 포함 회원이면
		if (searchAddressMember != null) {
			return false;
		}
		mDao.insertAddress(address);
		return true;
	}

	public boolean deleteAddress(Address address) {
		mDao.deleteAddress(address);
		return true;
	}

}
