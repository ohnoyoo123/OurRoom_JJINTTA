package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import model.Issue;
import model.IssueMember;
import model.Member;
import model.Project;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.MemberService;
import service.ProjectService;
import service.TaskService;

@RestController
public class ProjectRestController {
	
	@Autowired
	ProjectService pSvc;

	@Autowired
	IssueService iSvc;

	@Autowired
	CheckListService clSvc;

	@Autowired
	MemberService mSvc;

	@Autowired
	TaskService tSvc;
	
	@PostMapping("/project/newProject")
	public int newProject(Project project, String owner, @RequestParam(value="members[]", required=false) List<String> members) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("project", project);
		params.put("owner", owner);
		params.put("projectMember", members);
		
		System.out.println("============================= new project!");
		
		 return pSvc.addProject(params);
	}


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
		System.out.println("검색값" + mSvc.memberSearch(mId));
		return mSvc.memberSearch(mId);
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
