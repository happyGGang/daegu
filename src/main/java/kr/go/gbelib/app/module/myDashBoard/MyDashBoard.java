package kr.go.gbelib.app.module.myDashBoard;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MyDashBoard extends PagingUtils {

	private int loanCnt = 0;//소속도서관 대출건수
	private int otherLoanCnt = 0;//타도서관 대출건수
	private int delayCnt = 0; //연체건수
	private int teachApplyCnt = 0;	//강좌신청수
	private int boardCount = 0;	//게시글 수
	private int replyCount = 0;	//댓글 수
	private int myItemCount = 0;	//보관함 갯수

	public int getLoanCnt() {
		return loanCnt;
	}

	public int getOtherLoanCnt() {
		return otherLoanCnt;
	}

	public int getDelayCnt() {
		return delayCnt;
	}

	public void setLoanCnt(int loanCnt) {
		this.loanCnt = loanCnt;
	}

	public void setOtherLoanCnt(int otherLoanCnt) {
		this.otherLoanCnt = otherLoanCnt;
	}

	public void setDelayCnt(int delayCnt) {
		this.delayCnt = delayCnt;
	}


	public int getTeachApplyCnt() {
		return teachApplyCnt;
	}


	public void setTeachApplyCnt(int teachApplyCnt) {
		this.teachApplyCnt = teachApplyCnt;
	}


	public int getBoardCount() {
		return boardCount;
	}


	public int getReplyCount() {
		return replyCount;
	}


	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}


	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}


	public int getMyItemCount() {
		return myItemCount;
	}


	public void setMyItemCount(int myItemCount) {
		this.myItemCount = myItemCount;
	}

}
