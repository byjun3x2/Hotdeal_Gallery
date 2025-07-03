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

		if (!canVote(hotdealId, username, voteType)) {
			return "이미 " + ("LIKE".equals(voteType) ? "추천" : "비추천") + "을 누르셨습니다";
		}

		if (!canVote(hotdealId, username, oppositeType)) {
			voteDAO.deleteVote(hotdealId, username, oppositeType);
			if ("LIKE".equals(voteType)) {
				hotdealService.decreaseDislikes(hotdealId);
			} else {
				hotdealService.decreaseLikes(hotdealId);
			}
		}

		voteDAO.insertVote(hotdealId, username, voteType);
		if ("LIKE".equals(voteType)) {
			hotdealService.increaseLikes(hotdealId);
		} else {
			hotdealService.increaseDislikes(hotdealId);
		}
		return "success";
	}
}
