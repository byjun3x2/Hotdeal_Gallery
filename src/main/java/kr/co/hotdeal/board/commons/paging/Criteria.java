package kr.co.hotdeal.board.commons.paging;

public class Criteria {
	private int page;
	private int perPageNum;

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

	public int getPageStart() {
		return (this.page - 1) * perPageNum + 1;
	}

	public int getPageEnd() {
		return this.page * perPageNum;
	}
}
