package kr.hotdeal;

import kr.co.hotdeal.board.service.HotdealService;
import kr.co.hotdeal.board.vo.HotdealVO;
import kr.co.hotdeal.comment.dao.CommentDAO;
import kr.co.hotdeal.comment.vo.CommentVO;
import kr.co.hotdeal.member.dao.MemberDAO;
import kr.co.hotdeal.member.vo.MemberVO;
import kr.co.hotdeal.product.dao.ProductDAO;
import kr.co.hotdeal.product.vo.ProductVO;
import kr.co.hotdeal.vote.dao.VoteDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.*;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class BoardAutoPopulateTest {

    @Autowired
    private HotdealService hotdealService;

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CommentDAO commentDAO;

    @Autowired
    private VoteDAO voteDAO;

    @Autowired
    private MemberDAO memberDAO;

    private static final String[] CATEGORIES = {
        "먹거리", "sw/게임", "pc제품", "가전제품", "생활용품", "의류", "세일정보", "화장품", "모바일/상품권", "해외핫딜", "기타"
    };

    private static final String[] SAMPLE_COMMENTS = {
        "좋은 정보 감사합니다!", "이거 진짜 싸네요!", "구매했습니다~", "정보 공유 감사해요.", "와... 이 가격 실화인가요?",
        "배송비가 좀 아쉽네요.", "품절이네요 ㅠㅠ", "추천드립니다!", "비추천 이유가 뭔가요?", "이거 사도 될까요?"
    };

    private static final Random RANDOM = new Random();

    /** 테스트용 회원 생성 및 등록 (존재하지 않으면) */
    private MemberVO getOrCreateTestMember(String username) {
        MemberVO member = memberDAO.selectMemberByUsername(username);
        if (member == null) {
            member = new MemberVO();
            member.setUsername(username);
            member.setPassword("testpw");
            member.setName(username + "이름");
            member.setEmail(username + "@test.com");
            memberDAO.insertMember(member);
            member = memberDAO.selectMemberByUsername(username);
        }
        return member;
    }

    /** 테스트용 상품 생성 및 등록 */
    private ProductVO createAndInsertProduct(String productName) {
        ProductVO product = new ProductVO();
        product.setProductId(UUID.randomUUID().toString());
        product.setCategory(CATEGORIES[RANDOM.nextInt(CATEGORIES.length)]);
        product.setShopName("테스트쇼핑몰" + RANDOM.nextInt(10));
        product.setProductName(productName);
        product.setPrice(1000 + RANDOM.nextInt(100000));
        product.setDeliveryFee(RANDOM.nextBoolean() ? "0" : String.valueOf(1000 + RANDOM.nextInt(5000)));
        product.setRelatedUrl("https://shop" + RANDOM.nextInt(100) + ".com");
        product.setProductImage("test" + RANDOM.nextInt(100) + ".jpg");
        productDAO.insertProduct(product);
        return product;
    }

    /** 게시글 자동 등록, 댓글/추천/비추천 자동 입력 */
    @Test
    public void 게시판_자동_채우기_테스트() {
        int 게시글_개수 = 10;
        int 유저_수 = 5;
        int 댓글_최대_개수 = 6;
        int 추천_비추천_최대 = 10;

        // 테스트용 회원 여러 명 생성
        List<MemberVO> memberList = new ArrayList<>();
        for (int i = 1; i <= 유저_수; i++) {
            memberList.add(getOrCreateTestMember("testuser" + i));
        }

        // 게시글 여러 개 등록
        List<HotdealVO> hotdealList = new ArrayList<>();
        for (int i = 1; i <= 게시글_개수; i++) {
            ProductVO product = createAndInsertProduct("자동등록상품" + i);
            HotdealVO vo = new HotdealVO();
            vo.setTitle("자동등록 게시글 " + i);
            vo.setAuthor(memberList.get(RANDOM.nextInt(memberList.size())).getUsername());
            vo.setThumbnail("auto" + i + ".jpg");
            vo.setContent("자동으로 등록된 게시글 내용입니다. [" + i + "]");
            vo.setProductId(product.getProductId());
            vo.setCategory(product.getCategory());
            vo.setViews(RANDOM.nextInt(300));
            vo.setLikes(0);
            vo.setDislikes(0);
            hotdealService.insertHotdeal(vo);
            hotdealList.add(vo);

            // 댓글 달기 (랜덤 개수)
            int 댓글개수 = 1 + RANDOM.nextInt(댓글_최대_개수);
            for (int c = 0; c < 댓글개수; c++) {
                CommentVO comment = new CommentVO();
                comment.setHotdealId(vo.getId());
                comment.setParentId(null);
                comment.setUsername(memberList.get(RANDOM.nextInt(memberList.size())).getUsername());
                comment.setContent(SAMPLE_COMMENTS[RANDOM.nextInt(SAMPLE_COMMENTS.length)]);
                commentDAO.insertComment(comment);
            }

            // 추천/비추천 랜덤 등록
            int 추천수 = RANDOM.nextInt(추천_비추천_최대);
            int 비추천수 = RANDOM.nextInt(추천_비추천_최대);
            Set<String> usedUserForLike = new HashSet<>();
            Set<String> usedUserForDislike = new HashSet<>();
            for (int l = 0; l < 추천수; l++) {
                String user = memberList.get(RANDOM.nextInt(memberList.size())).getUsername();
                if (usedUserForLike.add(user)) {
                    voteDAO.insertVote(vo.getId(), user, "LIKE");
                    hotdealService.increaseLikes(vo.getId());
                }
            }
            for (int d = 0; d < 비추천수; d++) {
                String user = memberList.get(RANDOM.nextInt(memberList.size())).getUsername();
                if (usedUserForDislike.add(user)) {
                    voteDAO.insertVote(vo.getId(), user, "DISLIKE");
                    hotdealService.increaseDislikes(vo.getId());
                }
            }
        }

        // 검증: 게시글, 댓글, 추천/비추천이 잘 들어갔는지 일부 출력
        System.out.println("자동 등록된 게시글/댓글/추천/비추천 샘플:");
        for (HotdealVO vo : hotdealList) {
            HotdealVO loaded = hotdealService.getHotdealById(vo.getId());
            System.out.println("[" + loaded.getId() + "] " + loaded.getTitle()
                    + " / 추천: " + loaded.getLikes() + " / 비추천: " + loaded.getDislikes());
        }
    }
}
