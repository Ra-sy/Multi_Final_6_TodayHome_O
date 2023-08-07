package test.com.todayhome.mapper;

import java.util.List;

import test.com.todayhome.model.EventCommentsVO;

public interface EventCommentsDAO {
	
	public List<EventCommentsVO> selectAll(EventCommentsVO vo);
	public int insert(EventCommentsVO vo);
	public int update(EventCommentsVO vo);
	public int delete(EventCommentsVO vo);

}
