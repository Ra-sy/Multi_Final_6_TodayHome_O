package test.com.todayhome.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.EventCommentsVO;

@Slf4j
@Repository
public class EventCommentsDAOimpl implements EventCommentsDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public EventCommentsDAOimpl() {
		log.info("EventCommentsDAOimpl()...");
	}

	@Override
	public List<EventCommentsVO> selectAll(EventCommentsVO vo) {
		log.info("selectAll()..."+vo);
		return sqlSession.selectList("EVC_SELECT_ALL",vo);
	}

	@Override
	public int insert(EventCommentsVO vo) {
		log.info("insert()..."+vo);
		return sqlSession.insert("EVC_INSERT",vo);
	}

	@Override
	public int update(EventCommentsVO vo) {
		log.info("update()..."+vo);
		return sqlSession.update("",vo);
	}

	@Override
	public int delete(EventCommentsVO vo) {
		log.info("delete()..."+vo);
		return sqlSession.delete("EVC_DELETE",vo);
	}

}
