package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import model.Address;
import model.Member;
import model.ProjectMember;
import service.MemberService;
import service.ProjectService;

@RestController
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProjectService projectService;

	// private final Logger logger =
	// LoggerFactory.getLogger(MemberController.class);

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
	public boolean loginMemberCheck(HttpSession session, Member member) {
		System.out.println("[MemberController > loginMemberCheck] : " + member);
		boolean result = memberService.loginMemberCheck(member);
		// 세션에 로그인 회원 등록
		if (result) {
			session.setAttribute("loginUser", memberService.selectMember(member.getmId()));
		}
		return result;
	}

	/* 비밀번호 찾기 요청 */
	@RequestMapping("forgetPw")
	public boolean forgetPw(Member member) {
		System.out.println("[MemberController > forgetPw] 회원 : " + member);
		boolean result = memberService.forgetPw(member);
		System.out.println("[MemberController > forgetPw] 결과 : " + result);
		return result;
	}

	/* 비밀번호 수정 요청 */
	@RequestMapping("updatePw")
	public boolean update(Member member) {
		System.out.println("[MemberController > updatePw] 회원 : " + member);
		boolean result = memberService.updatePw(member);
		System.out.println("[MemberController > updatePw] 결과 : " + result);
		return result;
	}

	/* 회원 검색 요청 */
	@RequestMapping("memberSearch")
	public List<Member> memberSearch(String keyword) {
		List<Member> memberList = memberService.memberSearch(keyword);
		System.out.println("[MemberController > memberSearch] : " + memberList);
		return memberList;
	}

	/* 주소록에 회원 추가 */
	@RequestMapping("addAddress")
	public boolean addAddress(HttpSession session, Address address) {
		String mId = ((Member) session.getAttribute("loginUser")).getmId();
		address.setmId(mId);
		System.out.println("[MemberController > addAddress] before : " + address);
		boolean result = memberService.addAddress(address);
		System.out.println("[MemberController > addAddress] afrer : " + address);
		return result;
	}

	/* 주소록 회원 삭제 */
	@RequestMapping("deleteAddress")
	public boolean deleteAddress(HttpSession session, Address address) {
		String mId = ((Member) session.getAttribute("loginUser")).getmId();
		address.setmId(mId);
		System.out.println("[MemberController > deleteAddress] before : " + address);
		boolean result = memberService.deleteAddress(address);
		System.out.println("[MemberController > deleteAddress] afrer : " + address);
		return result;
	}

	/* 주소록 프로젝트 멤버 리스트 조회 */
	@RequestMapping("addressProjectMemberList")
	public List<ProjectMember> addressProjectMemberList(String pNum) {
		System.out.println("[MemberController > addressProjectMemberList] before : " + pNum);

		int num = Integer.parseInt(pNum);
		System.out.println(projectService.getProjectMemberByPNum(num));
		return projectService.getProjectMemberByPNum(num);
	}

	@RequestMapping("updateNickname")
	public int updateNickname(Member member) {
		return memberService.updateNickname(member);
	}

	// @PostMapping("uploadProfile")
	@RequestMapping(value = "uploadProfile", method = RequestMethod.POST, consumes = { "multipart/form-data" })
	public ResponseEntity<String> uploadProfile(@RequestPart("profile") MultipartFile profile) throws Exception {
	// public ResponseEntity<String> uploadProfile(@RequestParam("profile")
	// MultipartFile profile) throws Exception {

		// logger.info("originalName: " + file.getOriginalFilename());
		// logger.info("originalName: " + file.getSize());
		// logger.info("originalName: " + file.getContentType());
		// System.out.println("originalName: " + file.getOriginalFilename());
		// System.out.println("originalName: " + file.getSize());
		// System.out.println("originalName: " + file.getContentType());
		System.out.println("file : " + profile);
		return null;

	}

}
