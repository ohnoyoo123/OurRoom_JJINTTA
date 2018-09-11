package dao;

import java.util.HashMap;
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
	
	public List<Issue> selectIssueGreaterThanOrder(HashMap<String, Object> params);
	
	public void updateIssueOrder(Issue i);
	
	public void updateIssue(Issue issue);
	
	public void updateDraggedIssue(Issue issue);
	
	public int countIssuesInStep(Issue issue);
	
}
