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
import model.Member;
import model.Project;
import model.ProjectMember;
import model.Task;
import service.IssueService;
import service.ProjectService;
import service.TaskService;
import util.ProjectUtil;

@Controller
public class PageController {

	@Autowired
	ProjectService projectSvc;

	@Autowired
	TaskService taskSvc;

	@Autowired
	IssueService issueSvc;

	@RequestMapping("/project/pList")
	public ModelAndView project() {
		// 실제로는 세션에 있는 아이디값이 들어올 것임
		String mId = "hong123@gmail.com";

		System.out.println("mId : " + mId);
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> paramMId = new HashMap<String, Object>();
		paramMId.put("mId", mId);

		List<Project> projectList = new ArrayList<Project>();

		projectList = projectSvc.getProjectListByMId(paramMId);
		// 진행중인 프로젝트와 마감된 프로젝트를 util클래스로 처리
		mav.addObject("pastProject", ProjectUtil.pastPojects(projectList));
		mav.addObject("progProject", ProjectUtil.progProject(projectList));

		List<ProjectMember> pmList = new ArrayList<>();
		pmList = projectSvc.getProjectMemberByMId(paramMId);
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

		mav.addObject("project", projectSvc.getProject(pNum));

		Task task = new Task();
		task.setpNum(pNum);
		System.out.println("태스크 리스트 : " + taskSvc.getTaskList(task));
		mav.addObject("taskList", taskSvc.getTaskList(task));

		Issue issue = new Issue();
		issue.setpNum(pNum);
		mav.addObject("issueList", issueSvc.getIssueList(issue));
		System.out.println("이슈리스트" + issueSvc.getIssueList(issue));

		mav.addObject("projectMemberList", projectSvc.getProjectMemberByPNum(pNum));

		mav.setViewName("/project/gantt");
		return mav;
	}
}
