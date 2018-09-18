package dao;

import java.util.List;

import model.CheckList;
import model.CheckListItem;
import model.CheckListItemMember;
import model.Issue;

public interface CheckListDao {

	// 필요한 정보가 같아서 체크리스트 대신 이슈 타입으로 매개 변수 지정
	public List<CheckList> selectAllCheckList(Issue issue);

	// 필요한 정보가 같아서 체크리스트 아이템 대신 이슈 타입으로 매개 변수 지정
	public List<CheckListItem> selectAllCheckListItem(Issue issue);

	public void insertCheckList(CheckList checkList);

	public void deleteCheckList(CheckList checkList);

	public void deleteCheckListItem(CheckListItem checkListItem);

	public void deleteCheckListItemMember(CheckListItemMember checkListItemMember);

	public void insertCheckListItem(CheckListItem checkListItem);

	public void insertCheckListItemMember(CheckListItemMember checkListItemMember);

	public List<CheckListItemMember> selectAllCheckListItemMember(Issue issue);

	public int selectCheckListLastClNum(CheckList checkList);

	public int selectCheckListItemLastCiNum(CheckListItem checkListItem);

	// 2018.09.13 [김승겸] : 체크리스트 아이템 조회
	public CheckListItem selectCheckListItem(CheckListItem checkListItem);

	// 2018.09.13 [김승겸] : 체크리스트 조회
	public CheckList selectCheckList(CheckList checkList);

	public void updateCheckListItem(CheckListItem checkListItem);

}
