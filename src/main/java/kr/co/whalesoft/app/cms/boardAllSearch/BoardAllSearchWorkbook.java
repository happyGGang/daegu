package kr.co.whalesoft.app.cms.boardAllSearch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;

public class BoardAllSearchWorkbook {

	private static final DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd");

	protected WritableWorkbook workbookForm(WritableWorkbook workbook, BoardAllSearch board, List<BoardAllSearch> boardList, List<BoardManage> boardManageList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "게시글 검색";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정

		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);

	    WritableSheet sheet = workbook.getSheet(0);

	    //header
	    int i=0;
	    sheet.addCell(new Label(i++, 0, "게시물번호", cellFormat));
  		sheet.addCell(new Label(i++, 0, "사이트명", cellFormat));
  		sheet.addCell(new Label(i++, 0, "게시판명", cellFormat));
  		sheet.addCell(new Label(i++, 0, "제목", cellFormat));
  		sheet.addCell(new Label(i++, 0, "링크", cellFormat));
  		sheet.addCell(new Label(i++, 0, "작성자", cellFormat));
  		sheet.addCell(new Label(i++, 0, "작성일", cellFormat));
  		sheet.addCell(new Label(i++, 0, "조회", cellFormat));
  		sheet.addCell(new Label(i++, 0, "첨부파일명", cellFormat));
  		sheet.addCell(new Label(i++, 0, "첨부파일 링크", cellFormat));

  		i=0;
  		sheet.setColumnView(i++, 10);
  		sheet.setColumnView(i++, 30);
  		sheet.setColumnView(i++, 30);
  		sheet.setColumnView(i++, 50);
  		sheet.setColumnView(i++, 50);
  		sheet.setColumnView(i++, 30);
  		sheet.setColumnView(i++, 15);
  		sheet.setColumnView(i++, 10);
  		sheet.setColumnView(i++, 50);
  		sheet.setColumnView(i++, 50);

  		for (int j = 0; j < boardList.size(); j++) {
  			i=0;
  			BoardAllSearch ap = boardList.get(j);
  			sheet.addCell(new Label(i++, j+1, String.valueOf(ap.getBoard_idx())));
  			sheet.addCell(new Label(i++, j+1, ap.getImsi_v_1()));
  			sheet.addCell(new Label(i++, j+1, ap.getBoard_name()));
  			sheet.addCell(new Label(i++, j+1, ap.getTitle()));
  			sheet.addCell(new Label(i++, j+1, "/" + ap.getImsi_v_2()  + "/board/view.do?manage_idx=" + ap.getManage_idx() + "&board_idx=" + ap.getBoard_idx()));
  			sheet.addCell(new Label(i++, j+1, ap.getUser_name() + "(" + ap.getAdd_id() + ")"));
  			sheet.addCell(new Label(i++, j+1, String.valueOf(new DateTime(ap.getAdd_date()).toString(dtf))));
  			sheet.addCell(new Label(i++, j+1, String.valueOf(ap.getView_count())));
  			if(ap.getBoardFileList() != null && ap.getBoardFileList().size() > 0) {
  				StringBuilder sb = new StringBuilder();
  				for(int k=0; k < ap.getBoardFileList().size(); k++) {
  					BoardFile file = ap.getBoardFileList().get(k);
  					sb.append(file.getFile_name() + "\r\n");
  				}
  				sheet.addCell(new Label(i++, j+1, sb.toString()));
  			}
  			if(ap.getBoardFileList() != null && ap.getBoardFileList().size() > 0) {
  				StringBuilder sb = new StringBuilder();
  				for(int k=0; k < ap.getBoardFileList().size(); k++) {
  					BoardFile file = ap.getBoardFileList().get(k);
  					sb.append("/board/boardFile/download/" + ap.getManage_idx() + "/" + file.getBoard_idx() + "/" + file.getFile_idx() + ".do" + "\r\n");
  				}
  				sheet.addCell(new Label(i++, j+1, sb.toString()));
  			}
  		}

  		return workbook;
	}

}
