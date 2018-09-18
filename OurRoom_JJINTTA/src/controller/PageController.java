package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import model.Issue;
import model.IssueMember;
import model.Member;
import model.Project;
import model.ProjectMember;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.MemberService;
import service.ProjectService;
import service.TaskService;
import util.ProjectUtil;
import util.UploadFileUtils;

@Controller
public class PageController {

	@Autowired
	ProjectService pSvc;

	@Autowired
	MemberService mSvc;

	@Autowired
	TaskService tSvc;

	@Autowired
	IssueService iSvc;

	@Autowired
	CheckListService clSvc;

	@RequestMapping("/project/pList")
	public ModelAndView project(HttpSession session) {
		System.out.println("요청 url : /project/pList");
		String mId = ((Member) session.getAttribute("loginUser")).getmId();

		System.out.println("mId : " + mId);
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> paramMId = new HashMap<String, Object>();
		paramMId.put("mId", mId);

		List<Project> pastProject = new ArrayList<Project>();
		List<Project> progProject = new ArrayList<Project>();
		List<Project> projectList = new ArrayList<Project>();

		projectList = pSvc.getProjectListByMId(paramMId);
		// 진행중인 프로젝트와 마감된 프로젝트를 util클래스로 처리
		mav.addObject("pastProject", ProjectUtil.pastProject(projectList));
		mav.addObject("progProject", ProjectUtil.progProject(projectList));

		List<ProjectMember> pmList = new ArrayList<>();
		pmList = pSvc.getProjectMemberByMId(paramMId);
		mav.addObject("pmList", pmList);
		System.out.println(pmList);
		// System.out.println(projectList);

		mav.setViewName("/project/pList");
		return mav;
	}

	@RequestMapping("/project/gantt")
	public ModelAndView project_gantt(@RequestParam(value = "tNum", required = false) String tNum, int pNum,
			@RequestParam(required = false) String iNum, @RequestParam(required = false) String log) {
		System.out.println("tNum :" + tNum);
		System.out.println("pNum : " + pNum);
		ModelAndView mav = new ModelAndView();

		mav.addObject("project", pSvc.getProject(pNum));
		System.out.println(pSvc.getProject(pNum));
		Task task = new Task();
		task.setpNum(pNum);
		System.out.println("태스크 리스트 : " + tSvc.getTaskList(task));
		mav.addObject("taskList", tSvc.getTaskList(task));

		Gson gson = new Gson();

		String stringProject = gson.toJson(pSvc.getProject(pNum));
		JsonObject projectJson = new JsonParser().parse(stringProject).getAsJsonObject();
		mav.addObject("projectJson", projectJson);

		String stringTask = gson.toJson(tSvc.getTaskList(task));
		JsonArray taskJson = new JsonParser().parse(stringTask).getAsJsonArray();
		mav.addObject("taskJson", taskJson);

		Issue issue = new Issue();
		issue.setpNum(pNum);
		mav.addObject("issueList", iSvc.getIssueList(issue));

		String stringIssue = gson.toJson(iSvc.getIssueList(issue));
		JsonArray issueJson = new JsonParser().parse(stringIssue).getAsJsonArray();
		mav.addObject("issueJson", issueJson);

		System.out.println("이슈리스트" + iSvc.getIssueList(issue));

		// List<String> profileList = new ArrayList<String>();
		Map<String, String> profileList = new HashMap<String, String>();
		List<Member> projectMemberList = new ArrayList<Member>();

		for (ProjectMember pm : pSvc.getProjectMemberByPNum(pNum)) {
			projectMemberList.add(mSvc.selectMember(pm.getmId()));

			try {
				System.out.println("1 : " + mSvc.selectMember(pm.getmId()).getmProfile());
				// profileList.add(UploadFileUtils.getProfileUtilToString(mSvc.selectMember(pm.getmId()).getmProfile()));
				profileList.put(pm.getmId(),
						UploadFileUtils.getProfileUtilToString(mSvc.selectMember(pm.getmId()).getmProfile()));

			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto -generated catch block
				e.printStackTrace();
			}
		}
		mav.addObject("profileList", profileList);
		// mav.addObject("projectMemberList", pSvc.getProjectMemberByPNum(pNum));
		mav.addObject("projectMemberList", projectMemberList);
		mav.addObject("pNum", pNum);
		mav.addObject("tNum", tNum);
		mav.addObject("iNum", iNum);
		mav.addObject("log", log);
		mav.setViewName("/project/gantt2");
		return mav;
	}

	@RequestMapping("/project/kanban")
	public ModelAndView project_kanban(int pNum, int tNum) {

		ModelAndView mav = new ModelAndView();

		// 프로젝트 정보
		mav.addObject("project", pSvc.getProject(pNum));

		// 프로젝트 멤버 정보
		mav.addObject("projectMemberList", pSvc.getProjectMemberByPNum(pNum));

		// 태스크 정보
		Task task = new Task();
		task.setpNum(pNum);
		task.settNum(tNum);
		System.out.println("혹시? : " + tSvc.getTaskList(task));
		mav.addObject("task", tSvc.getTaskList(task));

		// 이슈 정보
		Issue issue = new Issue();
		issue.setpNum(pNum);
		issue.settNum(tNum);
		mav.addObject("issueList", iSvc.getIssueList(issue));

		// 이슈 멤버 정보
		IssueMember issueMember = new IssueMember();
		issueMember.setpNum(pNum);
		issueMember.settNum(tNum);
		mav.addObject("issueMemberList", iSvc.getIssueMember(issue));

		// 체크리스트 정보(이슈 모델로 가져옴) ?? 이름을 이따구로??
		mav.addObject("checkListList", clSvc.getCheckList(issue));

		// 체크리스트 아이템 정보
		mav.addObject("checkListItemList", clSvc.getAllCheckListItem(issue));

		// 체크리스트 아이템 멤버 정보
		mav.addObject("checkListItemMemberList", clSvc.getAllCheckListItemMember(issue));

		mav.setViewName("/project/kanban");
		return mav;

	}

	@RequestMapping("/project/kanban2")
	public ModelAndView project_kanban2(int pNum, int tNum) {
		System.out.println("요청 url : /project/kanban2");
		ModelAndView mav = new ModelAndView();

		// 프로젝트 정보
		mav.addObject("project", pSvc.getProject(pNum));

		// 프로젝트 멤버 정보
		mav.addObject("projectMemberList", pSvc.getProjectMemberByPNum(pNum));

		// 태스크 정보
		Task task = new Task();
		task.setpNum(pNum);
		task.settNum(tNum);
		System.out.println("혹시? : " + tSvc.getTaskList(task));
		mav.addObject("task", tSvc.getTaskList(task));

		Gson gson = new Gson();
		Issue issue = new Issue();
		issue.setpNum(pNum);
		issue.settNum(tNum);
		String stringIssue = gson.toJson(iSvc.getIssueList(issue));
		JsonArray issueJson = new JsonParser().parse(stringIssue).getAsJsonArray();
		mav.addObject("issueList", issueJson);

		mav.setViewName("/project/kanban2");
		return mav;

	}
}
