package test.com.todayhome.controller.event;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.EventCommentsVO;
import test.com.todayhome.service.EventCommentsService;

@Slf4j
@Controller
public class EventCommentsRestController {
	
	@Autowired
	EventCommentsService service;
	
	@Autowired
	ServletContext sContext;
	
	@ResponseBody
	@RequestMapping(value = "/evcJsonSelectAll", method = RequestMethod.GET)
	public List<EventCommentsVO> evcJsonSelectAll(EventCommentsVO vo) {
		log.info("/evcJsonSelectAll...");
		List<EventCommentsVO> vos=service.selectAll(vo);
		return vos;
	}//end c_selectAll
	
	@ResponseBody
	@RequestMapping(value = "/evcInsertOK", method = RequestMethod.GET)
	public String evcInsertOK(EventCommentsVO vo) {
		log.info("/evcInsertOK...{}",vo);
		
		int result = service.insert(vo);
		log.info("result : {}",result);	//{}가 result로 대체됨

	    if (result == 1) {
	        return "{\"result\":1}";
	    } else {
	        return "{\"result\":0}";
	    }
	    
	}//end c_insertOK
	
	@ResponseBody
	@RequestMapping(value = "/evcDeleteOK", method = RequestMethod.GET)
	public String evcDeleteOK(EventCommentsVO vo) {
		log.info("/evcDeleteOK....{}",vo);
		
		int result = service.delete(vo);
		log.info("result : {}",result);
	    if (result == 1) {
	        return "{\"result\":1}";
	    } else {
	        return "{\"result\":0}";
	    }
		
	}//end c_deleteOK
	

}
