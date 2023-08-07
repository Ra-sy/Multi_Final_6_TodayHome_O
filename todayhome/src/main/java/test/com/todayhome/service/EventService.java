package test.com.todayhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.mapper.EventDAO;
import test.com.todayhome.model.EventVO;

@Slf4j
@Service
public class EventService {
	
	@Autowired
	EventDAO dao;
	
	public EventService() {
		log.info("EventService()...");
	}
	
	public List<EventVO> selectAll(){
		return dao.selectAll();
	}
	
	public EventVO selectOne(EventVO vo) {
		return dao.selectOne(vo);
	}
	public List<EventVO> selectAllBanner(){
		return dao.selectAllBanner();
	}

}
