package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.LogDao;
import dao.ProjectDao;
import dao.TaskDao;
import model.Log;
import model.Noti;
import model.Project;
import model.ProjectMember;
import model.Task;

@Service
public class ProjectService {

	@Autowired
	ProjectDao projectDao;

	@Autowired
	TaskDao taskDao;

	@Autowired
	LogDao logDao;

	@Autowired
	LogService logSvc;

	public List<Project> getProjectListByMId(HashMap<String, Object> mId) {
		return projectDao.selectProjectList(mId);
	}

	public List<ProjectMember> getProjectMemberByMId(HashMap<String, Object> mId) {
		return projectDao.selectProjectMemberByMId(mId);
	}

	public List<Task> getTaskList(Task task) {
		return taskDao.selectTask(task);

	}

	public Project getProject(int pNum) {
		return projectDao.selectProject(pNum);
	}

	public int addProject(HashMap<String, Object> params) {
		Project project = (Project) params.get("project");
		List<String> pmList = (List<String>) params.get("projectMember");
		project.setpBackground("pexels");
		projectDao.insertProject(project);
	
		//log생성
		Map<String, Object> logMap = new HashMap<String, Object>();
		logMap.put("target", project);
		logMap.put("lCat", Log.P_CREATE);
		logMap.put("mId", (String) params.get("mId"));
		
		logSvc.insertLog(logMap);

		// null point exception때문에
		if (pmList != null) {
			// 생성과 동시에 멤버추가 로그 생성
			logMap.put("lCat",Log.P_ADD_MEMBER);
			logSvc.insertLog(logMap);
			
			// 직전에 삽입된 로그의 번호를 가져온다.
			int LastLNum = logDao.selectLogLastLNum(project.getpNum()); 
			
			for (String mId : pmList) {
				ProjectMember pm = new ProjectMember();
				pm.setmId(mId);
				pm.setpNum(project.getpNum());
				pm.setPmFav(false);
				pm.setPmIsAdmin(false);
				pm.setPmIsAuth(false);
				projectDao.insertProjectMember(pm);
				
				// 알림 생성
				Map<String, Object> notiMap = new HashMap<String, Object>();
				notiMap.put("pNum", project.getpNum());
				notiMap.put("mId", mId);
				notiMap.put("lNum", LastLNum);
				
				logSvc.insertNoti(notiMap);
			}

		}
		ProjectMember owner = new ProjectMember();
		owner.setmId((String) params.get("owner"));
		owner.setpNum(project.getpNum());
		owner.setPmFav(false);
		owner.setPmIsAdmin(true);
		owner.setPmIsAuth(true);
		projectDao.insertProjectMember(owner);

		return project.getpNum();

	}

	// 프로젝트 번호로 참가 인원 가져오기
	public List<ProjectMember> getProjectMemberByPNum(int pNum) {
		return projectDao.selectProjectMemberByPNum(pNum);

	}

}
