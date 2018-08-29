package dao;

import java.util.List;

import model.Issue;


public interface IssueDao {

	public List<Issue> selectIssue(Issue issue);
	
}
