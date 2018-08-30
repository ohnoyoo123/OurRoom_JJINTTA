package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.Member;
import service.MemberService;

@Controller
public class PageController2 {

	@Autowired
	private MemberService memberService;

	@RequestMapping("loginForm")
	public String loginForm() {
		System.out.println("[MemberController > loginForm]");
		return "member/loginForm";
	}

	@RequestMapping("login")
	public String login() {
		System.out.println("[MemberController > login]");

		// memberService.login();

		return "home/home";
	}

	/* [회원가입] 필수입력 단계 페이지 요청 */
	@RequestMapping("joinForm_step1")
	public String joinForm_step1() {
		System.out.println("joinForm_step1");
		return "member/joinForm_step1";
	}

	/* [회원가입] 선택입력(프로필사진)입력 단계 페이지 요청 */
	@RequestMapping("joinForm_step2")
	public ModelAndView joinForm_step2(Member member) {

		System.out.println("joinForm_step2");
		System.out.println(member);

		ModelAndView mav = new ModelAndView();
		mav.addObject("member", member);
		mav.setViewName("member/joinForm_step2");
		return mav;
	}

	/* 회원가입 완료 및 환영 페이지 요청 */
	@RequestMapping("join")
	public ModelAndView join(Member member) {
		// @RequestParam MultipartFile...
		System.out.println("[PageController2 > join] : " + member);

		// 회원가입 처리
		memberService.join(member);

		ModelAndView mav = new ModelAndView();
		mav.addObject("member", member);
		mav.setViewName("member/joinForm_step3");
		return mav;
	}

	/* 메인페이지 */
	@RequestMapping("home")
	public String home() {
		return "home/home";
	}

	/* 사이트 첫 페이지 */
	@RequestMapping("main")
	public String index() {
		return "main";
	} 
	
	/* 주소록 페이지 */
	@RequestMapping("address")
	public String address() {
		return "/address/address";
	}

	/* 마이 페이지 */
	@RequestMapping("myPage")
	public String myPage() {
		return "/myPage/myPage";

	}
}
