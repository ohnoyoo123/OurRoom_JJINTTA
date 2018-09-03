package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import model.CheckList;
import model.CheckListItem;
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
		data.put("issueMember", iSvc.getIssueMember(issue));
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
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
	
	//체크리스트를 새로 추가하고 체크리스트 다 받아오기
	@PostMapping("/project/addCheckList")
	public Map<String, Object> addCheckList(CheckList checkList) {
		System.out.println("요청 url : " + "/project/addCheckList");
		clSvc.addCheckList(checkList);
		Issue issue = new Issue();
		issue.setpNum(checkList.getpNum());
		issue.settNum(checkList.gettNum());
		issue.setiNum(checkList.getiNum());
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
		return data;
	}
	
	//체크리스트 삭제하고 체크리스트 다시!
	@PostMapping("/project/deleteCheckList")
	public Map<String, Object> deleteCheckList(CheckList checkList){
		System.out.println("요청 url : " + "/project/deleteCheckList");
		clSvc.deleteCheckList(checkList);
		
		Issue issue = new Issue();
		issue.setpNum(checkList.getpNum());
		issue.settNum(checkList.gettNum());
		issue.setiNum(checkList.getiNum());
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
		return data;
		
	}
	
	//체크리스트 아이템 생성하고 체크리스트 다시!!
	@PostMapping("/project/addCheckListItem")
	public Map<String, Object> addCheckListItem(CheckListItem checkListItem, @RequestParam(value="members[]", required=false) List<String> members) {
		System.out.println("요청 url : /project/addCheckListItem");
		System.out.println(members);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("checkListItem", checkListItem);
		param.put("members", members);
		clSvc.addCheckListItem(param);
		
		//새로운 체크리스트 불러와서 보내주기
		//사실 이런것들을 서비스에서 해주면 좋을것 같은데??
		//컨트롤러는 그냥 데이터 통로로만 사용하고 말이지?
		//친구들과 상의해보고 결정할 것
		Issue issue = new Issue();
		issue.setpNum(checkListItem.getpNum());
		issue.settNum(checkListItem.gettNum());
		issue.setiNum(checkListItem.getiNum());
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
		return data;

	}
	
	@PostMapping("/project/deleteCheckListItem")
	public Map<String, Object> deleteCheckListItem(CheckListItem checkListItem) {
		System.out.println("요청 url : /project/deleteCheckListItem");
		clSvc.deleteCheckListItem(checkListItem);
		
		Issue issue = new Issue();
		issue.setpNum(checkListItem.getpNum());
		issue.settNum(checkListItem.gettNum());
		issue.setiNum(checkListItem.getiNum());
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
		return data;

		
	}
	
}
