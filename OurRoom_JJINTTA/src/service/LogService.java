package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.LogDao;
import model.Log;
@Service
public class LogService {
	
	@Autowired
	private LogDao lDao;
	
	/* 프로젝트 로그 조회 */
	public List<Log> getProjectLog(int pNum) {
		
		return lDao.selectProjectLog(pNum);
	}

}
