package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.LogDao;
import dao.ProjectDao;
import dao.TaskDao;
import model.Log;
import model.LogMember;
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

		// 로그남기기(프로젝트 생성 11)
		Log log = new Log();
		log.setpNum(project.getpNum());
		log.setmId((String) params.get("owner"));
		log.setlCat(11);
		logDao.insertLog(log);
		
		System.out.println("멤버!!!!!!!!!!!!!!!" + pmList);
		// 직전에 삽입된 로그의 번호를 가져온다.
		int LastLNum = logDao.selectLogLastLNum(log.getpNum());
		
		// null point exception때문에
		if (pmList != null) {
			for (String mId : pmList) {
				ProjectMember pm = new ProjectMember();
				pm.setmId(mId);
				pm.setpNum(project.getpNum());
				pm.setPmFav(false);
				pm.setPmIsAdmin(false);
				pm.setPmIsAuth(false);
				projectDao.insertProjectMember(pm);
				
				// 로그남기기(프로젝트 멤버 11)
				Noti noti = new Noti();
				noti.setpNum(project.getpNum());
				noti.setmId(mId);
				noti.setlNum(LastLNum);
				logDao.insertNoti(noti);
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
