package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IssueDao;
import model.Issue;

@Service
public class IssueService {
	
	@Autowired
	IssueDao issueDao;
	
	public List<Issue> getIssueList(Issue issue){
		return issueDao.selectIssue(issue);
		
	}

}
