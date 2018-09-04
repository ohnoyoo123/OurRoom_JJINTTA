package dao;

import java.util.List;

import model.Task;

public interface TaskDao {

	public List<Task> selectTask(Task task);
	
	public void insertTask(Task task);

	public int deleteTask(Task task);
}
