package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.javassist.bytecode.annotation.MemberValue;
import org.apache.tomcat.util.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import model.Address;
import model.Member;
import model.ProjectMember;
import service.MemberService;
import service.ProjectService;
import util.UploadFileUtils;

@RestController
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProjectService projectService;
	@Resource(name = "uploadPath")
	private String uploadPath;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

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

	/* 이미지 업로드 (myPage) */
	@RequestMapping(value = "uploadProfile", method = RequestMethod.POST)
	public ResponseEntity<String> uploadProfile(HttpSession session, @RequestParam MultipartFile profile)
			throws Exception {
		String loginUser = ((Member) session.getAttribute("loginUser")).getmId();
		// String uploadPath = session.getServletContext().getRealPath("/") +
		// "profile/";

		String md5Id = DigestUtils.md5DigestAsHex(loginUser.getBytes());
		System.out.println("md5Id : " + md5Id);
		String ext = profile.getOriginalFilename().substring(profile.getOriginalFilename().lastIndexOf("."));

		// 파일명 : 유저 + 확장자(.jpg등등)
		String fileName = md5Id + ext;
		System.out.println("fileName : " + fileName);
		// File oldFile = new File(fileName)

		Member member = new Member();
		member.setmId(loginUser);
		member.setmProfile(fileName);

		// 파일을 특정위치에 저장
		File dir = new File(uploadPath);
		if (!dir.exists())
			dir.mkdirs(); // 해당경로에 디렉토리가 없으면 생성
		File attachFile = new File(uploadPath + fileName);
//		FileInputStream fis = new FileInputStream(attachFile);
//		ImageIcon icon = new ImageIcon(IOUtils.toByteArray(fis));
		// 파일 복사
		/*
		 * try { profile.transferTo(attachFile); } catch (IOException ioE) { if
		 * (attachFile != null) { attachFile.delete(); } throw ioE; } finally { }
		 */
		// 이미지 업로드
		 UploadFileUtils.uploadFile(uploadPath, fileName, profile.getBytes());

		memberService.setProfile(member);

		session.setAttribute("loginUser", memberService.selectMember(member.getmId()));

		return null;

	}

	/* 프로필사진 로드 */
	@RequestMapping(value = "getProfile", produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] getProfile(HttpSession session, String profileName) throws IOException, NoSuchAlgorithmException {

		// String profileName = ((Member)
		// session.getAttribute("loginUser")).getmProfile();
		// System.out.println(profileName);
		// File profile = new File(uploadPath + profileName);
		//
		// if (profileName == null || profileName.equals("")) {
		// profile = new File(uploadPath + "default_profile.PNG");
		// } else {
		// System.out.println("getProfile : " + profile);
		// if (profile.exists()) {
		//
		// } else {
		// profile = new File(uploadPath + "default_profile.PNG");
		// }
		//
		// }
		//
		// FileInputStream fis = new FileInputStream(profile);
		//
		// byte[] byteArr = IOUtils.toByteArray(fis);
		// if (fis != null) {
		// fis.close();
		// }
		// // Base64로 인코딩
		// byte[] encoded = Base64.encodeBase64(byteArr);
		// // return encoded;
		return UploadFileUtils.getProfileUtilToByteArray(profileName);

	}

}
