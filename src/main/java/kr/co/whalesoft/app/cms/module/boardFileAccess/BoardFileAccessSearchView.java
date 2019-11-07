package kr.co.whalesoft.app.cms.module.boardFileAccess;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class BoardFileAccessSearchView  extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<BoardFileAccess> list = (List<BoardFileAccess>) model.get("boardList");
		BoardFileAccess BoardFileAccess = (BoardFileAccess) model.get("boardFileAccess");
		
		String homepageName = BoardFileAccess.getHomepage_name();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String toDayStr = sdf.format(new Date());
		String sheetName = homepageName + " (게시판 첨부파일 현황)";	//시트이름
		
		String fileName = homepageName + "_(게시판 첨부파일 현황)_+"+toDayStr+"+.xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");
		
		new BoardFileAccessWorkbook().workbookForm(workbook, list, sheetName, request, response);
	}

}
