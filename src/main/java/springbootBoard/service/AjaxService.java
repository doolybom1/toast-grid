package springbootBoard.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import springbootBoard.dto.AjaxDTO;

public interface AjaxService {
	public List<AjaxDTO> ajaxList(Map map) throws Exception;

//	public Map mapDataControl(String queryName, Map map) throws SQLException;
}
