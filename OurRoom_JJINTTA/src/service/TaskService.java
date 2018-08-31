package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.TaskDao;
import model.Task;

@Service
public class TaskService {

	@Autowired
	TaskDao tDao;
	
	public List<Task> getTaskList(Task task){
		return tDao.selectTask(task);
	}
	
	public void addTask(Task task) {
		tDao.insertTask(task);
	}

	public void deleteTask(Task task) {
		tDao.deleteTask(task);
		
	}
}
