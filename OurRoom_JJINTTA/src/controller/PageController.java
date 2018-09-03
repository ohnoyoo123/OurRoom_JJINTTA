package controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.Issue;
import model.IssueMember;
import model.Member;
import model.Project;
import model.ProjectMember;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.ProjectService;
import service.TaskService;

@Controller
public class PageController {

	@Autowired
	ProjectService pSvc;

	@Autowired
	TaskService tSvc;

	@Autowired
	IssueService iSvc;
	
	@Autowired
	CheckListService clSvc;

	@RequestMapping("/project/pList")
	public ModelAndView project() {
		System.out.println("요청 url : /project/pList");
		// 실제로는 세션에 있는 아이디값이 들어올 것임
		String mId = "hong123@gmail.com";

		System.out.println("mId : " + mId);
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> paramMId = new HashMap<String, Object>();
		paramMId.put("mId", mId);

		List<Project> pastProject = new ArrayList<Project>();
		List<Project> progProject = new ArrayList<Project>();
		List<Project> projectList = new ArrayList<Project>();

		projectList = pSvc.getProjectListByMId(paramMId);

		Calendar cl = Calendar.getInstance();

		for (Project p : projectList) {
			cl.setTime(new Date());
			int nYear = cl.get(Calendar.YEAR);
			int nMonth = cl.get(Calendar.MONTH) + 1;
			int nDay = cl.get(Calendar.DATE);

			cl.setTime(p.getpEndDate());
			int pYear = cl.get(Calendar.YEAR);
			int pMonth = cl.get(Calendar.MONTH) + 1;
			int pDay = cl.get(Calendar.DATE);

			if (nYear > pYear) {
				pastProject.add(p);
			} else if (nYear == pYear && nMonth > pMonth) {
				pastProject.add(p);
			} else if (nYear == pYear && nMonth == pMonth && nDay > pDay) {
				pastProject.add(p);
			} else {
				progProject.add(p);
			}

		}
		
		mav.addObject("pastProject", pastProject);
		mav.addObject("progProject", progProject);

		List<ProjectMember> pmList = new ArrayList<>();
		pmList = pSvc.getProjectMemberByMId(paramMId);
		mav.addObject("pmList", pmList);
		System.out.println(pmList);
		// System.out.println(projectList);

		mav.setViewName("/project/pList");
		return mav;
	}
	
	@RequestMapping("/project/gantt")
	public ModelAndView project_gantt(int pNum) {
		System.out.println("pNum : " + pNum);
		ModelAndView mav = new ModelAndView();

		mav.addObject("project", pSvc.getProject(pNum));

		Task task = new Task();
		task.setpNum(pNum);
		System.out.println("태스크 리스트 : " + tSvc.getTaskList(task));
		mav.addObject("taskList", tSvc.getTaskList(task));

		Issue issue = new Issue();
		issue.setpNum(pNum);
		mav.addObject("issueList", iSvc.getIssueList(issue));
		System.out.println("이슈리스트" + iSvc.getIssueList(issue));

		mav.addObject("projectMemberList", pSvc.getProjectMemberByPNum(pNum));

		mav.setViewName("/project/gantt");
		return mav;
	}
	
	@RequestMapping("/project/kanban")
	public ModelAndView project_kanban(int pNum, int tNum) {
		
		ModelAndView mav = new ModelAndView();
		
		//프로젝트 정보
		mav.addObject("project", pSvc.getProject(pNum));
		
		//프로젝트 멤버 정보
		mav.addObject("projectMemberList", pSvc.getProjectMemberByPNum(pNum));
		
		//태스크 정보
		Task task = new Task();
		task.setpNum(pNum);
		task.settNum(tNum);
		System.out.println("혹시? : " + tSvc.getTaskList(task));
		mav.addObject("task", tSvc.getTaskList(task));
		
		//이슈 정보
		Issue issue = new Issue();
		issue.setpNum(pNum);
		issue.settNum(tNum);
		mav.addObject("issueList", iSvc.getIssueList(issue));
		
		//이슈 멤버 정보
		IssueMember issueMember = new IssueMember();
		issueMember.setpNum(pNum);
		issueMember.settNum(tNum);
		mav.addObject("issueMemberList", iSvc.getIssueMember(issue));
		
		//체크리스트 정보(이슈 모델로 가져옴) ?? 이름을 이따구로??
		mav.addObject("checkListList", clSvc.getCheckList(issue));
		
		//체크리스트 아이템 정보
		mav.addObject("checkListItemList", clSvc.getAllCheckListItem(issue));
		
		//체크리스트 아이템 멤버 정보
		mav.addObject("checkListItemMemberList", clSvc.getAllCheckListItemMember(issue));
		
		mav.setViewName("/project/kanban");
		return mav;
		
	}
}
