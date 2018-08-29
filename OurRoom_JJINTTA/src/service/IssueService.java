package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IssueDao;
import model.Issue;
import model.IssueMember;

@Service
public class IssueService {
	
	@Autowired
	IssueDao iDao;
	
	public List<Issue> getIssueList(Issue issue){
		return iDao.selectIssue(issue);
		
	}
	
	public List<IssueMember> getIssueMember(Issue issue){
		return iDao.selectAllIssueMember(issue);
	}

}
