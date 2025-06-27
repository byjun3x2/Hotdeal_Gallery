package kr.co.hotdeal.member.controller;

import kr.co.hotdeal.member.service.MemberService;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    // 회원가입 폼
    @GetMapping("/join")
    public String joinForm() {
        return "register";
    }

    // 회원가입 처리
    @PostMapping("/join")
    public String join(MemberVO member, RedirectAttributes redirectAttributes) {
        memberService.join(member);
        redirectAttributes.addFlashAttribute("msg", "회원가입이 완료되었습니다!");
        return "redirect:/list";
    }

  
    // 로그인 폼
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    // 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
            @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {
        MemberVO member = memberService.login(username, password);
        if (member != null) {
            session.setAttribute("loginUser", member);
            return "redirect:/list";
        } else {
            model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
