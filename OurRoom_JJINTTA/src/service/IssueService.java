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
	
	//이슈 추가
	public void addIssue(Issue issue) {
		
		iDao.insertIssue(issue);
		
	}
	
	//이슈에 멤버 추가
	public void addIssueMember(IssueMember im) {
		iDao.insertIssueMember(im);
		
	}
	
	//이슈 삭제하면서 할당된 멤버도 삭제
	public void deleteIssue(Issue issue) {
//		iDao.deleteIssue(issue);
		System.out.println("호홍" + iDao.selectAllIssueMember(issue));
		
		
//		iDao.deleteIssueMember();
		
	}

}
