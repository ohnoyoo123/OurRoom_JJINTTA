package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dao.LogDao;
//import dao.LogDao;
import model.CheckList;
import model.CheckListItem;
import model.Comment;
import model.Issue;
import model.IssueMember;
import model.Log;
import model.Member;
import model.Noti;
import model.Project;
import model.ProjectMember;
import model.Task;
import service.CheckListService;
import service.IssueService;
import service.LogService;
//import service.LogService;
import service.MemberService;
import service.ProjectService;
import service.TaskService;

@RestController
public class ProjectRestController {

   @Autowired
   ProjectService pSvc;

   @Autowired
   IssueService iSvc;

   @Autowired
   CheckListService clSvc;

   @Autowired
   MemberService mSvc;

   @Autowired
   TaskService tSvc;

   @Autowired
   LogService lSvc;

   @Autowired
   LogDao lDao;

   @Autowired
   LogService logSvc;
   
   
   @PostMapping("/project/newProject")
   public int newProject(Project project, String owner,
         @RequestParam(value = "members[]", required = false) List<String> members) {

      HashMap<String, Object> params = new HashMap<String, Object>();
      
      params.put("project", project);
      params.put("owner", owner);
      params.put("projectMember", members);
      
      System.out.println("============================= new project!");
      System.out.println(project);

      return pSvc.addProject(params);
   }
   
   @PostMapping("/project/updateProject")
   public void updateProject(Project project) {
	   System.out.println("요청 url : /project/updateProject");
	   pSvc.updateProject(project);
	   
   }
   
   @PostMapping("/project/projectReload")
   public Map<String, Object> projectReload(Issue issue) {
	   System.out.println("요청 url : /project/projectReload");
	   System.out.println(issue);
      int pNum = issue.getpNum();
      issue.settNum(0);
      Map<String, Object> data = new HashMap<String, Object>();
      Task task = new Task();
      task.setpNum(pNum);
      data.put("projectJson", pSvc.getProject(issue.getpNum()));
      data.put("taskJson", tSvc.getTaskList(task));
      data.put("issueJson", iSvc.getIssueList(issue));
      return data;
      
   }
   
   @PostMapping("/project/projectDetail")
   public Map<String, Object> projectDetail(HttpSession session, Project project) {
      System.out.println("요청 url : /project/projectDetail");
      String mId = ((Member) session.getAttribute("loginUser")).getmId();
      System.out.println(project);
      System.out.println(mId);
      
      List<Member> addressList = mSvc.selectAddress(mId);
      System.out.println("어드레스 : " + addressList);
      
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("addressList", addressList);
      System.out.println(addressList);
      
      return data;
   }
   
   @PostMapping("/project/taskDetail")
   public Map<String, Object> taskDetail(Task task) {
      System.out.println("요청 url : /project/taskDetail");
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("taskList", tSvc.getTaskList(task));
      return data;
      
   }
   
   //날짜 비교용
   @PostMapping("/project/matchDate")
   public Map<String, Object> matchDate(Issue issue) {
      System.out.println("요청 url : /project/matchDate");
      System.out.println("매치데이트 이슈 : " + issue);
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("issueList", iSvc.getIssueList(issue));
      
      Task task = new Task();
      task.setpNum(issue.getpNum());
      task.settNum(issue.gettNum());
      data.put("taskList", tSvc.getTaskList(task));
      data.put("minIStartDate", iSvc.getMinIStartDate(issue));
      data.put("maxIEndDate", iSvc.getMaxIEndDate(issue));
      return data;
      
   }

   @PostMapping("/project/issueDetail")
   public Map<String, Object> issueDetail(Issue issue) {
      System.out.println("요청 url : /project/issueDetail");
      System.out.println(issue);
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("issueList", iSvc.getIssueList(issue));
      data.put("issueMember", iSvc.getIssueMember(issue));
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      System.out.println("data : " + data);
      return data;

   }

   @PostMapping("/project/memberSearch")
   public List<Member> memberSearch(String mId) {
      System.out.println("요청 url : " + "/project/memberSearch");
      System.out.println("==============================\n" + mId);
      System.out.println("검색값" + mSvc.memberSearch(mId));
      return mSvc.memberSearch(mId);
   }

   @PostMapping("/project/addTask")
   public Map<String, Object> addTask(HttpSession session, Task task) {

      System.out.println("요청 url : /project/addTask");
      System.out.println(task);

      String loginUser = ((Member) session.getAttribute("loginUser")).getmId();
      tSvc.addTask(task, loginUser);
      int pNum = task.getpNum();

      System.out.println("pNum : " + pNum);

      task.settNum(0);

      System.out.println("태스크 리스트 : " + tSvc.getTaskList(task));

      Map<String, Object> data = new HashMap<String, Object>();
      Issue issue = new Issue();
      issue.setpNum(pNum);

      // Gson gson = new Gson();
      // String stringProject = gson.toJson(pSvc.getProject(pNum));
      // JsonObject projectJson = new
      // JsonParser().parse(stringProject).getAsJsonObject();
      //
      // String stringTask = gson.toJson(tSvc.getTaskList(task));
      // JsonArray taskJson = new JsonParser().parse(stringTask).getAsJsonArray();
      //
      //
      // String stingIssue = gson.toJson(iSvc.getIssueList(issue));
      // JsonArray issueJson = new JsonParser().parse(stingIssue).getAsJsonArray();
      //
      // System.out.println("이슈리스트" + iSvc.getIssueList(issue));
      //
      // Map<String, Object> data = new HashMap<String, Object>();
      data.put("projectJson", pSvc.getProject(pNum));
      data.put("taskJson", tSvc.getTaskList(task));
      data.put("issueJson", iSvc.getIssueList(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;

   }
   
   @PostMapping("/project/updateTask")
   public Map<String, Object> updateTask(Task task) {
      System.out.println("요청 url : " + "/project/updateTask");
      tSvc.updateTask(task);
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("taskList", tSvc.getTaskList(task));
      return data;
   }

   @PostMapping("/project/deleteTask")
   public void deleteTask(Task task) {
      System.out.println("요청 url : " + "/project/deleteTask");
      tSvc.deleteTask(task);
   }

	@PostMapping("/project/addIssue")
	public Map<String, Object> addIssue(HttpSession session, Issue issue, @RequestParam(value = "members[]", required = false) List<String> members) {
		System.out.println("요청 url : " + "/project/addIssue");

		System.out.println(members);
		// String loginUser = ((Member)session.getAttribute("loginUser")).getmId();
		String loginUser = "hong123@gmail.com";

		Issue returnIssue = iSvc.addIssue(issue, loginUser);
		
		int pNum = issue.getpNum();
		
		if (members != null) {
			// 생성과 동시에 멤버추가 로그 생성
			Map<String, Object> logMap = new HashMap<String,Object>();
			logMap.put("target", returnIssue);
			logMap.put("mId", loginUser);
			logMap.put("lCat", Log.I_ADD_MEMBER);
			logSvc.insertLog(logMap);

			// 직전에 삽입된 로그의 번호를 가져온다.
			int LastLNum = lDao.selectLogLastLNum(returnIssue.getpNum());

			for (String mId : members) {
				IssueMember im = new IssueMember();
				im.setpNum(returnIssue.getpNum());
				im.settNum(returnIssue.gettNum());
				im.setiNum(returnIssue.getiNum());
				im.setmId(mId);
				iSvc.addIssueMember(im);
				
				// 로그 남기기(이슈 멤버추가 33)
				// 알림 생성
				Map<String, Object> notiMap = new HashMap<String, Object>();
				notiMap.put("pNum", returnIssue.getpNum());
				notiMap.put("mId", mId);
				notiMap.put("lNum", LastLNum);

				logSvc.insertNoti(notiMap);
			}
		}
		
		Task task = new Task();
		task.setpNum(pNum);
		int newInum = issue.getiNum();
		issue.setiOrder(iSvc.getIssueOrder(issue));
		int newOrder = issue.getiOrder();
		System.out.println("==============");
		System.out.println(newOrder);
		issue.settNum(0);
		issue.setiNum(0);
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("projectJson", pSvc.getProject(pNum));
		data.put("taskJson", tSvc.getTaskList(task));
		data.put("issueJson", iSvc.getIssueList(issue));
		data.put("commentList", iSvc.getCommentList(issue));
		data.put("newIssueNum", newInum);
		data.put("newIssueOrder", newOrder);
		
		System.out.println("=----==--------------------------------------------");
		System.out.println("이슈슈슈슈슈 : " + issue);
		System.out.println(tSvc.getTaskList(task));
		System.out.println(iSvc.getIssueList(issue));
		return data;
	}

   @PostMapping("/project/deleteIssue")
   public void deleteIssue(Issue issue) {
      System.out.println("요청 url : " + "/project/deleteIssue");
      iSvc.deleteIssue(issue);
   }

   // 체크리스트를 새로 추가하고 체크리스트 다 받아오기
   @PostMapping("/project/addCheckList")
   public Map<String, Object> addCheckList(CheckList checkList) {
      System.out.println("요청 url : " + "/project/addCheckList");
      clSvc.addCheckList(checkList);
      Issue issue = new Issue();
      issue.setpNum(checkList.getpNum());
      issue.settNum(checkList.gettNum());
      issue.setiNum(checkList.getiNum());
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;
   }

   // 체크리스트 삭제하고 체크리스트 다시!
   @PostMapping("/project/deleteCheckList")
   public Map<String, Object> deleteCheckList(CheckList checkList) {
      System.out.println("요청 url : " + "/project/deleteCheckList");
      clSvc.deleteCheckList(checkList);

      Issue issue = new Issue();
      issue.setpNum(checkList.getpNum());
      issue.settNum(checkList.gettNum());
      issue.setiNum(checkList.getiNum());
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;

   }

   // 체크리스트 아이템 생성하고 체크리스트 다시!!
   @PostMapping("/project/addCheckListItem")
   public Map<String, Object> addCheckListItem(CheckListItem checkListItem,
         @RequestParam(value = "members[]", required = false) List<String> members) {
      System.out.println("요청 url : /project/addCheckListItem");
      System.out.println(members);
      Map<String, Object> param = new HashMap<String, Object>();
      param.put("checkListItem", checkListItem);
      param.put("members", members);
      clSvc.addCheckListItem(param);

      // 새로운 체크리스트 불러와서 보내주기
      // 사실 이런것들을 서비스에서 해주면 좋을것 같은데??
      // 컨트롤러는 그냥 데이터 통로로만 사용하고 말이지?
      // 친구들과 상의해보고 결정할 것
      Issue issue = new Issue();
      issue.setpNum(checkListItem.getpNum());
      issue.settNum(checkListItem.gettNum());
      issue.setiNum(checkListItem.getiNum());
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;

   }

   @PostMapping("/project/deleteCheckListItem")
   public Map<String, Object> deleteCheckListItem(CheckListItem checkListItem) {
      System.out.println("요청 url : /project/deleteCheckListItem");
      clSvc.deleteCheckListItem(checkListItem);

      Issue issue = new Issue();
      issue.setpNum(checkListItem.getpNum());
      issue.settNum(checkListItem.gettNum());
      issue.setiNum(checkListItem.getiNum());
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;

   }
   
   //체크리스트 아이템 변경
   @PostMapping("/project/updateCheckListItem")
   public Map<String, Object> updateCheckListItem(CheckListItem checkListItem) {
		System.out.println("요청 url : /project/updateCheckListItem");
		System.out.println(checkListItem);
		clSvc.updateCheckListItem(checkListItem);
		
		Issue issue = new Issue();
		issue.setpNum(checkListItem.getpNum());
		issue.settNum(checkListItem.gettNum());
		issue.setiNum(checkListItem.getiNum());
		
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("issueList", iSvc.getIssueList(issue));
		data.put("issueMember", iSvc.getIssueMember(issue));
		data.put("checkList", clSvc.getCheckList(issue));
		data.put("checkListItem", clSvc.getAllCheckListItem(issue));
		data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
	    data.put("commentList", iSvc.getCommentList(issue));
	    
		return data;
   }
   
   //이슈 변경
   @PostMapping("/project/updateIssue")
   public Map<String, Object> issueUpdate(Issue issue) {
      System.out.println("요청 url : /project/updateIssue");
      System.out.println(issue);
      iSvc.updateIssue(issue);
//      issue.settNum(0);
      
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("issueList", iSvc.getIssueList(issue));
      data.put("issueMember", iSvc.getIssueMember(issue));
      data.put("checkList", clSvc.getCheckList(issue));
      data.put("checkListItem", clSvc.getAllCheckListItem(issue));
      data.put("checkListItemMember", clSvc.getAllCheckListItemMember(issue));
      data.put("commentList", iSvc.getCommentList(issue));
      return data;

   }
   
   //코멘트 입력
   @PostMapping("/project/addComment")
   public Map<String, Object> addComment(Comment comment) {
      System.out.println("요청 url : /project/addComment");
      iSvc.addComment(comment);
      Map<String, Object> data = new HashMap<String, Object>();
      Issue issue = new Issue();
      issue.setpNum(comment.getpNum());
      issue.settNum(comment.gettNum());
      issue.setiNum(comment.getiNum());
      data.put("commentList", iSvc.getCommentList(issue));
      return data;
      
      
   }
   
   //코멘트 삭제
   @PostMapping("/project/deleteComment")
   public Map<String, Object> deleteComment(Comment comment) {
	      System.out.println("요청 url : /project/deleteComment");
	      System.out.println(comment);
	      iSvc.deleteComment(comment);
	      Map<String, Object> data = new HashMap<String, Object>();
	      Issue issue = new Issue();
	      issue.setpNum(comment.getpNum());
	      issue.settNum(comment.gettNum());
	      issue.setiNum(comment.getiNum());
	      data.put("commentList", iSvc.getCommentList(issue));
	      return data;
   }
   
   @PostMapping("/project/issueOrderChange")
   public List<Issue> issueOrderChange(@RequestParam HashMap<String, Object> params){
      System.out.println(params);
      
      return iSvc.orderChange(params);
   }
   
   @PostMapping("/project/getTasks")
   public List<Task> getTasksByPnum(@RequestParam int pNum){
      Task task = new Task();
      task.setpNum(pNum);
      return tSvc.getTaskList(task);      
   }
   
   @PostMapping("/project/projectChart")
   public Map<String, Object> projectChart(int pNum){
	   System.out.println("요청 url : /project/projectChart");
	   
	   Task task = new Task();
	   task.setpNum(pNum);
	   
	   Issue issue = new Issue();
	   issue.setpNum(pNum);
	   
	   Map<String, Object> data = new HashMap<String, Object>();
	   data.put("project", pSvc.getProject(pNum));
	   data.put("projectMemberList", pSvc.getProjectMemberByPNum(pNum));
	   data.put("taskList", tSvc.getTaskList(task));
	   data.put("issueList", iSvc.getIssueList(issue));
	   data.put("issueMemberList", iSvc.getIssueMember(issue));
	   
	   return data;
	   
   }
   
   @PostMapping("/project/updateProjectMember")
   public Map<String, Object> updateProjectMember(ProjectMember projectMember) {
	   System.out.println("요청 url : /project/updateProjectMember");
	   pSvc.updateProjectMember(projectMember);
	   Map<String, Object> data = new HashMap<String, Object>();
	   data.put("project", pSvc.getProject(projectMember.getpNum()));
	   
	   return data;
	   
   }
   
   @PostMapping("/project/getNickname")
   public String getNickname(String mId) {
	   System.out.println("요청 url : /project/getNickname");
	   System.out.println(mId);
	   System.out.println(mSvc.selectNicknameById(mId));
	   return mSvc.selectNicknameById(mId);
	   
   }
   
}