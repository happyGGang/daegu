package kr.co.whalesoft.app.cms.boardAllSearch;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BoardAllSearchView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		BoardAllSearch board = (BoardAllSearch) model.get("board");
		List<BoardAllSearch> boardList = (List<BoardAllSearch>) model.get("boardList"); 
		List<BoardManage> boardManageList = (List<BoardManage>) model.get("boardManageList");
		
		String fileName = "게시글_검색.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new BoardAllSearchWorkbook().workbookForm(workbook, board, boardList, boardManageList, request, response);
	}

}
