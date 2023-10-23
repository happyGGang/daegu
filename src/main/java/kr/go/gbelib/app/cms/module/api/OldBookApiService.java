package kr.go.gbelib.app.cms.module.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class OldBookApiService extends BaseService {
	@Autowired
	private BoardService boardService;

	public OldBookXmlResult oldBookList(Board board, HttpServletRequest request, HttpServletResponse response) {

		OldBookXmlResult oldBookXmlResult = new OldBookXmlResult();
		
		BoardManage boardManage = new BoardManage();
		boardManage.setBoard_type("OLDBOOK");
		
		List<Board> list = boardService.getBoard(boardManage, board);
		
		try {
			if(list.size() > 0) {
				for(int i =0 ; i < list.size(); i++) {
					if(StringUtils.isNotEmpty(list.get(i).getPreview_img())) {
						oldBookXmlResult.setImage_url("https://library.daegu.go.kr/data/board/"+list.get(i).getManage_idx()+"/"+list.get(i).getBoard_idx()+"/"+list.get(i).getPreview_img());
					} else {
						oldBookXmlResult.setImage_url("https://library.daegu.go.kr/resources/common/img/noimg-gall.png");
					}
					
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_4())) {
						oldBookXmlResult.setUrl1(list.get(i).getImsi_v_4());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_6())) {
						oldBookXmlResult.setUrl2(list.get(i).getImsi_v_6());
					}
					if(StringUtils.isNotEmpty(list.get(i).getTitle())) {
						oldBookXmlResult.setTitle(list.get(i).getTitle());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_2())) {
						oldBookXmlResult.setAuthor(list.get(i).getImsi_v_2());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_3())) {
						oldBookXmlResult.setPubdata(list.get(i).getImsi_v_3());
					}
					if(StringUtils.isNotEmpty(list.get(i).getContent())) {
						oldBookXmlResult.setContents(list.get(i).getContent());
					}
					
					oldBookXmlResult.setMessage("국제 옛자료실 데이터 조회 성공.");
				}
			} else {
				oldBookXmlResult.setMessage("등록되어있는 옛자료실 데이터가 없습니다.");
			}
		} catch(Exception e) {
			oldBookXmlResult.setMessage("옛자료실 게시판 데이터를 조회하는데 오류가 발생하였습니다.");
			return oldBookXmlResult;
		}

		return oldBookXmlResult;
	}

}
