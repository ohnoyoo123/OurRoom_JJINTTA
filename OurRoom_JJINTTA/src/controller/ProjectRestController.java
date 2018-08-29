package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import model.Issue;
import service.CheckListService;
import service.IssueService;

@RestController
public class ProjectRestController {

	@Autowired
	IssueService iSvc;
	
	@Autowired
	CheckListService clSvc;
	
	@PostMapping("/project/issueDetail")
	public void issueDetail(Issue issue) {
		System.out.println(iSvc.getIssueList(issue));
		System.out.println(clSvc.selectCheckList(issue));
		
	}
}
