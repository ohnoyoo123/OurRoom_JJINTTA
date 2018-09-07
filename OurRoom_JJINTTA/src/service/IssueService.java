package service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import dao.IssueDao;
import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Issue;
import model.IssueMember;

@Service
public class IssueService {
	
	@Autowired
	IssueDao iDao;
	
	@Autowired
	CheckListDao clDao;
	
	public List<Issue> getIssueList(Issue issue){
		return iDao.selectIssue(issue);
		
	}
	
	public List<IssueMember> getIssueMember(Issue issue){
		return iDao.selectAllIssueMember(issue);
	}
	
	//이슈 추가
	public void addIssue(Issue issue) {
		
		if(issue.getiStartDate() == "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			issue.setiStartDate(sdf.format(new Date()));
		}
		if(issue.getiEndDate() == "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			issue.setiEndDate(sdf.format(new Date()));
		}
		iDao.insertIssue(issue);
		
	}
	
	//이슈에 멤버 추가
	public void addIssueMember(IssueMember im) {
		iDao.insertIssueMember(im);
		
	}
	
	//이슈 삭제하면서 할당된 멤버도 삭제
	public void deleteIssue(Issue issue) {
		
		int pNum = issue.getpNum();
		int tNum = issue.gettNum();
		int iNum = issue.getiNum();
		
		//이슈 삭제
		iDao.deleteIssue(issue);
		
		//이슈 멤버 삭제
		IssueMember issueMember = new IssueMember();
		issueMember.setpNum(pNum);
		issueMember.settNum(tNum);
		issueMember.setiNum(iNum);
		iDao.deleteIssueMember(issueMember);
		
		//체크리스트 삭제
		CheckList checkList = new CheckList();
		checkList.setpNum(pNum);
		checkList.settNum(tNum);
		checkList.setiNum(iNum);
		clDao.deleteCheckList(checkList);
		
		//체크리스트 아이템 삭제
		CheckListItem checkListItem = new CheckListItem();
		checkListItem.setpNum(pNum);
		checkListItem.settNum(tNum);
		checkListItem.setiNum(iNum);
		clDao.deleteCheckListItem(checkListItem);
		
		//체크리스트 아이템 멤버 삭제
		CheckListItemMember checkListItemMember = new CheckListItemMember();
		checkListItemMember.setpNum(pNum);
		checkListItemMember.settNum(tNum);
		checkListItemMember.setiNum(iNum);
		clDao.deleteCheckListItemMember(checkListItemMember);

	}

}
