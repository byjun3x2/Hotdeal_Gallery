package kr.co.hotdeal.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.hotdeal.board.commons.paging.Criteria;
import kr.co.hotdeal.board.dao.HotdealDAO;
import kr.co.hotdeal.board.vo.HotdealVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HotdealService {

	private final HotdealDAO hotdealDAO;

	public void deleteHotdeal(int id) {
		hotdealDAO.deleteHotdeal(id);
	}

	public void decreaseLikes(int id) {
		hotdealDAO.decreaseLikes(id);
	}

	public void decreaseDislikes(int id) {
		hotdealDAO.decreaseDislikes(id);
	}

	public void increaseDislikes(int id) {
		hotdealDAO.increaseDislikes(id);
	}

	public void increaseLikes(int id) {
		hotdealDAO.increaseLikes(id);
	}

	public void increaseViews(int id) {
		hotdealDAO.increaseViews(id);
	}

	public HotdealVO getHotdealById(int id) {
		return hotdealDAO.getHotdealById(id);
	}

	public List<HotdealVO> getHotdealListPaging(Criteria criteria) {
		return hotdealDAO.getHotdealListPaging(criteria.getPageStart(), criteria.getPageEnd());
	}

	public List<HotdealVO> getHotdealList(Criteria criteria, String keyword, String category, String sortColumn,
			String sortOrder) {
		return hotdealDAO.getHotdealListPagingByKeyword(criteria.getPageStart(), criteria.getPageEnd(), keyword,
				category, sortColumn, sortOrder);
	}

	public int getHotdealTotalCount() {
		return hotdealDAO.getHotdealTotalCount();
	}

	public int getHotdealTotalCountByKeyword(String keyword) {
		return hotdealDAO.getHotdealTotalCountByKeyword(keyword, null);
	}

	public int getTotalCount(String keyword, String category) {

		return hotdealDAO.getHotdealTotalCountByKeyword(keyword, category);
	}

	public void insertHotdeal(HotdealVO vo) {
		hotdealDAO.insertHotdeal(vo);
	}

	public void updateHotdeal(HotdealVO vo) {
		hotdealDAO.updateHotdeal(vo);
	}

	public List<HotdealVO> getBestHotdealList(int limit) {
		return hotdealDAO.getBestHotdealList(limit);
	}

	public HotdealVO toggleEndStatus(int id) {
		HotdealVO deal = hotdealDAO.getHotdealById(id);
		if (deal != null) {
			String currentStatus = deal.getIsEnded();
			String newStatus = "N".equals(currentStatus) ? "Y" : "N";

			Map<String, Object> params = new HashMap<>();
			params.put("id", id);
			params.put("isEnded", newStatus);
			hotdealDAO.updateEndStatus(params);

			return hotdealDAO.getHotdealById(id);
		}
		return null;
	}

	public List<HotdealVO> getNoticeList() {
		return hotdealDAO.selectNoticeList();
	}

}