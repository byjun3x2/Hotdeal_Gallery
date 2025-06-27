package kr.co.hotdeal.vote.service;

import kr.co.hotdeal.vote.dao.VoteDAO;
import kr.co.hotdeal.board.service.HotdealService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class VoteService {

    private final VoteDAO voteDAO;
    private final HotdealService hotdealService;

    public boolean canVote(int hotdealId, String username, String voteType) {
        return voteDAO.countVote(hotdealId, username, voteType) == 0;
    }

    public String vote(int hotdealId, String username, String voteType) {
        String oppositeType = "LIKE".equals(voteType) ? "DISLIKE" : "LIKE";

        // 이미 같은 타입으로 투표했다면
        if (!canVote(hotdealId, username, voteType)) {
            return "이미 " + ("LIKE".equals(voteType) ? "추천" : "비추천") + "을 누르셨습니다";
        }

        // 반대 타입으로 이미 투표했다면, 기존 투표 삭제 및 카운트 감소
        if (!canVote(hotdealId, username, oppositeType)) {
            voteDAO.deleteVote(hotdealId, username, oppositeType);
            if ("LIKE".equals(voteType)) {
                hotdealService.decreaseDislikes(hotdealId);
            } else {
                hotdealService.decreaseLikes(hotdealId);
            }
        }

        // 현재 타입 투표 기록 추가 및 카운트 증가 (이 부분이 항상 실행되어야 함)
        voteDAO.insertVote(hotdealId, username, voteType);
        if ("LIKE".equals(voteType)) {
            hotdealService.increaseLikes(hotdealId);
        } else {
            hotdealService.increaseDislikes(hotdealId);
        }
        return "success";
    }
}
