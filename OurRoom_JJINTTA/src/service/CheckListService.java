package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import dao.LogDao;
import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Issue;
import model.Log;

@Service
public class CheckListService {

	@Autowired
	CheckListDao clDao;

	@Autowired
	LogDao lDao;

	@Autowired
	LogService lSvc;

	public List<CheckList> getCheckList(Issue issue) {
		return clDao.selectAllCheckList(issue);

	}

	public List<CheckListItem> getAllCheckListItem(Issue issue) {
		return clDao.selectAllCheckListItem(issue);

	}

	public List<CheckListItemMember> getAllCheckListItemMember(Issue issue) {
		return clDao.selectAllCheckListItemMember(issue);
	}

	// 새 체크리스트 생성
	public void addCheckList(CheckList checkList, String loginUser) {
		clDao.insertCheckList(checkList);

		int lastClNum = clDao.selectCheckListLastClNum(checkList);
		checkList.setClNum(lastClNum);

		// log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", checkList);
		logMap.put("lCat", Log.CL_CREATE);
		logMap.put("mId", loginUser);

		lSvc.insertLog(logMap);

	}

	// 체크리스트 삭제하기!!
	public void deleteCheckList(CheckList checkList, String loginUser) {
		int pNum = checkList.getpNum();
		int tNum = checkList.gettNum();
		int iNum = checkList.getiNum();
		
		checkList.setClName(clDao.selectCheckList(checkList).getClName());
		
		clDao.deleteCheckList(checkList);

		
		
		// 로그남기기(체크리스트 삭제 42)
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", checkList);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.CL_DELETE);

		lSvc.insertLog(logMap);

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

	// 체크리스트 아이템 생성
	public void addCheckListItem(Map<String, Object> param, String loginUser) {

		CheckListItem checkListItem = (CheckListItem) param.get("checkListItem");
		clDao.insertCheckListItem(checkListItem);
		System.out.println("첵템 : " + checkListItem);

		// log생성(체크리스트 아이템 추가 51)
		int lastCiNum = clDao.selectCheckListItemLastCiNum(checkListItem);
		checkListItem.setCiNum(lastCiNum);

		// log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", checkListItem);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.CI_CREATE);

		lSvc.insertLog(logMap);

		Issue issue = new Issue();
		issue.setpNum(checkListItem.getpNum());
		issue.settNum(checkListItem.gettNum());
		issue.setiNum(checkListItem.getiNum());

		List<CheckListItem> checkListItemList = clDao.selectAllCheckListItem(issue);
		int ciNum = checkListItemList.get(checkListItemList.size() - 1).getCiNum();

		List<String> members = (List<String>) param.get("members");

		if (members != null) {
			// 체크리스트 아이템 생성과 동시에 멤버추가 로그 생성
			logMap.put("lCat", Log.CI_ADD_MEMBER);
			lSvc.insertLog(logMap);

			// 직전에 삽입된 로그의 번호를 가져온다.
			int LastLNum = lDao.selectLogLastLNum(checkListItem.getpNum());
			for (String mId : members) {
				CheckListItemMember checkListItemMember = new CheckListItemMember();
				checkListItemMember.setmId(mId);
				checkListItemMember.setpNum(checkListItem.getpNum());
				checkListItemMember.settNum(checkListItem.gettNum());
				checkListItemMember.setiNum(checkListItem.getiNum());
				checkListItemMember.setClNum(checkListItem.getClNum());
				checkListItemMember.setCiNum(ciNum);
				clDao.insertCheckListItemMember(checkListItemMember);

				// 로그 남기기(체크리스트 아이템 멤버 할당 33)
				// 알림 생성
				Map<String, Object> notiMap = new HashMap<String, Object>();
				notiMap.put("pNum", checkListItem.getpNum());
				notiMap.put("mId", mId);
				notiMap.put("lNum", LastLNum);
				lSvc.insertNoti(notiMap);
			}

		}

	}

	// 체크리스트 아이템 지우면서 할당된 멤버도 같이 지우기
	public void deleteCheckListItem(CheckListItem checkListItem, String loginUser) {
		System.out.println("[CheckListService > deleteCheckListItem] : " + checkListItem);
		
		checkListItem.setCiName(clDao.selectCheckListItem(checkListItem).getCiName());
		
		clDao.deleteCheckListItem(checkListItem);
		
		// 로그남기기 (체크리스트 아이템 삭제 52)
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", checkListItem);
		logMap.put("mId", loginUser);
		logMap.put("lCat", Log.CI_DELETE);

		lSvc.insertLog(logMap);

		// 멤버 지우기
		CheckListItemMember checkListItemMember = new CheckListItemMember();
		checkListItemMember.setpNum(checkListItem.getpNum());
		checkListItemMember.settNum(checkListItem.gettNum());
		checkListItemMember.setiNum(checkListItem.getiNum());
		checkListItemMember.setClNum(checkListItem.getClNum());
		checkListItemMember.setCiNum(checkListItem.getCiNum());

		clDao.deleteCheckListItemMember(checkListItemMember);

	}

}
