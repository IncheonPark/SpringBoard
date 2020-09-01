package ino.web.freeBoard.util;

public class FreeBoardPagination {
	
	public static final int PAGE_SIZE = 10;
	public static final int BLOCK_SIZE = 10;
	
	private int totalList = 1; //총 게시글 수

	private int totalPage = 1; //총 페이지 수
	private int curPageNum = 1; //현재 페이지 번호
	private int startPageNum = 1; //시작 페이지 번호
	private int endPageNum = 1; //끝 페이지 번호
	private int prePageNum = 1; //이전 페이지 번호
	private int nextPageNum = 1; //다음 페이지 번호
	
	private int totalBlock = 1; //총 블록 수
	private int curBlockNum = 1; //현재 블록 번호
	
	private int startIndexNum = 0;

//생성자
	public FreeBoardPagination(int curPageNum, int totalList) {
		setTotalList(totalList);
		
		setTotalPage(totalList);
		setCurPageNum(curPageNum);
		
		setTotalBlock(totalPage);
		setCurBlockNum(curPageNum);
		
		setPrePageNum(curPageNum);
		setNextPageNum(curPageNum);
		
		setStartPageNum(curBlockNum);
		setEndPageNum(startPageNum);
		
		setStartIndexNum(curPageNum);
	}
	
//페이지 세팅------------------------------------------	
	public int getTotalList() {
		return totalList;
	}

	public void setTotalList(int totalList) {
		this.totalList = totalList;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalList) {
		this.totalPage = (int)Math.ceil((totalList*1.0) /PAGE_SIZE);
	}

	public int getCurPageNum() {
		return curPageNum;
	}

	public void setCurPageNum(int curPageNum) {
		this.curPageNum = curPageNum;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public void setStartPageNum(int curBlockNum) {
		System.out.println("현재 블럭 넘버 : "+curBlockNum);
		//this.startPageNum = (int)(((curPageNum-1) / BLOCK_SIZE) +1);
		this.startPageNum = (int)(((curBlockNum-1) * BLOCK_SIZE) +1);
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public void setEndPageNum(int startPageNum) {
		this.endPageNum = (int)(startPageNum + BLOCK_SIZE -1 );
		if (endPageNum > totalPage) endPageNum = totalPage;
	}

	public int getPrePageNum() {
		return prePageNum;
	}

	public void setPrePageNum(int curPageNum) {
		this.prePageNum = curPageNum-1;
		if (prePageNum < 1) prePageNum = 1;
	}

	public int getNextPageNum() {
		return nextPageNum;
	}

	public void setNextPageNum(int curPageNum) {
		this.nextPageNum = curPageNum+1;
		if (nextPageNum > totalPage) nextPageNum = totalPage;
	}

	//블록 세팅------------------------------------------	
	
	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalPage) {
		this.totalBlock = (int)Math.ceil((totalPage*1.0) / BLOCK_SIZE);
	}

	public int getCurBlockNum() {
		return curBlockNum;
	}

	public void setCurBlockNum(int curPageNum) {
		this.curBlockNum = (int)(((curPageNum-1) / BLOCK_SIZE)+1);
	}

	public int getStartIndexNum() {
		return startIndexNum;
	}

	//쿼리문 시작 인덱스 세팅------------------------------------------
	
	public void setStartIndexNum(int curPageNum) {
		this.startIndexNum = (int)(curPageNum-1) * PAGE_SIZE+1; //1, 11, 21 ,31....
	}


}
