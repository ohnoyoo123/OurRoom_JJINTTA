package dao;

import java.util.List;

import model.Task;

public interface TaskDao {

	public List<Task> selectTask(Task task);
	
	public void insertTask(Task task);

	public int deleteTask(Task task);
	
	/* 마지막 태스크번호 가져오기 */
	public int selectTaskLastTNum(int pNum);

	public void updateTask(Task task);
}
