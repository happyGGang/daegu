package kr.go.gbelib.app.cms.module.bookDelivery;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.POIXMLException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/bookDelivery"})
public class BookDeliveryController extends BaseController {
	
	private final String basePath = "/cms/module/bookDelivery/";

	@Autowired
	private BookDeliveryService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		service.setPaging(model, service.getBookDeliveryCount(bookDelivery), bookDelivery);
		
		model.addAttribute("bookDelivery", bookDelivery);
		model.addAttribute("bookDeliveryList", service.getBookDeliveryList(bookDelivery));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		bookDelivery.setEditMode("ADD");
		
		model.addAttribute("bookDelivery", bookDelivery);

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		bookDelivery.setEditMode("MODIFY");
		
		bookDelivery = service.getBookDeliveryListDetail(bookDelivery);
		
		String[] loanDate = bookDelivery.getLoan_date().split("~");
		bookDelivery.setLoan_date1(loanDate[0]);
		bookDelivery.setLoan_date2(loanDate[1]);
		
		model.addAttribute("bookDelivery", bookDelivery);

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookDelivery bookDelivery, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		bookDelivery.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookDelivery.getEditMode().equals("ADD")) {
				bookDelivery.setLoan_date(bookDelivery.getLoan_date1()+"~"+bookDelivery.getLoan_date2());
				service.addBookDelivery(bookDelivery);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (bookDelivery.getEditMode().equals("MODIFY")) {
				bookDelivery.setLoan_date(bookDelivery.getLoan_date1()+"~"+bookDelivery.getLoan_date2());
				service.modifyBookDelivery(bookDelivery);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (bookDelivery.getEditMode().equals("DELETE")) {
				service.deleteBookDelivery(bookDelivery);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(bookDelivery.getEditMode().equals("DELETE_CHECK")) {
				service.deleteCheckBookDelivery(bookDelivery);
				res.setValid(true);
				res.setMessage("선택 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookDeliveryExcelView excelDownload(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		bookDelivery.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookDelivery", bookDelivery);
		model.addAttribute("bookDeliveryExcelList", service.getBookDeliveryExcelList(bookDelivery));
		
		return new BookDeliveryExcelView();
	}
	
	@RequestMapping (value = {"/sampleDownload.*"}, method = RequestMethod.POST)
	public BookDeliveryView sampleDownload(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		return new BookDeliveryView();
	}
	
	@RequestMapping (value = {"/excelUploadEdit.*"})
	public String excelUploadEdit(Model model, BookDelivery bookDelivery, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		return basePath + "excelUpload_ajax";
	}
	
	@RequestMapping (value = {"/excelUpload.*"}, method = RequestMethod.POST)
	public String excelUpload(Model model, BookDelivery bookDelivery, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		checkAuth("R", model, request);

		Map<String, Object> uploadResult = excelUpload(model, request, response);
		
		model.addAttribute("logs", uploadResult.get("logs"));
		
		return basePath + "result";
	}
	
	public Map<String, Object> excelUpload(Model model, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		MultipartFile mfile = request.getFileMap().get("mfile");
		List<BookDelivery> bookDeliveryList = new ArrayList<BookDelivery>();
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("insertCount", "0");
		result.put("notExistIds", "없음");
		int rowNum = 0;
		
		List<String> out = new ArrayList<String>();
		
		response.setContentType("text/plain; charset=UTF-8");

		if(mfile == null) {
			out.add("파일을 선택해주세요.");
			result.put("logs", out);
			return result;
		}
		
		DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		out.add(dtf.print(new DateTime()) + " 시작");
		out.add("파일명: " + mfile.getOriginalFilename());
		
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rowStart = 1;
			int rowEnd = sheet.getLastRowNum();
			for (rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
				Row row = sheet.getRow(rowNum);
				if (row == null) {
					out.add("" + rowNum + "번째 줄은 비어서 패스");
					continue;
				}
				
				BookDelivery bookDelivery = new BookDelivery();
				
				String request_date = getStringCellValue(row, 0);
				String subject = getStringCellValue(row, 1);
				String book_package_name = getStringCellValue(row, 2);
				String loan_date = getStringCellValue(row, 3);
				String school_name = getStringCellValue(row, 4);
				String member_name = getStringCellValue(row, 5);
				String phone = getStringCellValue(row, 6);
				String address = getStringCellValue(row, 7);
				String return_plan_place = getStringCellValue(row, 8);
				String school_phone = getStringCellValue(row, 9);
				String book_count = getStringCellValue(row, 10);
				String return_plan_date = getStringCellValue(row, 11);
				String status = getStringCellValue(row, 12);
				
				if(StringUtils.trimToNull(request_date) == null) {
					out.add("" + rowNum + 1 + "번째 줄에서 데이터 읽기 종료.");
					break;
				} else {
					bookDelivery.setHomepage_id(getAsideHomepageId(request));
					bookDelivery.setRequest_date(request_date);
					bookDelivery.setSubject(subject);
					bookDelivery.setBook_package_name(book_package_name);
					bookDelivery.setLoan_date(loan_date);
					bookDelivery.setSchool_name(school_name);
					bookDelivery.setMember_name(member_name);
					bookDelivery.setPhone(phone);
					bookDelivery.setAddress(address);
					bookDelivery.setReturn_plan_place(return_plan_place);
					bookDelivery.setSchool_phone(school_phone);
					bookDelivery.setBook_count(Integer.parseInt(book_count));
					bookDelivery.setReturn_plan_date(return_plan_date);
					bookDelivery.setStatus(status);
				}

				bookDeliveryList.add(bookDelivery);
			}
			
		} catch(POIXMLException e) {
			e.printStackTrace();
			out.add(".xlsx 형식의 파일을 업로드 해주세요. (.xls 이용 불가)");
			result.put("logs", out);
			return result;
		} catch(NumberFormatException e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 형식에 맞지 않는 입력 발견: " + e.getMessage());
			result.put("logs", out);
			return result;
		} catch(Exception e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 오류: " + e.getMessage());
			result.put("logs", out);
			return result;
		}
		
		try {
			Member member = getSessionMemberInfo(request);
			
			result.putAll(service.insertBookDeliveryList(bookDeliveryList, out, member));
		} catch (Exception e) {
			e.printStackTrace();
			out.add(e.getMessage());
			result.put("logs", out);
			
			return result;
		}
		
		out.add(String.format("횟수: 삽입: %s | 자료없음: %s", result.get("insertCount"), result.get("notExistCount")));
		
		result.put("logs", out);
		
		return result;
	}
		
	private String getStringCellValue(Row row, int col) {
		Cell cell = row.getCell(col, Row.RETURN_BLANK_AS_NULL);
		DataFormatter formatter = new DataFormatter();
		SimpleDateFormat DtFormat = new SimpleDateFormat("yyyy-MM-dd");

        if(cell == null) {
        	return "";
        } else if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {
	            switch(cell.getCachedFormulaResultType()) {
	            case HSSFCell.CELL_TYPE_NUMERIC:
	            	if(HSSFDateUtil.isCellDateFormatted(cell)) {
	            		Date date = cell.getDateCellValue();
	            		return StringUtils.trimToEmpty(DtFormat.format(date).toString());
	            	} else {
	            		return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
	            	}
	            case HSSFCell.CELL_TYPE_STRING:
	            	return StringUtils.trimToEmpty(cell.getRichStringCellValue().getString());
	            default:
	            	return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
	        }
        } else if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC && HSSFDateUtil.isCellDateFormatted(cell)) {
            	Date date = cell.getDateCellValue();
            	return StringUtils.trimToEmpty(DtFormat.format(date).toString());
        } else {
        	return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
        }
	}
}