package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import dao.MemberDao;

public class MemberDaoTest {
	public static void main(String[] args) {
		ApplicationContext context = new GenericXmlApplicationContext("");
		System.out.println(context);
		MemberDao memberDao = context.getBean(MemberDao.class);
				//MemberDao memberDao = context.getBean("memberDao",MemberDao.class);
		
		System.out.println(memberDao.selectMember());
	}
}
