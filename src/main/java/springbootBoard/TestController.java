package springbootBoard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import springbootBoard.service.TestService;
import springbootBoard.util.DataMap;

@RestController
@RequestMapping("test")
@Slf4j
public class TestController {
	@Autowired
	private TestService testService;
	
	
	@RequestMapping("testDataList.do")
	public String testDataList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		System.out.println("들어왔어요");
		
		log.debug("toastDataList");
		
		JSONObject finalObj = new JSONObject();
		JSONObject obj1 = new JSONObject();
		JSONObject obj2 = new JSONObject();
		
		try {
			int listCnt = testService.cntControl("testList_cnt", dataMap);
			
			List list = testService.listControl("testList", dataMap);
			
			System.out.println("조회했어요 -> " + list);
			
			JSONArray jsonArr = new JSONArray(list);
			
			obj2.put("page", Integer.parseInt(dataMap.get("page").toString()));
			obj2.put("totalCount", listCnt);
			
			obj1.put("contents", jsonArr);
			obj1.put("pagination", obj2);
			
			finalObj.put("result", true);
			finalObj.put("data", obj1);
			
			System.out.println("CHECK JSONObject : " + finalObj.toString());
		}catch(Exception e) {
			e.printStackTrace();
		}

		return finalObj.toString();
	}
	
	@RequestMapping(value = "createData.do", method = RequestMethod.POST)
	public void createData(HttpServletRequest request,HttpServletResponse response,@RequestBody Map payload) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		List<Map> dataList = duplicateMethod("insert", payload);
	      
	      for (int i = 0; i < dataList.size(); i++) {
	    	  dataMap = dataList.get(i);
	    	  System.out.println("DATA MAP: " + dataMap);
	    	  testService.listControl("toastInsert", dataMap);
	      }
	}
	
	
	@RequestMapping(value = "updateData.do", method = RequestMethod.POST)
	public void updateData(HttpServletRequest request,HttpServletResponse response, @RequestBody Map payload) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		List<Map> dataList = duplicateMethod("update", payload);
	      
	      for (int i = 0; i < dataList.size(); i++) {
	    	  dataMap = dataList.get(i);
	    	  System.out.println("DATA MAP: " + dataMap);
	    	  testService.listControl("toastUpdate", dataMap);
	      }
	}
	
	@RequestMapping(value = "deleteData.do", method = RequestMethod.POST)
	public void deleteData(HttpServletRequest request,HttpServletResponse response, @RequestBody Map payload) throws Exception {
		Map dataMap = DataMap.getDataMap(request);
		
		List<Map> dataList = duplicateMethod("delete", payload);
	      
	      for (int i = 0; i < dataList.size(); i++) {
	    	  dataMap = dataList.get(i);
	    	  System.out.println("DATA MAP: " + dataMap);
	    	  testService.listControl("delete", dataMap);
	      }
	}
	
	
	public List<Map> duplicateMethod(String type, @RequestBody Map payload) {
		System.out.println(payload);
		System.out.println("들어왔어요");
		
		List<Map> dataList;
		if(type == "update") {	
			dataList = (List<Map>) payload.get("updatedRows");
		}else if(type == "insert") {
			dataList = (List<Map>) payload.get("createdRows");
		}else {
			dataList = (List<Map>) payload.get("deletedRows");
		}
		System.out.println("DATA LIST: " + dataList);
		
		return dataList;
	}
}