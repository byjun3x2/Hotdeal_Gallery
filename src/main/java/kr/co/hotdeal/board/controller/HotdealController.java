package kr.co.hotdeal.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.board.commons.paging.Criteria;
import kr.co.hotdeal.board.service.HotdealService;
import kr.co.hotdeal.board.vo.HotdealVO;
import kr.co.hotdeal.comment.service.CommentService;
import kr.co.hotdeal.comment.vo.CommentVO;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.product.service.ProductService;
import kr.co.hotdeal.product.vo.ProductVO;
import kr.co.hotdeal.report.service.ReportService;
import kr.co.hotdeal.report.vo.ReportVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HotdealController {

	private final HotdealService hotdealService;
	private final CommentService commentService;
	private final ProductService productService;
	
	@Autowired
	private ReportService reportService; // ReportService 주입

	@RequestMapping("/hello")
	public String hello() {
		return "default";
	}

	// 홈 → 목록 리다이렉트
	@Controller
	public class HomeController {
		@GetMapping("/")
		public String home() {
			return "redirect:/list";
		}
	}

	// HotdealController.java의 list 메서드만 수정
	@GetMapping("/list")
	public String list(Model model, Criteria criteria,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "sort", required = false, defaultValue = "latest") String sort) {

		// 1. 게시글 목록과 총 개수 가져오기 (페이지네이션 + 정렬)
		List<HotdealVO> hotdealList = hotdealService.getHotdealList(criteria, keyword, category, sort);
		int totalCount = hotdealService.getTotalCount(keyword, category);
		
		model.addAttribute("hotdealList", hotdealList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("criteria", criteria);
		model.addAttribute("keyword", keyword);
		model.addAttribute("selectedCategory", category);
		model.addAttribute("sort", sort);

		// [수정] 누락되었던 카테고리 목록과 베스트 게시글 조회 로직 복구
		// 2. 베스트 게시글 목록 가져오기
		List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
		model.addAttribute("bestList", bestList);

		// 3. 전체 카테고리 목록 가져오기
		List<String> categoryList = productService.getAllCategories();
		model.addAttribute("categoryList", categoryList);

		return "list";
	}

	// 글쓰기 폼
	@GetMapping("/write")
	public String writeForm(HttpSession session, Model model) {
		if (session.getAttribute("loginUser") == null) {
			return "redirect:/login";
		}

		List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
		model.addAttribute("bestList", bestList);

		return "write";
	}

	// 글 등록 처리
	@PostMapping("/write")
	public String write(@ModelAttribute HotdealVO hotdeal, @RequestParam("product.category") String category,
			@RequestParam("product.shopName") String shopName, @RequestParam("product.productName") String productName,
			@RequestParam("product.price") int price, @RequestParam("product.deliveryFee") String deliveryFee,
			@RequestParam(name = "product.relatedUrl", required = false) String relatedUrl,
			@RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile, HttpSession session)
			throws IOException {

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		if (member == null) {
			return "redirect:/login";
		}
		hotdeal.setAuthor(member.getUsername());

		ProductVO product = new ProductVO();
		product.setCategory(category);
		product.setShopName(shopName);
		product.setProductName(productName);
		product.setPrice(price);
		product.setDeliveryFee(deliveryFee);
		product.setRelatedUrl(relatedUrl);

		hotdeal.setCategory(category);

		if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
			String uploadDir = "C:/upload/";
			File dir = new File(uploadDir);
			if (!dir.exists())
				dir.mkdirs();

			String fileName = UUID.randomUUID() + "_" + thumbnailFile.getOriginalFilename();
			File dest = new File(dir, fileName);
			thumbnailFile.transferTo(dest);

			String thumbnailUrl = "/upload/" + fileName;
			hotdeal.setThumbnail(thumbnailUrl);
			product.setProductImage(thumbnailUrl);
		} else if (hotdeal.getThumbnail() != null && !hotdeal.getThumbnail().isEmpty()) {
			product.setProductImage(hotdeal.getThumbnail());
		}

		String uuid = UUID.randomUUID().toString();
		product.setProductId(uuid);

		product.setProductImage(hotdeal.getThumbnail());

		productService.insertProduct(product);

		hotdeal.setProductId(product.getProductId());

		hotdealService.insertHotdeal(hotdeal);

		return "redirect:/list";
	}

	// 수정 폼 진입 (GET)
	@GetMapping("/edit")
	public String editForm(@RequestParam("id") int id, Model model, HttpSession session) {
		HotdealVO deal = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (deal == null || loginUser == null || !deal.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}
		model.addAttribute("deal", deal);
		return "edit"; // edit.jsp
	}

	// 수정 처리 (POST)
	@PostMapping("/edit")
	public String editHotdeal(@RequestParam("id") int id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("product.productId") String productId,
			@RequestParam("product.category") String category, @RequestParam("product.shopName") String shopName,
			@RequestParam("product.productName") String productName, @RequestParam("product.price") int price,
			@RequestParam("product.deliveryFee") String deliveryFee,
			@RequestParam("product.relatedUrl") String relatedUrl,
			@RequestParam(value = "thumbnail", required = false) String thumbnailUrl,
			@RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile, Model model,
			HttpSession session) {

		// 권한 체크
		HotdealVO origin = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (origin == null || loginUser == null || !origin.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}

		// 파일 업로드 처리
		String thumbnail = thumbnailUrl;
		if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
			try {
				String uploadDir = "C:/upload"; // 실제 환경에 맞게 수정
				String fileName = System.currentTimeMillis() + "_" + thumbnailFile.getOriginalFilename();
				java.io.File dest = new java.io.File(uploadDir, fileName);
				dest.getParentFile().mkdirs();
				thumbnailFile.transferTo(dest);
				thumbnail = "/upload/" + fileName;
			} catch (Exception e) {
				model.addAttribute("msg", "파일 업로드에 실패했습니다.");
				model.addAttribute("deal", origin);
				return "edit";
			}
		}

		// [1] 상품 정보 업데이트
		ProductVO product = new ProductVO();
		product.setProductId(productId);
		product.setCategory(category);
		product.setShopName(shopName);
		product.setProductName(productName);
		product.setPrice(price);
		product.setDeliveryFee(deliveryFee);
		product.setRelatedUrl(relatedUrl);

		productService.updateProduct(product);

		// [2] 핫딜 정보 업데이트
		HotdealVO vo = new HotdealVO();
		vo.setId(id);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setThumbnail(thumbnail);
		vo.setProductId(productId);

		hotdealService.updateHotdeal(vo);

		return "redirect:/detail?id=" + id;
	}

	@PostMapping("/delete")
	public String deleteHotdeal(@RequestParam("id") int id, HttpSession session, Model model) {
		HotdealVO deal = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		// 권한 체크: 작성자 본인만 삭제 가능
		if (deal == null || loginUser == null || !deal.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "삭제 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}
		hotdealService.deleteHotdeal(id);
		// 삭제 후 목록으로 이동
		return "redirect:/list?page=1";
	}

	// 상세보기 (조회수 증가 포함)
	@RequestMapping("/detail")
	public String detail(@RequestParam("id") int id, HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		Set<Integer> viewedSet = (Set<Integer>) session.getAttribute("viewedHotdealIds");
		if (viewedSet == null) {
			viewedSet = new HashSet<>();
		}

		if (!viewedSet.contains(id)) {
			hotdealService.increaseViews(id);
			viewedSet.add(id);
			session.setAttribute("viewedHotdealIds", viewedSet);
		}

		HotdealVO deal = hotdealService.getHotdealById(id);
		List<CommentVO> commentList = commentService.getCommentList(id);

		List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
		model.addAttribute("bestList", bestList);

		model.addAttribute("deal", deal);
		model.addAttribute("commentList", commentList);
		return "detail";
	}

	// [ADD] 종료 신고 처리 AJAX 엔드포인트
	@PostMapping("/reportEnd")
	@ResponseBody
	public Map<String, Object> reportEnd(@RequestParam("id") int id, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			response.put("status", "error");
			response.put("message", "로그인이 필요합니다.");
			return response;
		}

		HotdealVO updatedDeal = hotdealService.toggleEndStatus(id);

		if (updatedDeal != null) {
			response.put("status", "success");
			response.put("isEnded", updatedDeal.getIsEnded());
		} else {
			response.put("status", "error");
			response.put("message", "게시글을 찾을 수 없습니다.");
		}
		return response;
	}

	@PostMapping("/reportPost")
	@ResponseBody // AJAX 요청에 대한 응답
	public String reportPost(@RequestParam("hotdealId") int hotdealId, @RequestParam("reportType") String reportType,
			HttpSession session) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "not_logged_in"; // 로그인되지 않은 경우
		}

		try {
			ReportVO report = new ReportVO();
			report.setHotdealId(hotdealId);
			report.setReporterUserId(loginUser.getMemberId());
			report.setReportType(reportType);
			// status는 DB 기본값 'PENDING' 사용

			reportService.addReport(report);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
}