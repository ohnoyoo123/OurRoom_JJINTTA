package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import model.CheckList;
import model.CheckListItem;
import model.Issue;

@Service
public class CheckListService {

	@Autowired
	CheckListDao clDao;
	
	public List<CheckList> selectCheckList(Issue issue){
		return clDao.selectAllCheckList(issue);
		
	}
	
	public List<CheckListItem> selectAllCheckListItem(Issue issue){
		return clDao.selectAllCheckListItem(issue);
		
	}
	
	//새 체크리스트 생성
	public void addCheckList(CheckList checkList) {
		clDao.insertCheckList(checkList);
		
	}

	//체크리스트 삭제하기!!
	public void deleteCheckList(CheckList checkList) {
		clDao.deleteCheckList(checkList);
		
	}
}
