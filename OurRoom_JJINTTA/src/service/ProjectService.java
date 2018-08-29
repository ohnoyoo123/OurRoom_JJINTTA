package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ProjectDao;
import dao.TaskDao;
import model.Project;
import model.ProjectMember;
import model.Task;

@Service
public class ProjectService {
	
	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	TaskDao taskDao;
	
	
	public List<Project> getProjectListByMId(HashMap<String, Object> mId){
		return projectDao.selectProjectList(mId);
	}
	public List<ProjectMember> getProjectMemberByMId(HashMap<String, Object> mId){
		return projectDao.selectProjectMember(mId);
	}
	
	public List<Task> getTaskList(Task task){
		return taskDao.selectTask(task);
		
	}

	public Project getProject(int pNum) {
		return projectDao.selectProject(pNum);
	}
	
}
