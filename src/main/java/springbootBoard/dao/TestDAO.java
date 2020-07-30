package springbootBoard.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface TestDAO {
	//데이터 카운트 컨트롤(모든 데이터 관련된 것들을 queryName에 쿼리명을 넣고, 나머지 값들은 map에 담아 넘김
	public int cntControl(String queryName, Map map) throws SQLException;
		
	//데이터 리스트 컨트롤(모든 데이터 관련된 것들을 queryName에 쿼리명을 넣고, 나머지 값들은 map에 담아 넘김
	public List listControl(String queryName, Map map) throws SQLException;
}
