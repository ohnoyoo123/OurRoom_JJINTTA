package util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;

import model.Project;

public class ProjectUtil {

	/* 진행중인 프로젝트 리스트  */
	public static List<Project> progProject(List<Project> projectList) {
		List<Project> progProject = new ArrayList<Project>();
		Calendar cl = Calendar.getInstance();

		for (Project p : projectList) {
			cl.setTime(new Date());
			int nYear = cl.get(Calendar.YEAR);
			int nMonth = cl.get(Calendar.MONTH) + 1;
			int nDay = cl.get(Calendar.DATE);
			
			String endDate = p.getpEndDate();
			String[] spliteddate = endDate.split("-");
			int pYear = Integer.parseInt(spliteddate[0]);
			int pMonth = Integer.parseInt(spliteddate[1]);
			int pDay = Integer.parseInt(spliteddate[2]);
			

			if (nYear > pYear) {
			} else if (nYear == pYear && nMonth > pMonth) {
			} else if (nYear == pYear && nMonth == pMonth && nDay > pDay) {
			} else {
				progProject.add(p);
			}
		}

		System.out.println("진행중 : " + progProject);
		return progProject;
	}

	/* 마감된 프로젝트 리스트 */
	public static List<Project> pastProject(List<Project> projectList) {
		List<Project> pastProject = new ArrayList<>();
		

		Calendar cl = Calendar.getInstance();
		for (Project p : projectList) {
			cl.setTime(new Date());
			int nYear = cl.get(Calendar.YEAR);
			int nMonth = cl.get(Calendar.MONTH) + 1;
			int nDay = cl.get(Calendar.DATE);
			
			String endDate = p.getpEndDate();
			String[] spliteddate = endDate.split("-");
			int pYear = Integer.parseInt(spliteddate[0]);
			int pMonth = Integer.parseInt(spliteddate[1]);
			int pDay = Integer.parseInt(spliteddate[2]);
			

			if (nYear <= pYear) {
			} else if (nYear == pYear && nMonth <= pMonth) {
			} else if (nYear == pYear && nMonth == pMonth && nDay <= pDay) {
			} else {
				pastProject.add(p);
			}
		}
		
		System.out.println("끝난거 : " + pastProject);

		return pastProject;
	}
}
