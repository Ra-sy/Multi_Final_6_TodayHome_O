package test.com.todayhome.controller.event;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.EventVO;
import test.com.todayhome.service.EventService;

@Slf4j
@Controller
public class EventRestController {
	
	@Autowired
	EventService service;
	
	@Autowired
	ServletContext sContext;
	
	@ResponseBody
	@RequestMapping(value= "/evJsonSelectAll", method=RequestMethod.GET)
	public List<EventVO> evJsonSelectAll(){
		log.info("evJsonSelectAll...");
		List<EventVO> vos = service.selectAll();
		return vos;
	}

	@RequestMapping(value = "/evJsonSelectAllBanner", method = RequestMethod.GET)
	@ResponseBody
	public List<EventVO> evJsonSelectAllBanner() {
		log.info("/evJsonSelectAllBanner...");
		List<EventVO> vos = service.selectAllBanner();
		return vos;
	}

}
