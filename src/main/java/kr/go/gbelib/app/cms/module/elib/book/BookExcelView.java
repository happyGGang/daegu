package kr.go.gbelib.app.cms.module.elib.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

public class BookExcelView {

    public void generateExcel(List<Book> bookList, Book book, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = book.getType();
        String typeName = getTypeName(type);
        String countName = "EBK".equals(type) ? "대출횟수" : "이용횟수";
        String fileName = type + "_List_" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xlsx";

        setResponseHeader(request, response, fileName);

        SXSSFWorkbook workbook = null;
        try {
            workbook = new SXSSFWorkbook();
            Sheet sheet = getSheet(workbook);

            CellStyle headerStyle = getHeaderStyle(workbook);

            CellStyle centerStyle = getCenterStyle(workbook);

            Row header = sheet.createRow(0);
            String[] headers = {"내부등록번호", "1차 카테고리", "2차 카테고리", countName, "조회수", "책제목", "저자", "출판사", "ISBN", "포맷", "도서관명", "공급사"};
            for (int i = 0; i < headers.length; i++) {
                createStyledCell(header, i, headers[i], headerStyle);
            }

            int rowNum = 1;
            for (Book org : bookList) {
                Row row = sheet.createRow(rowNum++);
                populateRowWithBookData(row, org, centerStyle);
            }

            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getTypeName(String type) {
        switch (type) {
            case "EBK":
                return "전자책";
            case "WEB":
                return "온라인강좌";
            case "ADO":
                return "오디오북";
            default:
                return "미분류";
        }
    }

    private void setResponseHeader(HttpServletRequest request, HttpServletResponse response, String fileName) throws UnsupportedEncodingException {
        String agentHeader = request.getHeader("user-agent");
        String encodedFileName;

        if (agentHeader.contains("MSIE") || agentHeader.contains("Trident")) {
            encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (agentHeader.contains("Edge")) {
            encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } else {
            encodedFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        response.setContentType("application/vnd.ms-excel");
    }

    private Sheet getSheet(SXSSFWorkbook workbook) {
        Sheet sheet = workbook.createSheet("콘텐츠 목록");
        sheet.setColumnWidth(0, 20 * 256);
        sheet.setColumnWidth(1, 20 * 256);
        sheet.setColumnWidth(2, 20 * 256);
        sheet.setColumnWidth(3, 10 * 256);
        sheet.setColumnWidth(4, 10 * 256);
        sheet.setColumnWidth(5, 50 * 256);
        sheet.setColumnWidth(6, 40 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        sheet.setColumnWidth(8, 20 * 256);
        sheet.setColumnWidth(9, 10 * 256);
        sheet.setColumnWidth(10, 30 * 256);
        sheet.setColumnWidth(11, 20 * 256);
        return sheet;
    }

    private CellStyle getHeaderStyle(SXSSFWorkbook workbook) {
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());
        headerStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        headerStyle.setBorderTop(CellStyle.BORDER_MEDIUM);
        headerStyle.setBorderBottom(CellStyle.BORDER_MEDIUM);
        headerStyle.setBorderLeft(CellStyle.BORDER_MEDIUM);
        headerStyle.setBorderRight(CellStyle.BORDER_MEDIUM);
        return headerStyle;
    }

    private CellStyle getCenterStyle(SXSSFWorkbook workbook) {
        CellStyle centerStyle = workbook.createCellStyle();
        centerStyle.setAlignment(CellStyle.ALIGN_CENTER);
        return centerStyle;
    }

    private void createStyledCell(Row row, int columnIndex, String value, CellStyle style) {
        Cell cell = row.createCell(columnIndex);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    private void populateRowWithBookData(Row row, Book book, CellStyle style) {
        createStyledCell(row, 0, String.valueOf(book.getBook_idx()), style);
        createStyledCell(row, 1, book.getParent_name(), style);
        createStyledCell(row, 2, book.getCate_name(), style);
        createStyledCell(row, 3, String.valueOf(book.getLend_total()), style);
        createStyledCell(row, 4, String.valueOf(book.getView_count()), style);
        createStyledCell(row, 5, book.getBook_name(), style);
        createStyledCell(row, 6, book.getAuthor_name(), style);
        createStyledCell(row, 7, book.getBook_pubname(), style);
        createStyledCell(row, 8, book.getIsbn13(), style);
        createStyledCell(row, 9, book.getFormat(), style);
        createStyledCell(row, 10, book.getLibrary_name(), style);
        createStyledCell(row, 11, book.getComp_name(), style);
    }

}
