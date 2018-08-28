package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ProjectDao;
import dao.TaskDao;
import model.Project;
import model.Task;

@Service
public class ProjectService {
	
	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	TaskDao taskDao;
	
	
	public List<Project> getProjectList(HashMap<String, Object> param){
		return projectDao.selectProjectList(param);
	}
	
	public List<Task> getTaskList(Task task){
		return taskDao.selectTask(task);
		
	}

	public Project getProject(int pNum) {
		return projectDao.selectProject(pNum);
	}
	
}
