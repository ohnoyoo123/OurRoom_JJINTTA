package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/**
 * 용도 : 페이지 이동 시 로그인 여부 체크하는 로그인인터셉터 클래스
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		try {
			HttpSession session = request.getSession();
			// 로그인한 사용자가 존재하지 않을 경우 main으로 넘어가기
			System.out.println("[LoginInterceptor] : " + session.getAttribute("loginUser"));
			if (session.getAttribute("loginUser") == null) {
				response.sendRedirect("/OurRoom");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

}
