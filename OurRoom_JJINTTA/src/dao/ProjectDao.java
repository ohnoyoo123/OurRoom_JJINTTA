package dao;

import java.util.HashMap;
import java.util.List;

import model.Project;

public interface ProjectDao {

	public List<Project> selectProjectList(HashMap<String, Object> param);

	public Project selectProject(int pNum);
}
