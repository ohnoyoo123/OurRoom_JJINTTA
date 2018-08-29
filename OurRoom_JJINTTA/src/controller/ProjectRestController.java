package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import model.Issue;
import model.Member;
import service.CheckListService;
import service.IssueService;
import service.MemberService;

@RestController
public class ProjectRestController {

	@Autowired
	IssueService iSvc;
	
	@Autowired
	CheckListService clSvc;

	@Autowired
	MemberService mSvc;
	
	@PostMapping("/project/issueDetail")
	public void issueDetail(Issue issue) {
		System.out.println(iSvc.getIssueList(issue));
		System.out.println(clSvc.selectCheckList(issue));
		
	}
	@PostMapping("/project/memberSearch")
	public List<Member> memberSearch(String mId) {
		System.out.println("==============================\n"+mId);	
		System.out.println(mSvc.select());
		return mSvc.select();
	}
}
