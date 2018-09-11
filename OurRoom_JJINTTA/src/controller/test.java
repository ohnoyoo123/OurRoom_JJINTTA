package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class test {

	@RequestMapping("test")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView();
		System.out.println("요청url : test");

		mav.setViewName("test/test");
		return mav;
	}

	@RequestMapping("test2")
	public ModelAndView test2() {
		ModelAndView mav = new ModelAndView();
		System.out.println("요청url : test2");
		mav.addObject("test", "test브런치22222 작업중..");

		mav.setViewName("test/test2");
		return mav;
	}

	@RequestMapping("test3")
	public ModelAndView test3() {
		ModelAndView mav = new ModelAndView();
		System.out.println("요청url : test2");
		mav.addObject("test", "test브런치22222 작업중..");

		mav.setViewName("test/modalLogin");
		return mav;
	}
}
