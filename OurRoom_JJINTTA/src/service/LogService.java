package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.LogDao;
import model.CheckList;
import model.CheckListItem;
import model.Comment;
import model.Issue;
import model.Log;
import model.Noti;
import model.Project;
import model.Task;

@Service
public class LogService {

	@Autowired
	private LogDao logDao;

	/* 프로젝트 로그 조회 */
	public List<Log> getProjectLog(int pNum) {

		return logDao.selectProjectLog(pNum);
	}

	/* 알림 읽음 처리 */
	public List<Noti> readAndGetNoti(Noti noti) {

		logDao.updateNoti(noti);
		return logDao.selectNoti(noti);
	}
	
	/* 로그 생성 */
	public void insertLog(Map<String, Object> logMap) {
		System.out.println("[insertLog] logMap : " + logMap);

		int lCat = (int) logMap.get("lCat");
		Object target = logMap.get("target");
		Log log = new Log();
		
		Project project = null;
		Task task = null;
		Issue issue = null;
		CheckList checkList = null;
		CheckListItem checkListItem = null;
		Comment comment = null;
		
		switch (lCat) {
		case Log.P_CREATE:
		case Log.P_ADD_MEMBER:
		case Log.P_DELETE_MEMBER:
		case Log.P_UPDATE_NAME:
			project = (Project) target;
			log.setpNum(project.getpNum());
			
			log.setlName(project.getpName());
			
			break;
		case Log.T_CREATE:
			task = (Task) target;
			log.setpNum(task.getpNum());
			log.settNum(task.gettNum());			
			log.setlName(task.gettName());
			
			break;
			
		case Log.I_CREATE:
		case Log.I_DELETE:
		case Log.I_ADD_MEMBER:
			issue = (Issue) target;
			log.setpNum(issue.getpNum());
			log.settNum(issue.gettNum());
			log.setiNum(issue.getiNum());	
			log.setlName(issue.getiName());
			
			break;
		case Log.CL_CREATE:
		case Log.CL_DELETE:
			checkList = (CheckList) target;
			log.setpNum(checkList.getpNum());
			log.settNum(checkList.gettNum());
			log.setiNum(checkList.getiNum());
			log.setiNum(checkList.getiNum());
			log.setClNum(checkList.getClNum());
			
			log.setlName(checkList.getClName());
			
			break;
		case Log.CI_CREATE:
		case Log.CI_DELETE:
		case Log.CI_ADD_MEMBER:
			checkListItem = (CheckListItem) target;
			log.setpNum(checkListItem.getpNum());
			log.settNum(checkListItem.gettNum());
			log.setiNum(checkListItem.getiNum());
			log.setiNum(checkListItem.getiNum());
			log.setClNum(checkListItem.getClNum());
			log.setCiNum(checkListItem.getCiNum());
			log.setlName(checkListItem.getCiName());
			
			break;
		case Log.CM_ADD:
		case Log.CM_ADD_MEMBER:		
			comment = (Comment) target;
			log.setpNum(comment.getpNum());
			log.settNum(comment.gettNum());
			log.setiNum(comment.getiNum());
			log.setCmNum(comment.getCmNum());
			log.setlName(comment.getCmContent());
			
			break;
		}
		log.setmId((String) logMap.get("mId"));
		log.setlCat(lCat);
		logDao.insertLog(log);
	}
	
	/* 로그 생성 */
	public void insertNoti(Map<String, Object> notiMap) {
		System.out.println("[insertNoti] notiMap : " + notiMap);

		int pNum = (int) notiMap.get("pNum");
		String mId = (String) notiMap.get("mId");
		int lNum = (int) notiMap.get("lNum");
		Noti noti = new Noti();

		noti.setpNum(pNum);
		noti.setmId(mId);
		noti.setlNum(lNum);
		logDao.insertNoti(noti);

	}

}
