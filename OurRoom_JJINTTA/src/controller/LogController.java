//package controller;
//
//import java.util.List;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import model.Log;
//import service.LogService;
//import websocket.SocketHandler;
//
//@RestController
//public class LogController {
//
//	@Autowired
//	private LogService logSvc;
//
//	@Autowired
//	private SocketHandler socketHandler;
//
//	/* 프로젝트 로그 요청 */
//	@RequestMapping("getProjectLog")
//	public List<Log> getLog(HttpSession session, int pNum) {
//		// String loginUser = ((String) session.getAttribute("loginUser"));
//		String loginUser = "hong123@gmail.com";
//		Log log = new Log();
//		log.setpNum(pNum);
//		// 1. LogService에게 로그를 조회한다.
//		List<Log> projectLogList = logSvc.getProjectLog(pNum);
//		System.out.println(socketHandler);
//		//socketHandler.
//		// 2. 조회된 로그리스트를 반환한다.
//		System.out.println(projectLogList);
//
//		return projectLogList;
//	}
//}
