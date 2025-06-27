// kr/hotdeal/dao/HotdealDAO.java
package kr.co.hotdeal.board.dao;

import java.util.List;

import kr.co.hotdeal.board.vo.HotdealVO;

public interface HotdealDAO {
	
    List<HotdealVO> getHotdealList();
    HotdealVO getHotdealById(int id);
    void insertHotdeal(HotdealVO vo);
    void updateHotdeal(HotdealVO vo);
    void deleteHotdeal(int id);

    int getHotdealTotalCount();
    List<HotdealVO> getHotdealListPaging(int pageStart, int pageEnd);
    
    int getHotdealTotalCountByKeyword(String keyword);
    List<HotdealVO> getHotdealListPagingByKeyword(int pageStart, int pageEnd, String keyword);
    
    void increaseViews(int id);
    
    
    void decreaseLikes(int id);
    void decreaseDislikes(int id);
    
    void increaseLikes(int id);
    void increaseDislikes(int id);
    
 // [ADD] 베스트 게시글 조회를 위한 메소드 추가
    List<HotdealVO> getBestHotdealList(int limit);
}
