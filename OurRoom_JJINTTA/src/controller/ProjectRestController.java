package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public @ResponseBody Map<String, Object> issueDetail(Issue issue) {
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("issue", iSvc.getIssueList(issue));
		data.put("checkList", clSvc.selectCheckList(issue));
		System.out.println(data);
		return data;
		
	}
	@PostMapping("/project/memberSearch")
	public List<Member> memberSearch(String mId) {
		System.out.println("==============================\n"+mId);	
		System.out.println(mSvc.select());
		return mSvc.select();
	}
}
