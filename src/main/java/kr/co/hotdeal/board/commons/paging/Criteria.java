package kr.co.hotdeal.board.commons.paging;

public class Criteria {
    private int page;         // 현재 페이지 번호 (1부터 시작)
    private int perPageNum;   // 페이지당 게시글 수

    public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
    }

    public void setPage(int page) {
        this.page = (page <= 0) ? 1 : page;
    }

    public int getPage() {
        return page;
    }

    public void setPerPageNum(int perPageNum) {
        if (perPageNum <= 0 || perPageNum > 100) {
            this.perPageNum = 10;
        } else {
            this.perPageNum = perPageNum;
        }
    }

    public int getPerPageNum() {
        return perPageNum;
    }

    // Oracle 11g 이하 페이징 쿼리에서 사용할 시작 ROWNUM (1부터 시작)
    public int getPageStart() {
        return (this.page - 1) * perPageNum + 1;
    }

    // Oracle 11g 이하 페이징 쿼리에서 사용할 끝 ROWNUM
    public int getPageEnd() {
        return this.page * perPageNum;
    }
}
