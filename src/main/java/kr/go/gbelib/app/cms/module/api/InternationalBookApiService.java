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
public class InternationalBookApiService extends BaseService {
	@Autowired
	private BoardService boardService;

	public InternationalBookXmlResult internationalBookList(Board board, HttpServletRequest request, HttpServletResponse response) {

		InternationalBookXmlResult internationalBookXmlResult = new InternationalBookXmlResult();
		
		BoardManage boardManage = new BoardManage();
		boardManage.setBoard_type("BOOK");
		board.setManage_idx(658);
		
		List<Board> list = boardService.getBoard(boardManage, board);
		
		try {
			if(list.size() > 0) {
				for(int i =0 ; i < list.size(); i++) {
					if(StringUtils.isNotEmpty(list.get(i).getPreview_img())) {
						internationalBookXmlResult.setImage_url("https://library.daegu.go.kr/data/board/"+list.get(i).getManage_idx()+"/"+list.get(i).getBoard_idx()+"/"+list.get(i).getPreview_img());
					} else {
						internationalBookXmlResult.setImage_url("https://library.daegu.go.kr/resources/common/img/noimg-gall.png");
					}
					
					if(StringUtils.isNotEmpty(list.get(i).getTitle())) {
						internationalBookXmlResult.setTitle(list.get(i).getTitle());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_3())) {
						internationalBookXmlResult.setAuthor(list.get(i).getImsi_v_3());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_4())) {
						internationalBookXmlResult.setPublisher(list.get(i).getImsi_v_4());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_2())) {
						internationalBookXmlResult.setPubyear(list.get(i).getImsi_v_2());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_6())) {
						internationalBookXmlResult.setLoc_name(list.get(i).getImsi_v_6());
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_7())) {
						internationalBookXmlResult.setCall_no(list.get(i).getImsi_v_7());
					}
					if(StringUtils.isNotEmpty(list.get(i).getContent())) {
						String content = list.get(i).getContent();

						String replaceContent = content.replaceAll("<.*?>", "");
						replaceContent.replaceAll("&nbsp;", " ");

						internationalBookXmlResult.setContents(replaceContent);
					}
					if(StringUtils.isNotEmpty(list.get(i).getImsi_v_8())) {
						internationalBookXmlResult.setReg_no(list.get(i).getImsi_v_8());
					}
					
					internationalBookXmlResult.setMessage("국제 추천도서 게시판 데이터 조회 성공.");
				}
			} else {
				internationalBookXmlResult.setMessage("등록되어있는 국제 추천도서 게시판 데이터가 없습니다.");
			}
		} catch(Exception e) {
			internationalBookXmlResult.setMessage("국제 추천도서 게시판 데이터를 조회하는데 오류가 발생하였습니다.");
			return internationalBookXmlResult;
		}

		return internationalBookXmlResult;
	}

}
