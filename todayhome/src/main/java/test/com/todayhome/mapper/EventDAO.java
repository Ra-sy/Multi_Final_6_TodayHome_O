package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.EventVO;

public interface EventDAO {
	
	public List<EventVO> selectAll();
	public List<EventVO> selectAllBanner();
	public EventVO selectOne(EventVO vo);

}
