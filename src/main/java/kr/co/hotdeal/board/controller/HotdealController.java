package kr.co.hotdeal.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import kr.co.hotdeal.board.service.HotdealService;
import kr.co.hotdeal.board.vo.HotdealVO;
import kr.co.hotdeal.comment.service.CommentService;
import kr.co.hotdeal.comment.vo.CommentVO;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.product.service.ProductService;
import kr.co.hotdeal.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HotdealController {

    private final HotdealService hotdealService;
    private final CommentService commentService;
    private final ProductService productService;


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

    // [REVISED] 게시글 목록 - 카테고리 필터링 기능 추가
    @GetMapping("/list")
    public String list(
            Model model,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category) { // [ADD] category 파라미터 추가

        // [REVISED] 서비스 호출 시 category 전달
        List<HotdealVO> hotdealList = hotdealService.getHotdealList(page, keyword, category);
        int totalCount = hotdealService.getTotalCount(keyword, category);
        int perPageNum = 10;

        List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);
        
        // [ADD] DB에서 전체 카테고리 목록을 가져와 View에 전달
        List<String> categoryList = productService.getAllCategories();

        model.addAttribute("hotdealList", hotdealList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("perPageNum", perPageNum);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("bestList", bestList);
        model.addAttribute("categoryList", categoryList); // [ADD] 전체 카테고리 목록
        model.addAttribute("selectedCategory", category); // [ADD] 현재 선택된 카테고리

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
    public String write(
            @ModelAttribute HotdealVO hotdeal,
            @RequestParam("product.category") String category,
            @RequestParam("product.shopName") String shopName,
            @RequestParam("product.productName") String productName,
            @RequestParam("product.price") int price,
            @RequestParam("product.deliveryFee") String deliveryFee,
            @RequestParam(name = "product.relatedUrl", required = false) String relatedUrl,
            @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
            HttpSession session) throws IOException {

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
            if (!dir.exists()) dir.mkdirs();

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
}