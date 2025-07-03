package kr.co.hotdeal.board.dao;

import java.util.List;
import java.util.Map;

import kr.co.hotdeal.board.vo.HotdealVO;

public interface HotdealDAO {

	List<HotdealVO> getHotdealList();

	HotdealVO getHotdealById(int id);

	void insertHotdeal(HotdealVO vo);

	void updateHotdeal(HotdealVO vo);

	void deleteHotdeal(int id);

	int getHotdealTotalCount();

	List<HotdealVO> getHotdealListPaging(int pageStart, int pageEnd);

	void increaseViews(int id);

	void decreaseLikes(int id);

	void decreaseDislikes(int id);

	void increaseLikes(int id);

	void increaseDislikes(int id);

	List<HotdealVO> getBestHotdealList(int limit);

	int getHotdealTotalCountByKeyword(String keyword, String category);

	void updateEndStatus(Map<String, Object> params);

	List<HotdealVO> getHotdealListPagingByKeyword(int pageStart, int pageEnd, String keyword, String category,
			String sortColumn, String sortOrder);

	List<HotdealVO> selectNoticeList(); // [ADD]
}