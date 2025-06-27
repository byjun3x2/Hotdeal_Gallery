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

    // 게시글 목록
    @GetMapping("/list")
    public String list(
            Model model,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "keyword", required = false) String keyword) {

        // 1. 일반 게시글 목록 조회 (페이징, 검색 포함)
        List<HotdealVO> hotdealList = hotdealService.getHotdealList(page, keyword);
        int totalCount = hotdealService.getTotalCount(keyword);
        int perPageNum = 10;

        // 2. 베스트 게시글 목록 조회 (상위 10개)
        List<HotdealVO> bestList = hotdealService.getBestHotdealList(10);

        // 3. View(JSP)로 데이터 전달을 위해 Model에 속성 추가
        model.addAttribute("hotdealList", hotdealList); // 일반 게시글 리스트
        model.addAttribute("totalCount", totalCount);   // 전체 게시글 수
        model.addAttribute("perPageNum", perPageNum); // 페이지당 보여줄 게시글 수
        model.addAttribute("page", page);                 // 현재 페이지 번호
        model.addAttribute("keyword", keyword);         // 검색 키워드
        model.addAttribute("bestList", bestList);       // 베스트 게시글 리스트

        // 4. "list.jsp" 파일을 찾아 렌더링하도록 뷰 이름 반환
        return "list";
    }
    // 글쓰기 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        return "write";
    }

    // 글 등록 처리
    @PostMapping("/write")
    public String write(
            @ModelAttribute HotdealVO hotdeal,
            // ProductVO의 필드들을 명시적으로 @RequestParam으로 받아 데이터 바인딩 오류를 방지합니다.
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
        
        // ProductVO 객체를 생성하고, 명시적으로 받은 파라미터들로 값을 설정합니다.
        ProductVO product = new ProductVO();
        product.setCategory(category);
        product.setShopName(shopName);
        product.setProductName(productName);
        product.setPrice(price);
        product.setDeliveryFee(deliveryFee);
        product.setRelatedUrl(relatedUrl);

        // 핫딜 VO에도 카테고리 설정
        hotdeal.setCategory(category);

        // 썸네일 업로드 처리
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


        // 1. 상품의 productId UUID 생성
        String uuid = UUID.randomUUID().toString();
        product.setProductId(uuid);

        // 2. 썸네일 경로를 productImage에도 세팅
        product.setProductImage(hotdeal.getThumbnail());
        
        // 3. 상품 정보 먼저 저장 (product 테이블)
        productService.insertProduct(product);

        // 4. 핫딜 정보에 productId 세팅
        hotdeal.setProductId(product.getProductId());

        // 5. 핫딜 정보 저장 (hotdeal 테이블)
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
        model.addAttribute("deal", deal);
        model.addAttribute("commentList", commentList);
        return "detail";
    }
}
