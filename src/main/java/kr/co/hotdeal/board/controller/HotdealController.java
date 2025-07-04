package kr.co.hotdeal.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
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
	private final ReportService reportService;

	@RequestMapping("/hello")
	public String hello() {
		return "default";
	}

	@Controller
	public class HomeController {
		@GetMapping("/")
		public String home() {
			return "redirect:/list";
		}
	}

	@GetMapping("/list")
	public String list(Model model, Criteria criteria,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "sortColumn", required = false, defaultValue = "regDate") String sortColumn,
			@RequestParam(value = "sortOrder", required = false, defaultValue = "desc") String sortOrder) {

		List<HotdealVO> noticeList = hotdealService.getNoticeList();
		List<HotdealVO> hotdealList = hotdealService.getHotdealList(criteria, keyword, category, sortColumn, sortOrder);
		int totalCount = hotdealService.getTotalCount(keyword, category);

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("hotdealList", hotdealList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("criteria", criteria);
		model.addAttribute("keyword", keyword);
		model.addAttribute("selectedCategory", category);
		model.addAttribute("sortColumn", sortColumn);
		model.addAttribute("sortOrder", sortOrder);

		List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
		model.addAttribute("bestList", bestList);

		List<String> categoryList = productService.getAllCategories();
		model.addAttribute("categoryList", categoryList);

		return "list";
	}

	@GetMapping("/write")
	public String writeForm(HttpSession session, Model model) {
		if (session.getAttribute("loginUser") == null) {
			return "redirect:/login";
		}
		List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
		model.addAttribute("bestList", bestList);
		return "write";
	}

	@PostMapping("/write")
	public String write(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam(value = "thumbnail", required = false) String thumbnail,
			@RequestParam(value = "product.category", required = false) String category,
			@RequestParam(value = "product.shopName", required = false) String shopName,
			@RequestParam(value = "product.productName", required = false) String productName,
			@RequestParam(value = "product.price", required = false) Integer price,
			@RequestParam(value = "product.deliveryFee", required = false) String deliveryFee,
			@RequestParam(name = "product.relatedUrl", required = false) String relatedUrl,
			@RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
			@RequestParam(value = "isNotice", required = false) String isNotice, HttpSession session, Model model)
			throws IOException {

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		if (member == null) {
			return "redirect:/login";
		}

		HotdealVO hotdeal = new HotdealVO();
		hotdeal.setTitle(title);
		hotdeal.setContent(content);
		hotdeal.setThumbnail(thumbnail);
		hotdeal.setAuthor(member.getUsername());

		boolean isAdminNotice = "ROLE_ADMIN".equals(member.getRole()) && "Y".equals(isNotice);
		hotdeal.setIsNotice(isAdminNotice ? "Y" : "N");

		ProductVO product = new ProductVO();
		if (isAdminNotice) {
			product.setCategory("공지");
			product.setShopName("공지사항");
			product.setProductName(hotdeal.getTitle());
			product.setPrice(0);
			product.setDeliveryFee("0");
			product.setRelatedUrl("");
		} else {
			if (category == null || category.isEmpty() || shopName == null || shopName.isEmpty() || productName == null
					|| productName.isEmpty() || price == null || deliveryFee == null || deliveryFee.isEmpty()) {
				model.addAttribute("msg", "일반글은 상품 관련 정보를 모두 입력해야 합니다.");
				model.addAttribute("deal", hotdeal);
				return "write";
			}
			product.setCategory(category);
			product.setShopName(shopName);
			product.setProductName(productName);
			product.setPrice(price);
			product.setDeliveryFee(deliveryFee);
			product.setRelatedUrl(relatedUrl);
		}

		hotdeal.setCategory(product.getCategory());

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
		productService.insertProduct(product);
		hotdeal.setProductId(product.getProductId());
		hotdealService.insertHotdeal(hotdeal);

		return "redirect:/list";
	}

	@GetMapping("/edit")
	public String editForm(@RequestParam("id") int id, Model model, HttpSession session) {
		HotdealVO deal = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (deal == null || loginUser == null || !deal.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}
		model.addAttribute("deal", deal);
		return "edit";
	}

	@PostMapping("/edit")
	public String editHotdeal(@RequestParam("id") int id, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("product.productId") String productId,
			@RequestParam("product.category") String category, @RequestParam("product.shopName") String shopName,
			@RequestParam("product.productName") String productName, @RequestParam("product.price") int price,
			@RequestParam("product.deliveryFee") String deliveryFee,
			@RequestParam("product.relatedUrl") String relatedUrl,
			@RequestParam(value = "thumbnail", required = false) String thumbnailUrl,
			@RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
			@RequestParam(value = "isNotice", required = false) String isNotice, Model model, HttpSession session) {

		HotdealVO origin = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (origin == null || loginUser == null || !origin.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}

		String thumbnail = thumbnailUrl;
		if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
			try {
				String uploadDir = "C:/upload";
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

		ProductVO product = new ProductVO();
		product.setProductId(productId);
		product.setCategory(category);
		product.setShopName(shopName);
		product.setProductName(productName);
		product.setPrice(price);
		product.setDeliveryFee(deliveryFee);
		product.setRelatedUrl(relatedUrl);
		productService.updateProduct(product);

		HotdealVO vo = new HotdealVO();
		vo.setId(id);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setThumbnail(thumbnail);
		vo.setProductId(productId);
		if ("ROLE_ADMIN".equals(loginUser.getRole()) && "Y".equals(isNotice)) {
			vo.setIsNotice("Y");
		} else {
			vo.setIsNotice("N");
		}
		hotdealService.updateHotdeal(vo);

		return "redirect:/detail?id=" + id;
	}

	@PostMapping("/delete")
	public String deleteHotdeal(@RequestParam("id") int id, HttpSession session, Model model) {
		HotdealVO deal = hotdealService.getHotdealById(id);
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (deal == null || loginUser == null || !deal.getAuthor().equals(loginUser.getUsername())) {
			model.addAttribute("msg", "삭제 권한이 없습니다.");
			return "redirect:/detail?id=" + id;
		}
		hotdealService.deleteHotdeal(id);
		return "redirect:/list?page=1";
	}

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
	@ResponseBody
	public String reportPost(@RequestParam("hotdealId") int hotdealId, @RequestParam("reportType") String reportType,
			HttpSession session) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "not_logged_in";
		}
		try {
			ReportVO report = new ReportVO();
			report.setHotdealId(hotdealId);
			report.setReporterUserId(loginUser.getMemberId());
			report.setReportType(reportType);
			reportService.addReport(report);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	@RestController
	@RequestMapping("/notice")
	@RequiredArgsConstructor
	public class HotdealRestController {

		private final HotdealService hotdealService;

		@GetMapping("/list")
		public List<Map<String, Object>> getNoticeList() {
			List<HotdealVO> noticeList = hotdealService.getNoticeList();
			// 필요한 필드만 추려서 반환 (id, title)
			List<Map<String, Object>> result = new ArrayList<>();
			for (HotdealVO vo : noticeList) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", vo.getId());
				map.put("title", vo.getTitle());
				result.add(map);
			}
			return result;
		}
	}
}