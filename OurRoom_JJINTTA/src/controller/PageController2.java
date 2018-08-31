package controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.Member;
import model.Project;
import service.MemberService;
import service.ProjectService;

@Controller
public class PageController2 {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ProjectService projectService;

	@RequestMapping("loginForm")
	public String loginForm() {
		System.out.println("[MemberController > loginForm]");
		return "member/loginForm";
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
	public ModelAndView address(HttpSession session) {
		// 추후 로그인회원의 아이디(loginUser.getmId())로 변경될 값
		// String mId = ((Member)session.getAttribute("loginUser")).getmId();
		String mId = "hong123@gmail.com";

		ModelAndView mav = new ModelAndView();
		// 주소록에 등록된 회원리스트 조회
		List<Member> addressList = memberService.selectAddress(mId);
		System.out.println("[PageController2 > address] addressList : " + addressList);

		// 프로젝트리스트 조회
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mId", mId);
		List<Project> projectList = projectService.getProjectListByMId(paramMap);
		System.out.println("[PageController2 > address] projectList : " + projectList);
		mav.addObject("addressList", addressList);
		mav.addObject("projectList", projectList);
		mav.setViewName("/address/address");

		return mav;
	}

	/* 마이 페이지 */
	@RequestMapping("myPage")
	public String myPage() {
		return "/myPage/myPage";

	}
}
