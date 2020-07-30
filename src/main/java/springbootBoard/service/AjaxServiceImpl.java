package springbootBoard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springbootBoard.dto.AjaxDTO;
import springbootBoard.mapper.AjaxMapper;

@Service
public class AjaxServiceImpl implements AjaxService {
	@Autowired
	private AjaxMapper ajaxMapper;
	
	public List<AjaxDTO> ajaxList(Map map) throws Exception {
		return ajaxMapper.ajaxList(map);
	}
}
