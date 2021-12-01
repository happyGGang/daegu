package kr.go.gbelib.app.cms.module.elib.book;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;
import kr.go.gbelib.app.cms.module.elib.lending.LendingAutoReturnService;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;
import kr.go.gbelib.app.cms.module.elib.member.ElibMemberService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
public class BookController extends BaseController {
	
	private final String basePath = "/cms/module/elib/book/";

	@Autowired
	private BookService service;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	@Autowired
	private ElibCodeService elibCodeService;
	
	@Autowired
	private LendingAutoReturnService lendingAutoReturnServiceNew;
	
	@Autowired
	private ElibMemberService elibMemberService;
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/index.*"})
	public String book_index(Model model, @PathVariable String type, Book book, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		book.setHomepage_id(getAsideHomepageId(request));
		
		book.setType(type);
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		int count = service.getBookListCntCms(book);
		service.setPaging(model, count, book);
		List<Book> bookList = service.getBookListCms(book);
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/edit.*"})
	public String book_edit(Model model, Book book, HttpServletRequest request) throws AuthException {
		book.setHomepage_id(getAsideHomepageId(request));	
		
		if(book.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			book = (Book) service.copyObjectPaging(book, service.getBookInfo(book));
		} else {
			checkAuth("C", model, request);
		}
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Book book, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = book.getEditMode();
		if(!(editMode.equals("DELETE") || editMode.equals("ADDBESTBOOK") || editMode.equals("DELETEBESTBOOK")
				|| editMode.equals("ADDCATBESTBOOK") || editMode.equals("DELETECATBESTBOOK"))) {
			ValidationUtils.rejectIfEmpty(result, "book_code", "책코드를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_name", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author_name", "저자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_pubname", "출판사를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "isbn13", "ISBN을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "format", "포맷을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "book_image", "서적 이미지를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "book_pubdt", "출판일자를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "", "공급사를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "", "도서관을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "max_lend", "최대대출권수를 입력하세요.");
		}
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				if(editMode.equals("ADD")) {
					book.setAdd_id(getSessionMemberId(request));
					service.addBook(book);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
				else if(editMode.equals("MODIFY")) {
					book.setModify_id(getSessionMemberId(request));
					service.modifyBook(book);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				}
				else if(editMode.equals("DELETE")) {
					service.deleteBook(book);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
//			}
//			else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/excelDownload.*"}, method = RequestMethod.POST)
	public BookExcelView excel(Model model, Book book, HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE") || StringUtils.equals(sortField, "book_name")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		model.addAttribute("book", book); 
		model.addAttribute("bookList", service.getBookListAll(book));
		return new BookExcelView();
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Book book, HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE") || StringUtils.equals(sortField, "book_name")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		List<Book> bookList = service.getBookListAll(book);
		
		new BookXlsToCsv(book, bookList, "콘텐츠 목록.csv", request, response);
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/upload_index.*"})
	public String upload_index(Model model, Book book, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		book.setHomepage_id(getAsideHomepageId(request));
		
		if(book.getSortType() == null) book.setSortType("ASC");
		
		book.setApproved_yn("N");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE")) {
			book.setSortField("book_name");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		int count = service.getBookListCntUpload(book);
		service.setPaging(model, count, book);
		List<Book> bookList = service.getBookListUpload(book);
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "upload_index";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/result.*"})
	public String result(Model model, Book book, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		checkAuth("C", model, request);
		
		Map<String, Object> result = upload(model, request, response);
		
		if(result.get("marcUrlList") == null) {
			model.addAttribute("logs", result.get("logs"));
			return basePath + "result";
		} else {
			model.addAttribute("marcUrlList", result.get("marcUrlList"));
			model.addAttribute("marcUrlsCount", result.get("marcUrlsCount"));
			
			String fileName = "마크URL_" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + ".xls";
			
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Pragma", "no-cache");
			response.setContentType(AttachmentUtils.getContentType("xls"));
			
			return basePath + "xls_ajax";
		}
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
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormat.forPattern("yyyy-MM-dd");
	
	public Map<String, Object> upload(Model model, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
//		book.setHomepage_id(getAsideHomepageId(request));
		
//		Map<String, Integer> parentIdMap = new HashMap<String, Integer>();
//		Map<String, Integer> cateIdMap = new HashMap<String, Integer>();
		
		MultipartFile mfile = request.getFileMap().get("mfile");
		String operation = StringUtils.trimToEmpty(request.getParameter("operation"));
		String type = StringUtils.trimToEmpty(request.getParameter("type"));
		String com_code = StringUtils.trimToEmpty(request.getParameter("com_code"));
		String library_code = StringUtils.trimToEmpty(request.getParameter("library_code"));
		String new_category = StringUtils.trimToEmpty(request.getParameter("new_category"));
		String category_prefix = StringUtils.defaultString(request.getParameter("category_prefix"));
		String run_mode = StringUtils.defaultString(request.getParameter("run_mode"));
		List<Book> bookList = new ArrayList<Book>();
		List<String> newParentCategories = new ArrayList<String>();
		List<String> newChildCategories = new ArrayList<String>();
		Set<String> currParentCategories = new HashSet<String>();
		Set<String> currChildCategories = new HashSet<String>();
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, ElibCategory> foundParentCategories = new HashMap<String, ElibCategory>();
		Map<String, ElibCategory> foundChildCategories = new HashMap<String, ElibCategory>();
		result.put("insertCount", "0");
		result.put("updateCount", "0");
		result.put("deleteCount", "0");
		result.put("approveCount", "0");
		result.put("disapproveCount", "0");
		result.put("notExistCount", "0");
		result.put("insertIds", "없음");
		result.put("updateIds", "없음");
		result.put("deleteIds", "없음");
		result.put("approveIds", "없음");
		result.put("disapproveIds", "없음");
		result.put("notExistIds", "없음");
		int rowNum = 0;
		
//		PrintWriter out = response.getWriter();
//		StringBuilder out = new StringBuilder(); 
		List<String> out = new ArrayList<String>();
		
		response.setContentType("text/plain; charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");

		if(mfile == null) {
			out.add("파일을 선택해주세요.");
			result.put("logs", out);
			return result;
		}
		
		DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		out.add(dtf.print(new DateTime()) + " 시작");
		out.add("작업자: " + getSessionMemberId(request));
		out.add("파일명: " + mfile.getOriginalFilename());
		if("I".equals(operation)) {
			out.add("작업 종류: Insert / Update");
		} else if("D".equals(operation)) {
			out.add("작업 종류: Delete");
		} else if("A".equals(operation)) {
			out.add("작업 종류: 승인");
		} else if("DA".equals(operation)) {
			out.add("작업 종류: 승인취소");
		} else if("M".equals(operation)) {
			out.add("작업 종류: 마크URL 추출");
		}
//		out.add("type: " + type);
//		out.add("com_code: " + com_code);
//		out.add("library_code: " + library_code);
		out.add("새 카테고리: " + ("1".equals(new_category) ? "추가하지 않음": "새로 추가"));
		
		try {
			
			//Get the workbook instance for XLS file 
			XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
			//Get first sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rowStart = 1;
			int rowEnd = sheet.getLastRowNum();
			for (rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
				Row row = sheet.getRow(rowNum);
				if (row == null) {
					out.add("" + rowNum + "번째 줄은 비어서 패스");
					continue;
				}
				
				Book book = new Book();
				book.setApproved_yn("N");
				
				type = getStringCellValue(row, 1);
				com_code = getStringCellValue(row, 2);
				library_code = getStringCellValue(row, 3);
				String book_code = getStringCellValue(row, 4);
				
				if(StringUtils.trimToNull(book_code) == null) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료");
					break;
				}
				
				book.setBook_code(book_code);
				book.setType(type);
				book.setLibrary_code(library_code);
				book.setCom_code(com_code);

				if("I".equals(operation)) {
					String parent = category_prefix + getStringCellValue(row, 5);
					
					ElibCategory cate = new ElibCategory();
					cate.setCate_name(parent);
					cate.setType(type);
					cate.setDepth(1);
					
					ElibCategory parentCategory = null;
					String key = cate.getCate_name()+"|"+cate.getType()+"|"+cate.getDepth();
					if(foundParentCategories.containsKey(key)) {
						parentCategory = foundParentCategories.get(key);
					} else {
						parentCategory = elibCategoryService.getParentByName(cate);
						if(parentCategory != null) foundParentCategories.put(key, parentCategory);
					}
					
					if(parentCategory == null) {
						out.add("" + rowNum + "번째 줄에서 새 1차 카테고리 발견: " + parent);
						if("1".equals(new_category)) {
							out.add("중단");
							throw new RuntimeException("중단");
						} else {
							elibCategoryService.addCategory(cate);
							book.setParent_id(cate.getCate_id());
							cate.setParent_id(cate.getCate_id());
							newParentCategories.add(String.valueOf(cate.getCate_id()));
							out.add("1차 카테고리 새로 추가: " + parent + "(" + cate.getCate_id() + ")");
						}
					} else {
						book.setParent_id(parentCategory.getCate_id());
						cate.setParent_id(parentCategory.getCate_id());
						currParentCategories.add(String.valueOf(parentCategory.getCate_id()));
					}
					
//					if("ADO".equals(type)) {
//						book.setCate_id(cate.getCate_id());
//					} else {
						String child = getStringCellValue(row, 6);
						cate.setParent_id(parentCategory.getCate_id());
						cate.setCate_name(child);
						cate.setType(type);
						cate.setDepth(2);
						ElibCategory childCategory = null;
						
						key = cate.getCate_name()+"|"+cate.getType()+"|"+cate.getDepth();
						if(foundChildCategories.containsKey(key)) {
							childCategory = foundChildCategories.get(key);
						} else {
							childCategory = elibCategoryService.getChildByName(cate);
							if(childCategory != null) foundChildCategories.put(key, childCategory);
						}
							
							if(childCategory == null) {
								out.add("" + rowNum + "번째 줄에서 새 2차 카테고리 발견: " + child);
								if("1".equals(new_category)) {
									out.add("중단");
									throw new RuntimeException("중단");
								} else {
									elibCategoryService.addCategory(cate);
									book.setCate_id(cate.getCate_id());
									newChildCategories.add(String.valueOf(cate.getCate_id()));
									out.add("2차 카테고리 새로 추가: " + child + "(" + cate.getCate_id() + ")");
								}
							} else {
								book.setCate_id(childCategory.getCate_id());
								currChildCategories.add(String.valueOf(childCategory.getCate_id()));
							}
//					}
					
	//				book.setParent_id(parentIdMap.get(parent));
	//				book.setCate_id(cateIdMap.get(child));
					
					book.setBook_name(StringUtils.defaultIfEmpty(getStringCellValue(row, 7), "제목 없음"));
					book.setAuthor_name(StringUtils.defaultIfEmpty(getStringCellValue(row, 8), "저자 없음"));
					book.setBook_pubname(StringUtils.defaultIfEmpty(getStringCellValue(row, 9), "출판사 없음"));
					book.setIsbn13(getStringCellValue(row, 10));
					
					String book_pubdt = getStringCellValue(row, 11);
					try {
						FORMATTER.parseDateTime(book_pubdt);
					} catch(Exception e) {
						throw new RuntimeException("날짜 형식(yyyy-MM-dd)에 맞지 않습니다.");
					}
					book.setBook_pubdt(book_pubdt);
					
					book.setFormat(getStringCellValue(row, 13).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setBook_image(getStringCellValue(row, 15));
					
					book.setBook_info(getStringCellValue(row, 16));
					book.setAuthor_info(getStringCellValue(row, 17));
					book.setBook_table(getStringCellValue(row, 18));
					book.setMax_lend(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 14)) ? getStringCellValue(row, 14) : "0"));
					
					book.setAudio_no(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 20)) ? getStringCellValue(row, 20) : "0"));
//					book.setPlay_time(getStringCellValue(row, 20));
					book.setAudio_name(getStringCellValue(row, 21));
					book.setLink_url(getStringCellValue(row, 22));
					book.setMobile_link_url(getStringCellValue(row, 23));
					
					book.setLesson_no(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 25)) ? getStringCellValue(row, 25) : "0"));
					book.setLesson_name(getStringCellValue(row, 26));
					book.setLesson_url(getStringCellValue(row, 27));
					book.setMobile_url(getStringCellValue(row, 28));
				}
				
				bookList.add(book);
			}
			
//			file.close();
		} catch(POIXMLException e) {
			e.printStackTrace();
			out.add(".xlsx 형식의 파일을 업로드 해주세요. (.xls 이용 불가)");
			result.put("logs", out);
			return result;
		} catch(NumberFormatException e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 숫자 형식에 맞지 않는 입력 발견: " + e.getMessage());
			result.put("logs", out);
			return result;
		} catch(Exception e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 오류: " + e.getMessage());
			result.put("logs", out);
			return result;
		}
		
		try {
			if("I".equals(operation)) {
				result.putAll(service.batchInsertBookList(bookList, out, run_mode));
			} else if("D".equals(operation)) {
				result.putAll(service.batchDeleteBookList(bookList, out, run_mode));
			} else if("A".equals(operation)) {
				result.putAll(service.batchApproveBookList(bookList, out, run_mode));
			} else if("DA".equals(operation)) {
				result.putAll(service.batchDisapproveBookList(bookList, out, run_mode));
			} else if("M".equals(operation)) {
				result.putAll(service.batchGetMarcUrlList(bookList, out, run_mode));
			} else {
				throw new IllegalArgumentException("작업 종류를 잘못 선택하셨습니다: " + operation);
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.add(e.getMessage());
			result.put("logs", out);
			return result;
		}
		
		if("I".equals(operation)) {
			out.add("새로운 부모 카테고리 ID: " + (newParentCategories.size() == 0 ? "없음": StringUtils.join(newParentCategories, ", ")));
			out.add("새로운 자식 카테고리 ID: " + (newChildCategories.size() == 0 ? "없음": StringUtils.join(newChildCategories, ", ")));
			out.add("기존 부모 카테고리 ID: " + (currParentCategories.size() == 0 ? "없음": StringUtils.join(currParentCategories, ", ")));
			out.add("기존 자식 카테고리 ID: " + (currChildCategories.size() == 0 ? "없음": StringUtils.join(currChildCategories, ", ")));
		}
		out.add("삽입 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("insertIds")), "없음"));
		out.add("수정 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("updateIds")), "없음"));
		out.add("삭제 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("deleteIds")), "없음"));
		out.add("승인 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("approveIds")), "없음"));
		out.add("승인 취소 ID: " + StringUtils.defaultIfEmpty(String.valueOf(result.get("disapproveIds")), "없음"));
//		out.add("자료없음 ID: " + result.get("notExistIds"));
		out.add(String.format("횟수: 삽입: %s | 수정: %s | 삭제: %s | 승인: %s | 승인 취소: %s | 자료없음: %s", result.get("insertCount"), result.get("updateCount"), result.get("deleteCount"), result.get("approveCount"), result.get("disapproveCount"), result.get("notExistCount")));
		out.add(dtf.print(new DateTime()) + " 종료");
		
		result.put("logs", out);
		return result;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/approve.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse approve(Model model, Book book, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		service.approveBook(book);
		res.setValid(true);
		res.setMessage("승인되었습니다.");
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/approve_all.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse approveAll(Model model, Book book, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		service.approveBookAll(book);
		res.setValid(true);
		res.setMessage("전체 승인되었습니다.");
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/auto_return.*"})
	public void autoReturn(Model model, HttpServletRequest request, HttpServletResponse response) {
		lendingAutoReturnServiceNew.autoReturn();
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/auto_update_lendable_dt.*"})
	public void autoUpdateLendableDt(Model model, HttpServletRequest request, HttpServletResponse response) {
		lendingAutoReturnServiceNew.autoUpdateLendableDt();
	}
	
	private Map<String, String> getMember(ElibMember elibMember) {
		Member member = new Member();
		member.setUser_id(elibMember.getSeq_no());
//		member.setCheck_certify_type("WEBID");
//		member.setCheck_certify_data(elibMember.getMember_id());
		Map<String, String> data = MemberAPI.getMember("WEB", member);
		return data;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/fill_in_members.*"})
	public void fillInMembers(Model model, HttpServletRequest request, HttpServletResponse response) {
		List<ElibMember> list = elibMemberService.getMemberList();
		
		if(list != null) {
			for(ElibMember member: list) {
				if(StringUtils.isEmpty(member.getSex())) {
					Map<String, String> data = getMember(member);
					if(data == null) continue;
					
//					System.out.println("@@@@@@@@@@ fillInMembers member.getMember_id(): " + member.getMember_id());
//					System.out.println("@@@@@@@@@@ fillInMembers data.get(\"SEX\"): " + data.get("SEX"));
//					System.out.println("@@@@@@@@@@ fillInMembers data.get(\"BIRTHD\"): " + data.get("BIRTHD"));
					member.setSex(data.get("SEX"));
					member.setBirth_day(data.get("BIRTHD"));
					
					elibMemberService.modifyMember(member);
				}
			}
		}
		
	}
	
}
