package springbootBoard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import springbootBoard.dto.AjaxDTO;
import springbootBoard.service.AjaxService;
import springbootBoard.util.DataMap;

@RestController
@RequestMapping("ajax")
@Slf4j
public class AjaxController {
	@Autowired
	private AjaxService ajaxService;
	
	@RequestMapping("ajaxDataList.do")
	public String ajaxDataList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		System.out.println("들어왔어요");
		
		log.debug("toastDataList");
		
		JSONObject obj1 = new JSONObject();
		JSONObject obj2 = new JSONObject();
		JSONObject obj3 = new JSONObject();
		
		try {
			List<AjaxDTO> list = ajaxService.ajaxList(dataMap);
			
			System.out.println("조회했어요 -> " + list);
			
			JSONArray jsonArr = new JSONArray();
			
			for(int i=0; i<list.size(); i++) {
				JSONObject sObj = new JSONObject();
				
				sObj.put("user_nm", list.get(i).getUserNm());
				sObj.put("user_num", list.get(i).getUserNum());
				sObj.put("user_dp_nm", list.get(i).getUserDpNm());
				sObj.put("user_part1", list.get(i).getUserPart1());
				sObj.put("user_part2", list.get(i).getUserPart2());
				sObj.put("user_work_jo", list.get(i).getUserWorkJo());
				
				jsonArr.put(sObj);
			}
			
			obj3.put("page", 1);
			obj3.put("totalCount", list.size());
			
			obj2.put("contents", jsonArr);
			obj2.put("pagination", obj3);
			
			obj1.put("result", true);
			obj1.put("data", obj2);
			
			System.out.println("CHECK JSONObject : " + obj1.toString());
		}catch(Exception e) {
			e.printStackTrace();
		}

		return obj1.toString();
	}
}