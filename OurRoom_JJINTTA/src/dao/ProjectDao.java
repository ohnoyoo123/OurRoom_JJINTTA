package dao;

import java.util.HashMap;
import java.util.List;

import model.Project;
import model.ProjectMember;

public interface ProjectDao {
	//mId가 포함된 프로젝트
	public List<Project> selectProjectList(HashMap<String, Object> mId);

	public Project selectProject(int pNum);
	
	//mId가 포함된 프로젝트멤버
	public List<ProjectMember> selectProjectMember(HashMap<String, Object> mId);
}
