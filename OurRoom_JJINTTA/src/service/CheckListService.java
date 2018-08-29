package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CheckListDao;
import model.CheckList;
import model.Issue;

@Service
public class CheckListService {

	@Autowired
	CheckListDao clDao;
	
	public List<CheckList> selectCheckList(Issue issue){
		return clDao.selectAllCheckList(issue);
		
	}
}
