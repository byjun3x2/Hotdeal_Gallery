package kr.co.hotdeal.board.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.co.hotdeal.board.vo.HotdealVO;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class HotdealDAOImpl implements HotdealDAO {

	private static final String NAMESPACE = "kr.co.hotdeal.board.dao.HotdealDAO.";

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<HotdealVO> getHotdealList() {
		return sqlSessionTemplate.selectList(NAMESPACE + "getHotdealList");
	}

	@Override
	public HotdealVO getHotdealById(int id) {
		return sqlSessionTemplate.selectOne(NAMESPACE + "getHotdealById", id);
	}

	@Override
	public void insertHotdeal(HotdealVO vo) {
		sqlSessionTemplate.insert(NAMESPACE + "insertHotdeal", vo);
	}

	@Override
	public void updateHotdeal(HotdealVO vo) {
		sqlSessionTemplate.update(NAMESPACE + "updateHotdeal", vo);
	}

	@Override
	public void deleteHotdeal(int id) {
		sqlSessionTemplate.delete(NAMESPACE + "deleteHotdeal", id);
	}

	@Override
	public int getHotdealTotalCount() {
		return sqlSessionTemplate.selectOne(NAMESPACE + "getHotdealTotalCount");
	}

	@Override
	public List<HotdealVO> getHotdealListPaging(int pageStart, int pageEnd) {
		Map<String, Object> param = new HashMap<>();
		param.put("pageStart", pageStart);
		param.put("pageEnd", pageEnd);
		return sqlSessionTemplate.selectList(NAMESPACE + "getHotdealListPaging", param);
	}

	@Override
	public int getHotdealTotalCountByKeyword(String keyword, String category) {
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		param.put("category", category);
		return sqlSessionTemplate.selectOne(NAMESPACE + "getHotdealTotalCountByKeyword", param);
	}

	@Override
	public void increaseViews(int id) {
		sqlSessionTemplate.update(NAMESPACE + "increaseViews", id);
	}

	@Override
	public void decreaseLikes(int id) {
		sqlSessionTemplate.update(NAMESPACE + "decreaseLikes", id);
	}

	@Override
	public void decreaseDislikes(int id) {
		sqlSessionTemplate.update(NAMESPACE + "decreaseDislikes", id);
	}

	@Override
	public void increaseLikes(int id) {
		sqlSessionTemplate.update(NAMESPACE + "increaseLikes", id);
	}

	@Override
	public void increaseDislikes(int id) {
		sqlSessionTemplate.update(NAMESPACE + "increaseDislikes", id);
	}

	@Override
	public List<HotdealVO> getBestHotdealList(int limit) {
		return sqlSessionTemplate.selectList(NAMESPACE + "getBestHotdealList", limit);
	}

	@Override
	public void updateEndStatus(Map<String, Object> params) {
		sqlSessionTemplate.update(NAMESPACE + "updateEndStatus", params);
	}

	@Override
	public List<HotdealVO> getHotdealListPagingByKeyword(int pageStart, int pageEnd, String keyword, String category,
			String sortColumn, String sortOrder) {
		Map<String, Object> param = new HashMap<>();
		param.put("pageStart", pageStart);
		param.put("pageEnd", pageEnd);
		param.put("keyword", keyword);
		param.put("category", category);
		param.put("sortColumn", sortColumn);
		param.put("sortOrder", sortOrder);
		return sqlSessionTemplate.selectList(NAMESPACE + "getHotdealListPagingByKeyword", param);
	}

	@Override
	public List<HotdealVO> selectNoticeList() { // [ADD]
		return sqlSessionTemplate.selectList(NAMESPACE + "selectNoticeList");
	}
}