package test.com.todayhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.mapper.EventCommentsDAO;
import test.com.todayhome.model.EventCommentsVO;

@Slf4j
@Service
public class EventCommentsService {
	
	@Autowired
	EventCommentsDAO dao;
	
	public EventCommentsService() {
		log.info("EventCommentsService()...");
	}
	
	public List<EventCommentsVO> selectAll(EventCommentsVO vo){
		return dao.selectAll(vo);
	}
	
	public int insert(EventCommentsVO vo) {
		return dao.insert(vo);
	}

	public int update(EventCommentsVO vo) {
		return dao.update(vo);
	}

	public int delete(EventCommentsVO vo) {
		return dao.delete(vo);
	}

}
