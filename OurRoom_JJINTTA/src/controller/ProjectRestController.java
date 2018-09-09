package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dao.LogDao;
import model.CheckList;
import model.CheckListItem;
import model.Issue;
import model.IssueMember;
import model.Log;
import model.Member;
import model.Noti;
import model.Project;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.LogService;
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

	@Autowired
	LogService lSvc;

	@Autowired
	LogDao lDao;
	
	@Autowired
	LogService logSvc;

	@PostMapping("/project/newProject")
	public int newProject(Project project, String owner,
			@RequestParam(value = "members[]", required = false) List<String> members) {

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
		System.out.println("검색값" + mSvc.memberSearch(mId));
		return mSvc.memberSearch(mId);
	}

	@PostMapping("/project/addTask")

	public Map<String, Object> addTask(HttpSession session, Task task) {

		System.out.println("요청 url : " + "/project/addTask");

		// String loginUser = ((Member)session.getAttribute("loginUser")).getmId();
		String loginUser = "hong123@gmail.com";
		System.out.println("================요청 태스크 정보" + task);
		tSvc.addTask(task, loginUser);
		
		int pNum = task.getpNum();
		
		System.out.println("pNum : " + pNum);
		
		task.settNum(0);

		System.out.println("태스크 리스트 : " + tSvc.getTaskList(task));

		Map<String, Object> data = new HashMap<String, Object>();
		Issue issue = new Issue();
		issue.setpNum(pNum);
		

		
//		Gson gson = new Gson();
//		String stringProject = gson.toJson(pSvc.getProject(pNum));
//		JsonObject projectJson = new JsonParser().parse(stringProject).getAsJsonObject();
//		
//		String stringTask = gson.toJson(tSvc.getTaskList(task));
//		JsonArray taskJson = new JsonParser().parse(stringTask).getAsJsonArray();
//		
//		
//		String stingIssue = gson.toJson(iSvc.getIssueList(issue));
//		JsonArray issueJson = new JsonParser().parse(stingIssue).getAsJsonArray();
//		
//		System.out.println("이슈리스트" + iSvc.getIssueList(issue));
//
//		Map<String, Object> data = new HashMap<String, Object>();
		data.put("projectJson", pSvc.getProject(pNum));
		data.put("taskJson", tSvc.getTaskList(task));
		data.put("issueJson", iSvc.getIssueList(issue));

		return data;

	}

	@PostMapping("/project/deleteTask")
	public void deleteTask(Task task) {
		System.out.println("요청 url : " + "/project/deleteTask");
		tSvc.deleteTask(task);
	}

	@PostMapping("/project/addIssue")
	public Map<String, Object> addIssue(HttpSession session, Issue issue, @RequestParam(value = "members[]", required = false) List<String> members) {
		System.out.println("요청 url : " + "/project/addIssue");

		System.out.println(members);
		// String loginUser = ((Member)session.getAttribute("loginUser")).getmId();
		String loginUser = "hong123@gmail.com";

		Issue returnIssue = iSvc.addIssue(issue, loginUser);
		
		int pNum = issue.getpNum();
		
		if (members != null) {
			// 생성과 동시에 멤버추가 로그 생성
			Map<String, Object> logMap = new HashMap<String,Object>();
			logMap.put("target", returnIssue);
			logMap.put("mId", loginUser);
			logMap.put("lCat", Log.I_ADD_MEMBER);
			logSvc.insertLog(logMap);

			// 직전에 삽입된 로그의 번호를 가져온다.
			int LastLNum = lDao.selectLogLastLNum(returnIssue.getpNum());

			for (String mId : members) {
				IssueMember im = new IssueMember();
				im.setpNum(returnIssue.getpNum());
				im.settNum(returnIssue.gettNum());
				im.setiNum(returnIssue.getiNum());
				im.setmId(mId);
				iSvc.addIssueMember(im);
				
				// 로그 남기기(이슈 멤버추가 33)
				// 알림 생성
				Map<String, Object> notiMap = new HashMap<String, Object>();
				notiMap.put("pNum", returnIssue.getpNum());
				notiMap.put("mId", mId);
				notiMap.put("lNum", LastLNum);

				logSvc.insertNoti(notiMap);
			}
		}
		
		Task task = new Task();
		task.setpNum(pNum);
		
		issue.setiNum(0);
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("projectJson", pSvc.getProject(pNum));
		data.put("taskJson", tSvc.getTaskList(task));
		data.put("issueJson", iSvc.getIssueList(issue));
		
		System.out.println("=----==--------------------------------------------");
		System.out.println(tSvc.getTaskList(task));
		System.out.println(iSvc.getIssueList(issue));
		return data;
	}

	@PostMapping("/project/deleteIssue")
	public void deleteIssue(Issue issue) {
		System.out.println("요청 url : " + "/project/deleteIssue");
		iSvc.deleteIssue(issue);
	}

	// 체크리스트를 새로 추가하고 체크리스트 다 받아오기
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

	// 체크리스트 삭제하고 체크리스트 다시!
	@PostMapping("/project/deleteCheckList")
	public Map<String, Object> deleteCheckList(CheckList checkList) {
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

	// 체크리스트 아이템 생성하고 체크리스트 다시!!
	@PostMapping("/project/addCheckListItem")
	public Map<String, Object> addCheckListItem(CheckListItem checkListItem,
			@RequestParam(value = "members[]", required = false) List<String> members) {
		System.out.println("요청 url : /project/addCheckListItem");
		System.out.println(members);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("checkListItem", checkListItem);
		param.put("members", members);
		clSvc.addCheckListItem(param);

		// 새로운 체크리스트 불러와서 보내주기
		// 사실 이런것들을 서비스에서 해주면 좋을것 같은데??
		// 컨트롤러는 그냥 데이터 통로로만 사용하고 말이지?
		// 친구들과 상의해보고 결정할 것
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
	
	@PostMapping("/project/test")
	public void test(@RequestBody Task task) {
		System.out.println("====================");
		System.out.println(task);
	}
}
