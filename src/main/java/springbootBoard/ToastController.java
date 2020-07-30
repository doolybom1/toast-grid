package springbootBoard;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import springbootBoard.service.TestService;
import springbootBoard.util.DataMap;

@Controller
public class ToastController {
	@Autowired
	private TestService testService;
	
	@RequestMapping("/toast")
	public ModelAndView openHello (HttpServletResponse response) throws Exception {
		return new ModelAndView("toast");
	}
	
	@RequestMapping("/test")
	public ModelAndView openTest (HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		ModelAndView mv = new ModelAndView();
		List departList = testService.listControl("departList", dataMap);
		System.out.println(departList.toString());
		
		JSONArray jsonArr = new JSONArray(departList);
		System.out.println("json데이터: "+ jsonArr);
		
		mv.addObject("depart", jsonArr);
		mv.setViewName("test");
		
		return mv;
	}
}
