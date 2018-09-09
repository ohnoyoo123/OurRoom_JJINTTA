package dao;

import java.util.List;
import java.util.Map;

import model.Log;
import model.Noti;

public interface LogDao {

	public List<Log> selectLog(Log log);

	public List<Log> selectProjectLog(int pNum);
	
	/* 로그 넣기 */
	public void insertLog(Log log);
	
	/* 알림 넣기 */
	public void insertNoti(Noti noti);
	
	/* 프로젝트에 해당하는 마지막 로그 가져오기 */
	public int selectLogLastLNum(int pNum);
	
	/* 알림 가져오기 */
	public List<Noti> selectUnreadNoti(Noti noti);

	public int updateNoti(Noti noti);

	public List<Noti> selectNoti(Noti noti);
}
