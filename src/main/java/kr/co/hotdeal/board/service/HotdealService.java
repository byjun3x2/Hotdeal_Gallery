package kr.co.hotdeal.board.service;

import kr.co.hotdeal.board.commons.paging.Criteria;
import kr.co.hotdeal.board.dao.HotdealDAO;
import kr.co.hotdeal.board.vo.HotdealVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

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

    public List<HotdealVO> getHotdealList() {
        return hotdealDAO.getHotdealList();
    }
    
    public List<HotdealVO> getHotdealList(int page, String keyword) {
        // 페이징 계산 (예시)
        int perPageNum = 10;
        int pageStart = (page - 1) * perPageNum + 1;
        int pageEnd = page * perPageNum;

        // DAO에서 페이징+검색 쿼리 호출
        return hotdealDAO.getHotdealListPagingByKeyword(pageStart, pageEnd, keyword);
    }

    public List<HotdealVO> getHotdealListPaging(Criteria criteria) {
        return hotdealDAO.getHotdealListPaging(criteria.getPageStart(), criteria.getPageEnd());
    }

    public List<HotdealVO> getHotdealListPagingByKeyword(Criteria criteria, String keyword) {
        return hotdealDAO.getHotdealListPagingByKeyword(criteria.getPageStart(), criteria.getPageEnd(), keyword);
    }

    public int getHotdealTotalCount() {
        return hotdealDAO.getHotdealTotalCount();
    }

    public int getHotdealTotalCountByKeyword(String keyword) {
        return hotdealDAO.getHotdealTotalCountByKeyword(keyword);
    }
    
    public int getTotalCount(String keyword) {
        return hotdealDAO.getHotdealTotalCountByKeyword(keyword);
    }

    public void insertHotdeal(HotdealVO vo) {
        hotdealDAO.insertHotdeal(vo);
    }

    public void updateHotdeal(HotdealVO vo) {
        hotdealDAO.updateHotdeal(vo);
    }
    
 // [ADD] 베스트 게시글 조회를 위한 서비스 메소드 추가
    public List<HotdealVO> getBestHotdealList(int limit) {
        return hotdealDAO.getBestHotdealList(limit);
    }

}
