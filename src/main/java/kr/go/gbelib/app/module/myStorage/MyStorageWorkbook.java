package kr.go.gbelib.app.module.myStorage;

import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableWorkbook;
import kr.go.gbelib.app.module.myItem.MyItem;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class MyStorageWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<MyItem> menuAccessList, String sheetName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		workbook.createSheet(sheetName, 0);	//시트설정
		List<MyItem> list = menuAccessList;
		
		/*String AM = "09:00";
		String PM = "13:10";*/
		
		//bold font
		WritableFont cellFont = new WritableFont(WritableFont.COURIER, 10);
	    cellFont.setBoldStyle(WritableFont.BOLD);
	    WritableCellFormat cellFormat = new WritableCellFormat(cellFont);
		
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "보관함명", cellFormat));
		workbook.getSheet(0).addCell(new Label(1, 0, "제목", cellFormat));
		workbook.getSheet(0).addCell(new Label(2, 0, "저자", cellFormat));
		workbook.getSheet(0).addCell(new Label(3, 0, "청구기호", cellFormat));
		workbook.getSheet(0).addCell(new Label(4, 0, "등록아이디", cellFormat));
		workbook.getSheet(0).addCell(new Label(5, 0, "등록일", cellFormat));

		for (int i = 0; i < list.size(); i++) {
			MyItem myItem = list.get(i);
			workbook.getSheet(0).addCell(new Label(0, i+1, myItem.getStorage_name()));
			workbook.getSheet(0).addCell(new Label(1, i+1, myItem.getItem_name()));
			workbook.getSheet(0).addCell(new Label(2, i+1, myItem.getAuthor()));
			workbook.getSheet(0).addCell(new Label(3, i+1, myItem.getCall_no()));
			workbook.getSheet(0).addCell(new Label(4, i+1, myItem.getMember_key()));
			workbook.getSheet(0).addCell(new Label(5, i+1, myItem.getAdd_date()));
		}
		
		return workbook;
	}

}
