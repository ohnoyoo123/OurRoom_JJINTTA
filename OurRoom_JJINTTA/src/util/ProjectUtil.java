package util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import model.Project;

public class ProjectUtil {

	/* 진행중인 프로젝트 리스트  */
	public static List<Project> pastPojects(List<Project> projectList) {
		List<Project> pastProject = new ArrayList<>();

		Calendar cl = Calendar.getInstance();
		for (Project p : projectList) {
			cl.setTime(new Date());
			int nYear = cl.get(Calendar.YEAR);
			int nMonth = cl.get(Calendar.MONTH) + 1;
			int nDay = cl.get(Calendar.DATE);

			cl.setTime(p.getpEndDate());
			int pYear = cl.get(Calendar.YEAR);
			int pMonth = cl.get(Calendar.MONTH) + 1;
			int pDay = cl.get(Calendar.DATE);

			if (nYear > pYear) {
				pastProject.add(p);
			} else if (nYear == pYear && nMonth > pMonth) {
				pastProject.add(p);
			} else if (nYear == pYear && nMonth == pMonth && nDay > pDay) {
				pastProject.add(p);
			}

		}

		return pastProject;
	}

	/* 마감된 프로젝트 리스트 */
	public static List<Project> progProject(List<Project> projectList) {
		List<Project> progProject = new ArrayList<>();

		Calendar cl = Calendar.getInstance();
		for (Project p : projectList) {
			cl.setTime(new Date());
			int nYear = cl.get(Calendar.YEAR);
			int nMonth = cl.get(Calendar.MONTH) + 1;
			int nDay = cl.get(Calendar.DATE);

			cl.setTime(p.getpEndDate());
			int pYear = cl.get(Calendar.YEAR);
			int pMonth = cl.get(Calendar.MONTH) + 1;
			int pDay = cl.get(Calendar.DATE);

			if (nYear > pYear) {
			} else if (nYear == pYear && nMonth > pMonth) {
			} else if (nYear == pYear && nMonth == pMonth && nDay > pDay) {
			} else {
				progProject.add(p);
			}
		}

		return progProject;
	}
}
