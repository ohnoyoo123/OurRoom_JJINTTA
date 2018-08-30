package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import model.Member;
import service.MemberService;

@RestController
public class MemberController {
	@Autowired
	private MemberService memberService;

	/* 회원가입시 아이디 중복 체크 요청 */
	@RequestMapping("idCheck")
	public boolean idCheck(String mId) {
		System.out.println("[MemberController > idCheck] : " + mId);
		System.out.println(memberService.idCheck(mId));

		return memberService.idCheck(mId);
	}

	/* 회원가입시 닉네임 중복 체크 요청 */
	@RequestMapping("nicknameCheck")
	public boolean nicknameCheck(String mNickname) {
		System.out.println("[MemberController > mNickname] : " + mNickname);
		return memberService.nicknameCheck(mNickname);
	}

	/* 로그인시 회원 체크 요청 */
	@RequestMapping("loginMemberCheck")
	public boolean loginMemberCheck(Member member) {

		System.out.println("[MemberController > loginMemberCheck] : " + member);

		return memberService.loginMemberCheck(member);
	}

	/* 비밀번호 찾기 요청 */
	@RequestMapping("forgetPw")
	public boolean forgetPw(Member member) {
		System.out.println("[MemberController > forgetPw] 회원 : " + member);
		boolean result = memberService.forgetPw(member);
		System.out.println("[MemberController > forgetPw] 결과 : " + result);
		return result;
	}
	
	@RequestMapping("updatePw")
	public boolean update(Member member) {
		System.out.println("[MemberController > updatePw] 회원 : " + member);
		boolean result = memberService.updatePw(member);
		System.out.println("[MemberController > updatePw] 결과 : " + result);
		return result;
	}
}
