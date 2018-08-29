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
		System.out.println("[idCheck] : " + mId);
		System.out.println(memberService.idCheck(mId));

		return memberService.idCheck(mId);
	}

	/* 회원가입시 닉네임 중복 체크 요청 */
	@RequestMapping("nicknameCheck")
	public boolean nicknameCheck(String mNickname) {
		System.out.println("[mNickname] : " + mNickname);
		return memberService.nicknameCheck(mNickname);
	}
	
	/* 로그인시 회원 체크 요청 */
	@RequestMapping("loginMemberCheck")
	public boolean loginMemberCheck(Member member) {
		
		System.out.println("[loginMemberCheck] : " + member);
		
		
		return memberService.loginMemberCheck(member);
	}
}
