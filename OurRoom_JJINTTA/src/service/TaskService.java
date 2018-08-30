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
		System.out.println("dao : " + tDao.selectTask(task));
		return tDao.selectTask(task);
	}
	
	public void addTask(Task task) {
		System.out.println("task : " + task);
	}
}
