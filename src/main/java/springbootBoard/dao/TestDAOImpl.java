package springbootBoard.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestDAOImpl implements TestDAO{

	@Autowired
	private SqlSession query;
	
	//데이터 카운트 컨트롤(모든 데이터 관련된 것들을 queryName에 쿼리명을 넣고, 나머지 값들은 map에 담아 넘김
	public int cntControl(String queryName, Map map) throws SQLException{
		return (Integer) query.selectOne(queryName, map);
	}
	
	//데이터 리스트 컨트롤(모든 데이터 관련된 것들을 queryName에 쿼리명을 넣고, 나머지 값들은 map에 담아 넘김
	public List listControl(String queryName, Map map) throws SQLException{
		return (List) query.selectList(queryName, map);
	}
}
