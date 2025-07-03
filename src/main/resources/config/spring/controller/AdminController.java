package kr.co.hotdeal.member.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.hotdeal.member.service.MemberService;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.report.service.ReportService;
import kr.co.hotdeal.report.vo.ReportVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	private final MemberService memberService;
	private final ReportService reportService;

	@GetMapping("/members")
	public String memberList(Model model) {
		List<MemberVO> memberList = memberService.getAllMembers();
		model.addAttribute("memberList", memberList);
		return "admin/memberList";
	}

	@GetMapping("/reports")
	public String reportList(Model model) {
		List<ReportVO> reportList = reportService.getAllReports();
		model.addAttribute("reportList", reportList);
		return "admin/reportList";
	}
}