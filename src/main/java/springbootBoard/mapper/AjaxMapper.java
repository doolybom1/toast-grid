package springbootBoard.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import springbootBoard.dto.AjaxDTO;

@Mapper
public interface AjaxMapper {
	List<AjaxDTO> ajaxList(Map map) throws Exception;

	/*
	//데이터 컨트롤(모든 데이터 관련된 것들을 queryName에 쿼리명을 넣고, 나머지 값들은 map에 담아 넘김
	Map mapDataControl(String queryName, Map map) throws Exception;
	*/
}
