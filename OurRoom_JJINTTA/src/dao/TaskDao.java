package dao;

import java.util.List;

import model.Task;

public interface TaskDao {

	public List<Task> selectTask(Task task);
}
