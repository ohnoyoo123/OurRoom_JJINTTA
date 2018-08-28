package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDao;
import model.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao mDao;

	// 회원가입 기능
	public int join(Member member) {

		return mDao.insertMember(member);

	}

	public List<Member> select() {
		// TODO Auto-generated method stub
		return mDao.selectMember();
	}

}
