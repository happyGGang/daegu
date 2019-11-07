package kr.go.gbelib.app.cms.module.newBookDream;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.homepage.module.bookDream.BookDream;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.HangulEnDecoder;

public class NewBookDreamWriteCsv {

	public NewBookDreamWriteCsv(List<BookDream> bookDreamList, String fileName, HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType("text/csv; charset=CP949");
			
			StringBuffer data = new StringBuffer();
			
			int totalPay = 0;
			data.append("새 책 드림 서비스 도서구입목록\n");
			data.append("("+bookDreamList.size()+"책 "+ totalPay+"원)\n");
			data.append("\n");
			data.append("연번,서명,저자,발행자,발행년,책수,단가(원),가격(원),신청자,이용일자,반납일자,협약서점\n");
			for(int i=0; i<bookDreamList.size(); i++) {
				BookDream one = bookDreamList.get(i);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = sdf.parse(one.getA_name());
				String a_name = sdf.format(date);
				String c_name = one.getC_name() == null ? "" : one.getC_name();
				
				data.append(i+1).append(",");
				data.append("\"").append(one.getR_title()).append("\",");
				data.append("\"").append(one.getR_author()).append("\","); 
				data.append("\"").append(one.getR_publisher()).append("\",");
				data.append("\"").append(one.getR_pubdate()).append("\",");
				data.append("\"").append(1).append("\",");
				data.append("\"").append(one.getR_price()).append("\",");
				data.append("\"").append(one.getR_price()).append("\",");
				data.append("\"").append(one.getR_name()).append("\",");
				data.append("\"").append(a_name).append("\",");
				data.append("\"").append(c_name).append("\",");
				data.append("\"").append(one.getStoreCode()).append("\"");
				data.append("\n");
			}
			data.append("합계,,,,,").append(bookDreamList.size()).append(",,").append(totalPay).append(",,,,,\n");
			
			HangulEnDecoder.encodeDataOutput(data, "UTF-8", "CP949", response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
