package kr.go.gbelib.app.module.boardHistory;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.cms.member.Member;

public class BoardHistory extends Board {

	private Member boardMember;
	private String historyType = "board";
	
	public Member getBoardMember() {
		return boardMember;
	}

	public void setBoardMember(Member boardMember) {
		this.boardMember = boardMember;
	}

	
	public String getHistoryType() {
		return historyType;
	}

	
	public void setHistoryType(String historyType) {
		this.historyType = historyType;
	}
	
}
