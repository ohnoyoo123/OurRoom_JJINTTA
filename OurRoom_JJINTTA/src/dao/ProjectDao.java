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
	public List<ProjectMember> selectProjectMemberByMId(HashMap<String, Object> mId);
	
	//해당 프로젝트에 참가한 멤버 
	public List<ProjectMember> selectProjectMemberByPNum(int pNum);

	//프로젝트 새로 생성
	public int insertProject(Project project);
	
	//프로젝트에 멤버 추가(생성시만..?)
	public int insertProjectMember(ProjectMember projectMember);

}
