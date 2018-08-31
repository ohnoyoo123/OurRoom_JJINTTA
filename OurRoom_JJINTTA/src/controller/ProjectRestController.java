package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.util.JSONPObject;

import model.Issue;
import model.IssueMember;
import model.Member;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.MemberService;
import service.TaskService;

@RestController
public class ProjectRestController {

	@Autowired
	IssueService iSvc;

	@Autowired
	CheckListService clSvc;

	@Autowired
	MemberService mSvc;

	@Autowired
	TaskService tSvc;

	@PostMapping("/project/issueDetail")
	public Map<String, Object> issueDetail(Issue issue) {
		System.out.println("요청 url : " + "/project/issueDetail");
		System.out.println(issue);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("issue", iSvc.getIssueList(issue));
		data.put("checkList", clSvc.selectCheckList(issue));
		data.put("checkListItem", clSvc.selectAllCheckListItem(issue));
		data.put("issueMember", iSvc.getIssueMember(issue));

		System.out.println("data : " + data);
		return data;

	}

	@PostMapping("/project/memberSearch")
	public List<Member> memberSearch(String mId) {
		System.out.println("요청 url : " + "/project/memberSearch");
		System.out.println("==============================\n" + mId);
		System.out.println("검색값" + mSvc.select());
		return mSvc.select();
	}

	@PostMapping("/project/addTask")
	public void addTask(Task task) {
		System.out.println("요청 url : " + "/project/addTask");

		tSvc.addTask(task);
	}
	
	@PostMapping("/project/deleteTask")
	public void deleteTask(Task task) {
		System.out.println("요청 url : " + "/project/deleteTask");
		tSvc.deleteTask(task);
	}
	
	@PostMapping("/project/addIssue")
	public void addIssue(Issue issue, @RequestParam(value="members[]", required=false) List<String> members) {
		System.out.println("요청 url : " + "/project/addIssue");

		System.out.println(members);
		
		iSvc.addIssue(issue);
		
		List<Issue> issueList = iSvc.getIssueList(issue);
		issue = issueList.get(issueList.size()-1);
		
		if(members != null) {
			for(String mId : members) {
				IssueMember im = new IssueMember();
				im.setpNum(issue.getpNum());
				im.settNum(issue.gettNum());
				im.setiNum(issue.getiNum());
				im.setmId(mId);
				iSvc.addIssueMember(im);
			}
		}
		
	}
	
	@PostMapping("/project/deleteIssue")
	public void deleteIssue(Issue issue) {
		System.out.println("요청 url : " + "/project/deleteIssue");
		iSvc.deleteIssue(issue);
	}
	
	
}
