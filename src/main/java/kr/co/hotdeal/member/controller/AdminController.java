package kr.co.hotdeal.member.controller;

import kr.co.hotdeal.member.service.MemberService;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@Controller
@RequestMapping("/admin") // 이 컨트롤러의 모든 경로는 /admin으로 시작
@RequiredArgsConstructor
public class AdminController {

    private final MemberService memberService;

    /**
     * 관리자 메인 페이지 (회원 관리 페이지)
     */
    @GetMapping("/members")
    public String memberList(Model model) {
        List<MemberVO> memberList = memberService.getAllMembers();
        model.addAttribute("memberList", memberList);
        return "admin/memberList"; // /WEB-INF/jsp/admin/memberList.jsp 파일을 찾아 렌더링
    }
}