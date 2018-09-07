package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import dao.IssueDao;
import dao.LogDao;
import dao.TaskDao;
import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Issue;
import model.Log;
import model.Task;

@Service
public class TaskService {

	@Autowired
	TaskDao tDao;

	@Autowired
	IssueDao iDao;

	@Autowired
	CheckListDao clDao;

	@Autowired
	LogDao lDao;
	
	@Autowired
	LogService logSvc;

	public List<Task> getTaskList(Task task) {
		return tDao.selectTask(task);
	}

	public void addTask(Task task, String loginUser) {
		tDao.insertTask(task);

		// 마지막 태스크 번호
		int lastTNum = tDao.selectTaskLastTNum(task.getpNum());
		task.settNum(lastTNum);
		// 로그남기기(태스크 생성 21)
		// log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", task);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.T_CREATE);

		logSvc.insertLog(logMap);
	}

	public void deleteTask(Task task) {
		// 태스크가 삭제되면 포함되어 있는 이슈, 체크리스트, 체크리스트 아이템, 체크리스트 아이템 멤버도 싹다 지우기

		int pNum = task.getpNum();
		int tNum = task.gettNum();

		// 태스크 삭제
		tDao.deleteTask(task);

		// 이슈 삭제
		Issue issue = new Issue();
		issue.setpNum(pNum);
		issue.settNum(tNum);
		iDao.deleteIssue(issue);

		// 체크리스트 삭제
		CheckList checkList = new CheckList();
		checkList.setpNum(pNum);
		checkList.settNum(tNum);
		clDao.deleteCheckList(checkList);

		// 체크리스트 아이템 삭제
		CheckListItem checkListItem = new CheckListItem();
		checkListItem.setpNum(pNum);
		checkListItem.settNum(tNum);
		clDao.deleteCheckListItem(checkListItem);

		// 체크리스트 아이템 멤버 삭제
		CheckListItemMember checkListItemMember = new CheckListItemMember();
		checkListItemMember.setpNum(pNum);
		checkListItemMember.settNum(tNum);
		clDao.deleteCheckListItemMember(checkListItemMember);
	}
}
