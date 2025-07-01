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

	public List<HotdealVO> getHotdealList(Criteria criteria, String keyword, String category, String sortColumn, String sortOrder) {
	    return hotdealDAO.getHotdealListPagingByKeyword(
	        criteria.getPageStart(),
	        criteria.getPageEnd(),
	        keyword,
	        category,
	        sortColumn, // [수정] sortColumn 전달
	        sortOrder   // [수정] sortOrder 전달
	    );
	}
	public int getHotdealTotalCount() {
		return hotdealDAO.getHotdealTotalCount();
	}

	public int getHotdealTotalCountByKeyword(String keyword) {
		return hotdealDAO.getHotdealTotalCountByKeyword(keyword, null);
	}

	// [REVISED] 전체 개수 조회 서비스 - category 파라미터 추가
	public int getTotalCount(String keyword, String category) {
		// [REVISED] DAO 호출 시 category 전달
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

	// [ADD] 종료 상태 토글 서비스 메소드
	public HotdealVO toggleEndStatus(int id) {
		HotdealVO deal = hotdealDAO.getHotdealById(id);
		if (deal != null) {
			String currentStatus = deal.getIsEnded();
			String newStatus = "N".equals(currentStatus) ? "Y" : "N";

			Map<String, Object> params = new HashMap<>();
			params.put("id", id);
			params.put("isEnded", newStatus);
			hotdealDAO.updateEndStatus(params);

			// 변경된 정보를 다시 조회하여 반환
			return hotdealDAO.getHotdealById(id);
		}
		return null;
	}

}