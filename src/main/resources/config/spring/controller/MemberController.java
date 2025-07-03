package kr.co.hotdeal.member.controller;

import kr.co.hotdeal.member.service.MemberService;
import kr.co.hotdeal.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;

	@GetMapping("/join")
	public String joinForm() {
		return "register";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberVO member, Model model, RedirectAttributes redirectAttributes) {

		if (memberService.getMemberByUsername(member.getUsername()) != null) {
			model.addAttribute("idError", "이미 사용 중인 아이디입니다.");
			return "register";
		}

		if (memberService.getMemberByEmail(member.getEmail()) != null) {
			model.addAttribute("emailError", "이미 등록된 이메일입니다.");
			return "register";
		}

		if (member.getPassword() == null || !member.getPassword()
				.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]{8,30}$")) {
			model.addAttribute("pwError", "비밀번호는 8~30자, 영문과 숫자를 모두 포함해야 합니다.");
			return "register";
		}

		memberService.join(member);

		return "registerSuccess";
	}

	@GetMapping("/login")
	public String loginForm() {
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam("username") String username, @RequestParam("password") String password,
			HttpSession session, Model model) {
		MemberVO member = memberService.login(username, password);
		if (member != null) {
			session.setAttribute("loginUser", member);
			return "redirect:/list";
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
			return "login";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	@GetMapping("/checkUsername")
	@ResponseBody
	public Map<String, Object> checkUsername(@RequestParam String username) {
		boolean exists = memberService.getMemberByUsername(username) != null;
		Map<String, Object> map = new HashMap<>();
		map.put("exists", exists);
		return map;
	}

	@GetMapping("/checkEmail")
	@ResponseBody
	public Map<String, Object> checkEmail(@RequestParam String email) {
		boolean exists = memberService.getMemberByEmail(email) != null;
		Map<String, Object> map = new HashMap<>();
		map.put("exists", exists);
		return map;
	}
}
