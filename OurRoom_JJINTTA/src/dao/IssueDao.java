package dao;

import java.util.List;

import model.Issue;
import model.IssueMember;


public interface IssueDao {

	public List<Issue> selectIssue(Issue issue);
	
	public List<IssueMember> selectAllIssueMember(Issue issue);
	
}
