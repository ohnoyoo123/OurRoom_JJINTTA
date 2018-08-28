package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.websocket.server.PathParam;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.Issue;
import model.Project;
import model.Task;
import service.IssueService;
import service.ProjectService;
import service.TaskService;


@Controller
public class PageController {
	
	@Autowired
	ProjectService projectSvc;
	
	@Autowired
	TaskService taskSvc;
	
	@Autowired
	IssueService issueSv;
	
	
	
	
	
	@RequestMapping("/home")
	public String home() {
		System.out.println("home");
		return "/home/home";
	}
	
	@RequestMapping("/project/{mId}")
	public ModelAndView project(String mId) {
		System.out.println("mId : " + mId);
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("mId", mId);
		
		List<Project> projectList = new ArrayList<Project>();
		List<Task> taskList = new ArrayList<Task>();
		
		
		projectList = projectSvc.getProjectListByMId(param);
		
		for(int i = 0; i < projectList.size(); i++) {
			Task task = new Task();
			task.setpNum(projectList.get(i).getpNum());
			taskList.add(task);
		}
		
		mav.addObject("projectList", projectList);
		mav.addObject("taskList", taskList);
		
		System.out.println(projectList);
		System.out.println(taskList);
		
		mav.setViewName("/project/project");
		return mav;
	}
	
	@RequestMapping("/project/gantt")
	public ModelAndView project_gantt(int pNum) {
		System.out.println("pNum : " + pNum);
		ModelAndView mav = new ModelAndView();
		mav.addObject("project", projectSvc.getProject(pNum));
		
		Task task = new Task();
		task.setpNum(pNum);
		mav.addObject("taskList", taskSvc.getTaskList(task));
		
		Issue issue = new Issue();
		issue.setpNum(pNum);
		mav.addObject("isseList", issueSv.getIssueList(issue));
		
		mav.setViewName("/project/gantt");
		
		return mav;
	}
	
	@RequestMapping("/address")
	public String address() {
		return "/address/address";
	}
	
	@RequestMapping("/myPage")
	public String myPage() {
		return "/myPage/myPage";
	}
}
