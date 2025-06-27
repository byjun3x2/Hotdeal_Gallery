package kr.co.hotdeal.vote.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.vote.service.VoteService;
import kr.co.hotdeal.board.service.HotdealService;
import kr.co.hotdeal.board.vo.HotdealVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class VoteController {

    private final VoteService voteService;
    private final HotdealService hotdealService;

    @PostMapping("/vote")
    @ResponseBody
    public Map<String, Object> vote(@RequestParam int id,
                                    @RequestParam String type,
                                    HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        MemberVO member = (MemberVO) session.getAttribute("loginUser");
        if (member == null) {
            result.put("result", "로그인이 필요합니다.");
            return result;
        }
        String username = member.getUsername();

        // 투표 처리 (상호 배타 로직 포함)
        String voteResult = voteService.vote(id, username, type);
        result.put("result", voteResult);

        // 최신 추천/비추천 수 조회 (detail.jsp에서 즉시 반영)
        HotdealVO deal = hotdealService.getHotdealById(id);
        result.put("likes", deal.getLikes());
        result.put("dislikes", deal.getDislikes());

        return result;
    }
}
