package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.Label;
import jxl.write.WritableWorkbook;
import jxl.write.Number;
import kr.co.whalesoft.app.cms.code.Code;

public class LibSvcStatisticsWorkbook {
	
	protected WritableWorkbook workbookForm(WritableWorkbook workbook, List<Map<String, Object>> listMap, List<Code> codeList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String sheetName = "도서관 서비스 통계";	//시트이름
		workbook.createSheet(sheetName, 0);	//시트설정
		
		//header
		workbook.getSheet(0).addCell(new Label(0, 0, "구분"));
		workbook.getSheet(0).mergeCells(0, 0, 0, 2);
		
		workbook.getSheet(0).addCell(new Label(1, 0, "프로젝트사이트"));
		workbook.getSheet(0).mergeCells(1, 0, codeList.size() * 3, 0);
		
		for(int i = 0; i < codeList.size(); i++) {
			workbook.getSheet(0).addCell(new Label(1 + (i * 3), 1, codeList.get(i).getCode_name()));
			workbook.getSheet(0).mergeCells(1 + (i * 3), 1, 3 + (i * 3), 1);
		}
		
		for(int i = 0; i < codeList.size(); i++) {
			workbook.getSheet(0).addCell(new Label(1 + (i * 3), 2, "요청"));
			workbook.getSheet(0).addCell(new Label(2 + (i * 3) , 2, "완료"));
			workbook.getSheet(0).addCell(new Label(3 + (i * 3) , 2, "합계"));
		}
		
		for(int i = 0; i < listMap.size(); i++) {
			Map<String, Object> map = listMap.get(i);
			workbook.getSheet(0).addCell(new Label(0, 3 + i, (String)map.get("homepage_name")));
			
			String[] keys = {"I", "C", "D", "E"};
			int j = 0;
			for(String key : keys) {
				LibSvcStatistics o = (LibSvcStatistics)map.get(key);
				
				workbook.getSheet(0).addCell(new Number(1 + (j*3), 3 + i, o.getReq_cnt()));
				workbook.getSheet(0).addCell(new Number(2 + (j*3), 3 + i, o.getCmp_cnt()));
				workbook.getSheet(0).addCell(new Number(3 + (j*3), 3 + i, o.getSum_cnt()));
				j++;
			}
			
		}
		
		return workbook;
	}

}