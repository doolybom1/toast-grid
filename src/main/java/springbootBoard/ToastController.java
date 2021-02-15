package springbootBoard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

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
		
		//JSONArray jsonArr = new JSONArray(departList);
		//System.out.println("json데이터: "+ jsonArr);
		
		//mv.addObject("depart", jsonArr);
		mv.setViewName("test");
		
		return mv;
	}
	
	
	@RequestMapping(value = "/dhtmlxGantt", method = RequestMethod.GET)
	public String dhtmlxGantt(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		Map dataMap = DataMap.getDataMap(request);

		List dataList = testService.listControl("dhtmlxGanttSelect", dataMap);
		
		//JSONArray json = new JSONArray(dataList);
		String json = new Gson().toJson(dataList);
		System.out.println(json);
		
		/*
		ArrayList<String> arrlist = new ArrayList<String>(dataList);
		System.out.println(arrlist);
		
		Gson gson = new GsonBuilder().create();
		String test = gson.toJson(arrlist);
		
		System.out.println(test);
		 */
		
		if(dataList.isEmpty()) {
			return "initialdhtmlxGantt";
		}
		
		
		//JSONArray jsonArray = new JSONArray(dataList);
		//jsonArray.put(dataList);
		//System.out.println(jsonArray.toString());
		
		//System.out.println(jsonArray);
		//model.addAttribute("startDate", jsonArray.get(0));
		model.addAttribute("ganttData", json);
			
		
		return "dhtmlxGantt";
	}
	
	@RequestMapping(value = "/dhtmlxGanttData" , method = RequestMethod.POST)
	public ModelAndView dhtmlxGanttCreate(HttpServletRequest request, HttpServletResponse response, @RequestParam(required = false) String editing, @RequestParam(required = false) String gantt_mode) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		ModelAndView mv = new ModelAndView();
		
		System.out.println("데이터확인:" + dataMap);
		if(dataMap.get("!nativeeditor_status").toString().equals("inserted")) {
			testService.listControl("dhtmlxGanttCreate", dataMap);
		}else if(dataMap.get("!nativeeditor_status").toString().equals("updated")) {
			testService.listControl("dhtmlxGanttUpdate", dataMap);
		}else {
			testService.listControl("dhtmlxGanttDelete", dataMap);
		};
		
		mv.setViewName("redirect:/dhtmlxGantt");
	
		return mv;
	}
}
