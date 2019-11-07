package kr.co.whalesoft.app.board;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;

public class RelayExcelView extends AbstractJExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Board board = (Board) model.get("board");
		
		@SuppressWarnings("unchecked")
		List<Board> boardList = (List<Board>) model.get("boardList");
		
		String name = board.getImsi_v_1() + " 독서릴레이";
		
		workbook.createSheet(name, 0); // 시트설정

		name += ".xls";
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);

		// 중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		// 테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_GREEN);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0,  20);//제목
		workbook.getSheet(0).setColumnView(1,  20);//내용
		workbook.getSheet(0).setColumnView(2,  20);//작성자
		workbook.getSheet(0).setColumnView(3,  20);//학교명
		workbook.getSheet(0).setColumnView(4,  20);//도서명
		workbook.getSheet(0).setColumnView(5,  20);//학년
		workbook.getSheet(0).setColumnView(6,  20);//등록일

		
		workbook.getSheet(0).addCell(new Label(0, 0, "제목", format));
		workbook.getSheet(0).addCell(new Label(1, 0, "내용", format));
		workbook.getSheet(0).addCell(new Label(2, 0, "작성자", format));
		workbook.getSheet(0).addCell(new Label(3, 0, "학교명", format));
		workbook.getSheet(0).addCell(new Label(4, 0, "도서명", format));
		workbook.getSheet(0).addCell(new Label(5, 0, "학년", format));
		workbook.getSheet(0).addCell(new Label(6, 0, "등록일", format));

		// 헤더 컬럼 지정

		int row = 1;
		for ( Board b : boardList ) {
			workbook.getSheet(0).addCell(new Label(0, row, b.getTitle()));
			workbook.getSheet(0).addCell(new Label(1, row, b.getContent()));
			workbook.getSheet(0).addCell(new Label(2, row, b.getUser_name()));
			workbook.getSheet(0).addCell(new Label(3, row, b.getCategory1()));
			workbook.getSheet(0).addCell(new Label(4, row, b.getCategory2()));
			workbook.getSheet(0).addCell(new Label(5, row, b.getCategory3()));
			workbook.getSheet(0).addCell(new Label(6, row, b.getImsi_v_2()));
			
			row++;
		}

	}
}
