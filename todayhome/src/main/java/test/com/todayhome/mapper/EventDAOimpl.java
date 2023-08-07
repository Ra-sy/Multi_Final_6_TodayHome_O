package test.com.todayhome.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.EventVO;

@Slf4j
@Repository
public class EventDAOimpl implements EventDAO {

	@Autowired
	SqlSession sqlSession;
	
	public EventDAOimpl() {
		log.info("EventDAOimpl()...");
	}
	
	@Override
	public List<EventVO> selectAll() {
		return sqlSession.selectList("EV_SELECT_ALL");
	}

	@Override
	public EventVO selectOne(EventVO vo) {
		return sqlSession.selectOne("EV_SELECT_ONE",vo);
	}

	@Override
	public List<EventVO> selectAllBanner() {
		return sqlSession.selectList("E_BANNER");
	}

}
