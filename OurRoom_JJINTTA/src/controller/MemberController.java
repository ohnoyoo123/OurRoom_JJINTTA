package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.Member;
import service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("loginForm")
	public String loginForm() {
		System.out.println("loginForm");
		return "member/loginForm";
	}

	@RequestMapping("login")
	public String login() {
		System.out.println("login");

		// memberService.login();

		return "home";
	}

	@RequestMapping("joinForm_step1")
	public String joinForm_step1() {
		System.out.println("joinForm_step1");
		return "member/joinForm_step1";
	}

	@RequestMapping("joinForm_step2")
	public ModelAndView joinForm_step2(HttpServletRequest req, Member member) {

		System.out.println("joinForm_step2");
		System.out.println(member);

		ModelAndView mav = new ModelAndView();
		mav.addObject("member", member);
		mav.setViewName("member/joinForm_step2");
		return mav;
	}

	// 회원가입 완료 및 환영 화면 응답
	@RequestMapping("joinForm_step3")
	public ModelAndView joinForm_step3(Member member) {
		// @RequestParam MultipartFile...
		System.out.println("joinForm_step3");
		System.out.println(member);

		// 회원가입 처리
		memberService.join(member);
		ModelAndView mav = new ModelAndView();
		mav.addObject("member", member);
		mav.setViewName("member/joinForm_step3");
		return mav;
	}

	@RequestMapping("join")
	public String join() {
		String view = "member/loginForm";
		System.out.println("join");
		return view;
	}

	@RequestMapping("select")
	public String select() {

		System.out.println("select");
		System.out.println(memberService.select());

		return "member/loginForm";
	}
}
