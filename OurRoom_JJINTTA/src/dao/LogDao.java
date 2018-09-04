package dao;

import java.util.List;
import java.util.Map;

import model.Log;

public interface LogDao {

	public List<Log> selectLog(Log log);

	public List<Log> selectProjectLog(int pNum);
	
	/* 로그 넣기 */
	public void insertLog(Log log);

}
