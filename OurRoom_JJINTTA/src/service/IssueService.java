package service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import dao.IssueDao;
import dao.LogDao;
//import dao.LogDao;
import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Comment;
import model.Issue;
import model.IssueMember;
import model.Log;

@Service
public class IssueService {

	@Autowired
	IssueDao iDao;

	@Autowired
	CheckListDao clDao;

	@Autowired
	LogDao lDao;

	@Autowired
	LogService logSvc;

	public List<Issue> getIssueList(Issue issue) {
		return iDao.selectIssue(issue);

	}

	public int getIssueOrder(Issue issue) {
		return iDao.getIorder(issue);
	}

	public List<IssueMember> getIssueMember(Issue issue) {
		return iDao.selectAllIssueMember(issue);
	}

	// 이슈 추가
	public Issue addIssue(Issue issue, String loginUser) {

		System.out.println("===이슈 서비스===" + issue);
		if (issue.getiStartDate() == "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			issue.setiStartDate(sdf.format(new Date()));
		}
		if (issue.getiEndDate() == "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			issue.setiEndDate(sdf.format(new Date()));
		}
		iDao.insertIssue(issue);
		// 마지막 태스크 번호
		int lastINum = iDao.selectIssue(issue).size();
		issue.setiNum(lastINum);
		// 로그남기기(이슈 생성 31)
		// log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", issue);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.I_CREATE);
		logSvc.insertLog(logMap);

		return issue;

	}

	// 이슈에 멤버 추가
	public void addIssueMember(IssueMember im) {

		iDao.insertIssueMember(im);

	}

	// 이슈 삭제하면서 할당된 멤버도 삭제
	public void deleteIssue(Issue issue, String loginUser) {

		int pNum = issue.getpNum();
		int tNum = issue.gettNum();
		int iNum = issue.getiNum();

		// 이슈 삭제
		iDao.deleteIssue(issue);

		// 로그남기기(이슈 삭제 32)
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", issue);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.I_DELETE);

		logSvc.insertLog(logMap);

		// 이슈 멤버 삭제
		IssueMember issueMember = new IssueMember();
		issueMember.setpNum(pNum);
		issueMember.settNum(tNum);
		issueMember.setiNum(iNum);
		iDao.deleteIssueMember(issueMember);

		// 체크리스트 삭제
		CheckList checkList = new CheckList();
		checkList.setpNum(pNum);
		checkList.settNum(tNum);
		checkList.setiNum(iNum);
		clDao.deleteCheckList(checkList);

		// 체크리스트 아이템 삭제
		CheckListItem checkListItem = new CheckListItem();
		checkListItem.setpNum(pNum);
		checkListItem.settNum(tNum);
		checkListItem.setiNum(iNum);
		clDao.deleteCheckListItem(checkListItem);

		// 체크리스트 아이템 멤버 삭제
		CheckListItemMember checkListItemMember = new CheckListItemMember();
		checkListItemMember.setpNum(pNum);
		checkListItemMember.settNum(tNum);
		checkListItemMember.setiNum(iNum);
		clDao.deleteCheckListItemMember(checkListItemMember);

	}

	// 이슈 업데이트
	public void updateIssue(Issue issue) {
		iDao.updateIssue(issue);

	}

	public void deleteComment(Comment comment) {
		iDao.deleteComment(comment);
		comment.setCmSuper(comment.getCmNum());
		comment.setCmNum(0);
		iDao.deleteComment(comment);

	}

	public void addComment(Comment comment) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		comment.setCmWriteTime(sdf.format(new Date()));
		iDao.insertComment(comment);

		// log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", comment);
		logMap.put("mId", comment.getmId());
		logMap.put("lCat", Log.CM_ADD);

		logSvc.insertLog(logMap);

	}

	public List<Comment> getCommentList(Issue issue) {
		return iDao.selectComment(issue);
	}

	public Issue getMinIStartDate(Issue issue) {
		return iDao.selectMinStartDate(issue);
	}

	public Issue getMaxIEndDate(Issue issue) {
		return iDao.selectMaxEndDate(issue);
	}

	public List<Issue> orderChange(HashMap<String, Object> params) {
		int pNum = Integer.parseInt((String) (params.get("pNum")));
		int tNum = Integer.parseInt((String) (params.get("tNum")));
		int iNumSource = Integer.parseInt((String) (params.get("iNum")));

		String firstStep = (String) params.get("firstStep");
		int stepFrom = orderTranslate(firstStep);
		String finalStep = (String) params.get("finalStep");
		int stepTo = orderTranslate(finalStep);

		int iOrderFormer = Integer.parseInt((String) (params.get("iOrderFormer")));
		int iOrderLatter = Integer.parseInt((String) (params.get("iOrderLatter")));

		params.put("iStep", stepFrom);
		params.put("iOrder", iOrderFormer);

		List<Issue> issuesOfFormerStep = iDao.selectIssueGreaterThanOrder(params);
		System.out.println("이동전 이슈리스트 ==========" + issuesOfFormerStep);
		for (Issue i : issuesOfFormerStep) {
			i.setiOrder(i.getiOrder() - 1);
			iDao.updateIssueOrder(i);
		}

		Issue issue = new Issue();
		issue.setpNum(pNum);
		issue.settNum(tNum);
		issue.setiNum(iNumSource);
		issue.setiStep(stepTo);

		if (iOrderLatter != 0) {
			params.put("iStep", stepTo);
			params.put("iOrder", iOrderLatter);

			List<Issue> issuesOfLatterStep = iDao.selectIssueGreaterThanOrder(params);
			System.out.println("이동후 이슈리스트 ==========" + issuesOfLatterStep);
			for (Issue i : issuesOfLatterStep) {
				i.setiOrder(i.getiOrder() + 1);
				iDao.updateIssueOrder(i);
			}
			issue.setiOrder(iOrderLatter);
			iDao.updateDraggedIssue(issue);
		} else {
			int lastOrder = iDao.countIssuesInStep(issue);
			issue.setiOrder(lastOrder + 1);
			iDao.updateDraggedIssue(issue);
		}

		Issue i = new Issue();
		i.setiOrder(0);
		return iDao.selectIssue(i);
	}

	public int orderTranslate(String steps) {
		int stepInNum = 0;
		switch (steps) {
		case "Ideas":
			stepInNum = 0;
			break;
		case "ToDo":
			stepInNum = 1;
			break;
		case "Doing":
			stepInNum = 2;
			break;
		case "Done":
			stepInNum = 3;
			break;
		case "Review":
			stepInNum = 4;
			break;
		default:
			break;
		}
		return stepInNum;
	}
}