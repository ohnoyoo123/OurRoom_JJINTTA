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
		// System.out.println("프로젝트 넘버:"+project.getpNum());

		System.out.println("멤버!!!!!!!!!!!!!!!" + pmList);

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
			}

		}
		ProjectMember owner = new ProjectMember();
		owner.setmId((String) params.get("owner"));
		owner.setpNum(project.getpNum());
		owner.setPmFav(false);
		owner.setPmIsAdmin(true);
		owner.setPmIsAuth(true);
		projectDao.insertProjectMember(owner);

		// 로그남기기
		Log log = new Log();
		log.setpNum(project.getpNum());
		log.setmId((String) params.get("owner"));
		log.setlCat(11);
		logDao.insertLog(log);

		return project.getpNum();
	}

	// 프로젝트 번호로 참가 인원 가져오기
	public List<ProjectMember> getProjectMemberByPNum(int pNum) {
		return projectDao.selectProjectMemberByPNum(pNum);

	}

}
