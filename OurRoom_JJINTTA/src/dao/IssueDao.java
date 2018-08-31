package dao;

import java.util.List;

import model.Issue;
import model.IssueMember;


public interface IssueDao {

	public List<Issue> selectIssue(Issue issue);
	
	public List<IssueMember> selectAllIssueMember(Issue issue);

	public void insertIssue(Issue issue);

	public void insertIssueMember(IssueMember im);

	public void deleteIssue(Issue issue);

	public void deleteIssueMember(IssueMember im);
	
}
