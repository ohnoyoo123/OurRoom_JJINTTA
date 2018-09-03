package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Issue;

@Service
public class CheckListService {

	@Autowired
	CheckListDao clDao;
	
	public List<CheckList> getCheckList(Issue issue){
		return clDao.selectAllCheckList(issue);
		
	}
	
	public List<CheckListItem> getAllCheckListItem(Issue issue){
		return clDao.selectAllCheckListItem(issue);
		
	}
	
	public List<CheckListItemMember> getAllCheckListItemMember(Issue issue) {
		return clDao.selectAllCheckListItemMember(issue);
	}

	
	//새 체크리스트 생성
	public void addCheckList(CheckList checkList) {
		clDao.insertCheckList(checkList);
		
	}

	//체크리스트 삭제하기!!
	public void deleteCheckList(CheckList checkList) {
		clDao.deleteCheckList(checkList);
		
	}

	//체크리스트 아이템 생성
	public void addCheckListItem(Map<String, Object> param) {
		
		CheckListItem checkListItem = (CheckListItem) param.get("checkListItem");
		clDao.insertCheckListItem(checkListItem);
		System.out.println("첵템 : " + checkListItem);
		
		Issue issue = new Issue();
		issue.setpNum(checkListItem.getpNum());
		issue.settNum(checkListItem.gettNum());
		issue.setiNum(checkListItem.getiNum());
		
		List<CheckListItem> checkListItemList = clDao.selectAllCheckListItem(issue);
		int ciNum = checkListItemList.get(checkListItemList.size()-1).getCiNum();
		
		List<String> members = (List<String>) param.get("members");
		if(members != null) {
			for(String mId : members) {
				CheckListItemMember checkListItemMember = new CheckListItemMember();
				checkListItemMember.setmId(mId);
				checkListItemMember.setpNum(checkListItem.getpNum());
				checkListItemMember.settNum(checkListItem.gettNum());
				checkListItemMember.setiNum(checkListItem.getiNum());
				checkListItemMember.setClNum(checkListItem.getClNum());
				checkListItemMember.setCiNum(ciNum);
				clDao.insertCheckListItemMember(checkListItemMember);
			}

		}
		
		
	}

	//체크리스트 아이템 지우면서 할당된 멤버도 같이 지우기
	public void deleteCheckListItem(CheckListItem checkListItem) {
		System.out.println("헤헤헹 : " + checkListItem);
		clDao.deleteCheckListItem(checkListItem);
		
		//멤버 지우기
		CheckListItemMember checkListItemMember = new CheckListItemMember();
		checkListItemMember.setpNum(checkListItem.getpNum());
		checkListItemMember.settNum(checkListItem.gettNum());
		checkListItemMember.setiNum(checkListItem.getiNum());
		checkListItemMember.setClNum(checkListItem.getClNum());
		checkListItemMember.setCiNum(checkListItem.getCiNum());
		
		clDao.deleteCheckListItemMember(checkListItemMember);
		
	}

}
