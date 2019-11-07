package kr.go.gbelib.app.cms.module.elib.book;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.comment.Comment;
import kr.go.gbelib.app.cms.module.elib.comment.CommentDao;
import kr.go.gbelib.app.cms.module.elib.config.Config;
import kr.go.gbelib.app.cms.module.elib.config.ConfigDao;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingDao;

@Service
public class BookService extends BaseService {

	@Autowired
	private BookDao dao;
	
	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private ConfigDao configDao;
	
	@Autowired
	private LendingDao lendingDao;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	private String addDays(String date, int days) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.setTime(sdf.parse(date));
			cal.add(Calendar.DATE, days);
			return sdf.format(cal.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
			return date;
		}
	}
	
	private String addDays(Date date, int days) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, days);
		return sdf.format(cal.getTime());
	}
	
	private String getDate(Lending lending) {
		return lending.getLend_idx() > 0 ? lending.getReturn_due_dt() : lending.getLendable_dt();
	}
	
	private void fill(Book book, int lend_max_term) {
		Lending lending = new Lending(book);
		List<Lending> reserveList = lendingDao.getBookReserveList(lending);
		List<Lending> lendList = lendingDao.getNotReturnedList(lending);

		List<Lending> lendReserveList = new ArrayList<Lending>(); 
		lendReserveList.addAll(reserveList);
		lendReserveList.addAll(lendList);
		
		Lending earliest = null;
		Set<Lending> removed = new HashSet<Lending>();
		
		while(true) {
			
			if(lendReserveList.size() == 0) {
				book.setLendable_dt(addDays(new Date(), 0));
				return;
			}
			
			Collections.sort(lendReserveList, new Comparator<Lending>() {
				@Override
				public int compare(Lending o1, Lending o2) {
					String date1 = getDate(o1);
					String date2 = getDate(o2);
					
					if(date1 == null) {
						return 1;
					} else if(date2 == null) {
						return -1;
					} else {
						return date1.compareTo(date2);
					}
				}
			});
			
			earliest = lendReserveList.get(0);
			
			if(getDate(earliest) == null) {
				lendReserveList.remove(0);
				continue;
			}
			
			boolean duplicateFound = false;
			String earliestDate = addDays(getDate(earliest), lend_max_term);
			
			for(int i=1; i<lendReserveList.size(); ++i) {
				Lending lendReserve = lendReserveList.get(i);
				String date = getDate(lendReserve);
				
				if(date == null) {
					lendReserveList.remove(i);
					break;
				} else if(lendReserve.getReserve_idx() > 0 && date.equals(earliestDate) && !removed.contains(lendReserve)) {
					lendReserveList.remove(0);
					removed.add(lendReserve);
					duplicateFound = true;
					break;
				}
			}
			
			if(!duplicateFound) break;
		}
		
		earliest = lendReserveList.get(0);
		book.setLendable_dt(addDays(getDate(earliest), lend_max_term));
	}
	
	private List<Book> fillInLendable_dt(List<Book> list) {
		if(list != null) {
			Config config = configDao.getConfig();
			int lend_max_term = config.getLend_max_term();
			
			for(Book book: list) {
				fill(book, lend_max_term);
			}
		}
		
		return list;
	}
	
	private Book fillInLendable_dt(Book book) {
		Config config = configDao.getConfig();
		int lend_max_term = config.getLend_max_term();
		
		fill(book, lend_max_term);
		
		return book;
	}
	
	public int getBookListCnt(Book book) {
		return dao.getBookListCnt(book);
	}
	
	public List<Book> getBookList(Book book) {
		return fillInLendable_dt(dao.getBookList(book));
	}
	
	public int getBookListCntCms(Book book) {
		return dao.getBookListCntCms(book);
	}
	
	public List<Book> getBookListCms(Book book) {
		return dao.getBookListCms(book);
	}
	
	public int getBookListCntUpload(Book book) {
		return dao.getBookListCntUpload(book);
	}
	
	public List<Book> getBookListUpload(Book book) {
		return dao.getBookListUpload(book);
	}
	
	public List<Book> getBookListAll(Book book) {
		return dao.getBookListAll(book);
	}
	
	public List<Book> getCompList(Book book) {
		return dao.getCompList(book);
	}
	
	public Book getBookInfo(Book book) {
		return fillInLendable_dt(dao.getBookInfo(book));
	}

	@Transactional
	public int addBook(Book book) {
		
		if(dao.codeDupCheck(book) > 0) {
			return 0;
		}
		
		if(dao.addBook(book) == 0) {
			throw new RuntimeException();
		}
		
		int result = 0;
		
		if((result = dao.addBookInfo(book)) == 0) {
			throw new RuntimeException();
		}
		
		if("ADO".equals(book.getType())) {
			if((result = dao.addAudiobook(book)) == 0) {
				throw new RuntimeException();
			}
		}
		
		return result;
	}
	
	public int addBookInfo(Book book) {
		return dao.addBookInfo(book);
	}

	@Transactional
	public int modifyBook(Book book) {
		
		if(dao.modifyBookInfo(book) == 0) {
			throw new RuntimeException();
		}
		
		if("ADO".equals(book.getType())) {
			if(dao.modifyAudiobook(book) == 0) {
				throw new RuntimeException();
			}
		}
		
		return dao.modifyBook(book);
	}

	public int dupCnt(Book book) {
		return dao.dupCnt(book);
	}
	
	@Transactional
	public int deleteBook(Book book) {
		
		// TODO: 대출, 예약 삭제 루틴 추가
		
		dao.deleteBookInfo(book);
		dao.deleteAudiobook(book);
		dao.deleteRecommendLog(book);
		commentDao.deleteCommentsByBook(new Comment(book));
		
		return dao.deleteBook(book);
	}
	
	@Transactional
	public int recommendBook(Book book) {
		
		if(dao.recommendDupCheck(book) > 0) return -1;
		
		dao.recommendBook(book);
		
		return dao.addRecommendLog(book);
	}
	
	public List<Book> getBookSearchedList(Book book) {
		return fillInLendable_dt(dao.getBookSearchedList(book));
	}
	
	public int getBookSearchedListCnt(Book book) {
		return dao.getBookSearchedListCnt(book);
	}
	
	public List<Book> getBookCountByType(Book book) {
		return dao.getBookCountByType(book);
	}
	
	public List<Book> getBookCountByAuthor(Book book) {
		return dao.getBookCountByAuthor(book);
	}
	
	public List<Book> getBookCountByPublisher(Book book) {
		return dao.getBookCountByPublisher(book);
	}
	
	public List<Book> getBookCountByYear(Book book) {
		return dao.getBookCountByYear(book);
	}
	
	public int getBookCountByTypeCnt(Book book) {
		return dao.getBookCountByTypeCnt(book);
	}
	
	public int getBookCountByAuthorCnt(Book book) {
		return dao.getBookCountByAuthorCnt(book);
	}
	
	public int getBookCountByPublisherCnt(Book book) {
		return dao.getBookCountByPublisherCnt(book);
	}
	
	public int getBookCountByYearCnt(Book book) {
		return dao.getBookCountByYearCnt(book);
	}
	
	public int getBookCountByDeviceCnt(Book book) {
		return dao.getBookCountByDeviceCnt(book);
	}
	
	public List<Book> getBookCountByDevice(Book book) {
		return dao.getBookCountByDevice(book);
	}
	
	public List<Book> getCourseList(Book book) {
		return dao.getCourseList(book);
	}
	
	public List<Book> getAudioList(Book book) {
		return dao.getAudioList(book);
	}
	
	@Transactional
	public int addElearning(Book book) {

		if(dao.codeDupCheck(book) > 0) {
			book.setBook_idx(dao.getBookIdx(book));
			return dao.addElearning(book);
		}
		
		if(dao.addBook(book) == 0) {
			throw new RuntimeException();
		}
		
		int result = 0;
		
		if((result = dao.addBookInfo(book)) == 0) {
			throw new RuntimeException();
		}
		
		if((result = dao.addElearning(book)) == 0) {
			throw new RuntimeException();
		}
		
		return result;
	}
	
	public int addElearning2(Book book) {
		
		if(dao.codeDupCheck(book) > 0) {
			book.setBook_idx(dao.getBookIdx(book));
			return dao.addElearning(book);
		}
		
		if(dao.addBook(book) == 0) {
			throw new RuntimeException();
		}
		
		int result = 0;
		
		if((result = dao.addBookInfo(book)) == 0) {
			throw new RuntimeException();
		}
		
		if((result = dao.addElearning(book)) == 0) {
			throw new RuntimeException();
		}
		
		return result;
	}
	
	public int getBookIdx(Book book) {
		Object result = dao.getBookIdx(book);
		
		if(result == null) {
			return 0;
		} else {
			return (Integer) result;
		}
	}
	
	private String getStringCellValue(Row row, int col) {
		Cell cell = row.getCell(col, Row.RETURN_BLANK_AS_NULL);
		DataFormatter formatter = new DataFormatter();

        if(cell == null) {
        	return "";
        } else if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA) {
	            switch(cell.getCachedFormulaResultType()) {
	            case HSSFCell.CELL_TYPE_NUMERIC:
	            	if(HSSFDateUtil.isCellDateFormatted(cell)) {
	            		SimpleDateFormat DtFormat = new SimpleDateFormat("yyyy-MM-dd");
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
            	SimpleDateFormat DtFormat = new SimpleDateFormat("yyyy-MM-dd");
            	Date date = cell.getDateCellValue();
            	return StringUtils.trimToEmpty(DtFormat.format(date).toString());
        } else {
        	return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
        }
	}
	
	private static final DateTimeFormatter FORMATTER = DateTimeFormat.forPattern("yyyy-MM-dd");

	@RequestMapping(value = {"/cms/module/elib/book/upload.*"})
	public List<String> upload(Model model, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
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
		Map<String, String> result = new HashMap<String, String>();
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
			return out;
		}
		
		DateTimeFormatter dtf = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		out.add(dtf.print(new DateTime()) + " 시작");
		out.add("파일명: " + mfile.getOriginalFilename());
		if("I".equals(operation)) {
			out.add("작업 종류: Insert / Update");
		} else if("D".equals(operation)) {
			out.add("작업 종류: Delete");
		} else if("A".equals(operation)) {
			out.add("작업 종류: 승인");
		} else if("DA".equals(operation)) {
			out.add("작업 종류: 승인취소");
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
				
				String book_code = getStringCellValue(row, 1);
				type = getStringCellValue(row, 10);
				library_code = getStringCellValue(row, 13);
				com_code = getStringCellValue(row, 18);
				
				if(StringUtils.trimToNull(book_code) == null) {
					out.add("" + rowNum + "번째 줄에서 데이터 읽기 종료");
					break;
				}
				
				book.setBook_code(book_code);
				book.setType(type);
				book.setLibrary_code(library_code);
				book.setCom_code(com_code);

				if("I".equals(operation)) {
					String parent = category_prefix + getStringCellValue(row, 2);
					
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
					
					if("ADO".equals(type)) {
						book.setCate_id(cate.getCate_id());
					} else {
						String child = getStringCellValue(row, 3);
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
					}
					
	//				book.setParent_id(parentIdMap.get(parent));
	//				book.setCate_id(cateIdMap.get(child));
					
					book.setBook_name(StringUtils.defaultIfEmpty(getStringCellValue(row, 4), "제목 없음"));
					book.setAuthor_name(StringUtils.defaultIfEmpty(getStringCellValue(row, 5), "저자 없음"));
					book.setBook_pubname(StringUtils.defaultIfEmpty(getStringCellValue(row, 6), "출판사 없음"));
					book.setIsbn13(getStringCellValue(row, 7));
					
					String book_pubdt = getStringCellValue(row, 8);
					try {
						FORMATTER.parseDateTime(book_pubdt);
					} catch(Exception e) {
						throw new RuntimeException("날짜 형식(yyyy-MM-dd)에 맞지 않습니다.");
					}
					book.setBook_pubdt(book_pubdt);
					
					book.setFormat(getStringCellValue(row, 11).toUpperCase());
					book.setDevice("3");
					book.setUse_yn("Y");
					book.setBook_image(getStringCellValue(row, 12));
					
					book.setBook_info(getStringCellValue(row, 14));
					book.setAuthor_info(getStringCellValue(row, 15));
					book.setBook_table(getStringCellValue(row, 16));
					book.setMax_lend(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 17)) ? getStringCellValue(row, 17) : "0"));
					
					book.setAudio_no(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 19)) ? getStringCellValue(row, 19) : "0"));
					book.setPlay_time(getStringCellValue(row, 20));
					book.setAudio_name(getStringCellValue(row, 22));
					book.setLink_url(getStringCellValue(row, 23));
					book.setMobile_link_url(getStringCellValue(row, 24));
					
					book.setLesson_no(Integer.parseInt(StringUtils.isNotEmpty(getStringCellValue(row, 26)) ? getStringCellValue(row, 26) : "0"));
					book.setLesson_name(getStringCellValue(row, 27));
					book.setLesson_url(getStringCellValue(row, 28));
					book.setMobile_url(getStringCellValue(row, 29));
				}
				
				bookList.add(book);
			}
			
//			file.close();
		} catch(POIXMLException e) {
			e.printStackTrace();
			out.add(".xlsx 형식의 파일을 업로드 해주세요. (.xls 이용 불가)");
			return out;
		} catch(NumberFormatException e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 숫자 형식에 맞지 않는 입력 발견: " + e.getMessage());
			return out;
		} catch(Exception e) {
			e.printStackTrace();
			out.add("" + rowNum + "번째 줄에서 오류: " + e.getMessage());
			return out;
		}
		
		try {
			if("I".equals(operation)) {
				result.putAll(batchInsertBookList(bookList, out, run_mode));
			} else if("D".equals(operation)) {
				result.putAll(batchDeleteBookList(bookList, out, run_mode));
			} else if("A".equals(operation)) {
				result.putAll(batchApproveBookList(bookList, out, run_mode));
			} else if("DA".equals(operation)) {
				result.putAll(batchDisapproveBookList(bookList, out, run_mode));
			} else {
				throw new IllegalArgumentException("작업 종류를 잘못 선택하셨습니다: " + operation);
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.add(e.getMessage());
			return out;
		}
		
		if("I".equals(operation)) {
			out.add("새로운 부모 카테고리 ID: " + (newParentCategories.size() == 0 ? "없음": StringUtils.join(newParentCategories, ", ")));
			out.add("새로운 자식 카테고리 ID: " + (newChildCategories.size() == 0 ? "없음": StringUtils.join(newChildCategories, ", ")));
			out.add("기존 부모 카테고리 ID: " + (currParentCategories.size() == 0 ? "없음": StringUtils.join(currParentCategories, ", ")));
			out.add("기존 자식 카테고리 ID: " + (currChildCategories.size() == 0 ? "없음": StringUtils.join(currChildCategories, ", ")));
		}
		out.add("삽입 ID: " + StringUtils.defaultIfEmpty(result.get("insertIds"), "없음"));
		out.add("수정 ID: " + StringUtils.defaultIfEmpty(result.get("updateIds"), "없음"));
		out.add("삭제 ID: " + StringUtils.defaultIfEmpty(result.get("deleteIds"), "없음"));
		out.add("승인 ID: " + StringUtils.defaultIfEmpty(result.get("approveIds"), "없음"));
		out.add("승인 취소 ID: " + StringUtils.defaultIfEmpty(result.get("disapproveIds"), "없음"));
//		out.add("자료없음 ID: " + result.get("notExistIds"));
		out.add(String.format("횟수: 삽입: %s | 수정: %s | 삭제: %s | 승인: %s | 승인 취소: %s | 자료없음: %s", result.get("insertCount"), result.get("updateCount"), result.get("deleteCount"), result.get("approveCount"), result.get("disapproveCount"), result.get("notExistCount")));
		out.add(dtf.print(new DateTime()) + " 종료");
		
		return out;
	}
	
	private String bookString(Book book) {
		return String.format("공급사: %s | 북타입: %s | 북코드: %s | 도서관: %s", book.getCom_code(), book.getType(), book.getBook_code(), book.getLibrary_code());
	}
	
	@Transactional
	public Map<String, String> batchInsertBookList(List<Book> bookList, List<String> out, String run_mode) throws IOException {
		List<Book> insertList = new ArrayList<Book>();
		List<Book> updateList = new ArrayList<Book>();
		List<String> insertIds = new ArrayList<String>();
		List<String> updateIds = new ArrayList<String>();
		int insertCount = 0;
		int updateCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
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
		
		for(Book book: bookList) {
			if(dao.codeDupCheck(book) > 0) {
				if("WEB".equals(book.getType())) {
						book.setBook_idx(dao.getBookIdx(book));
						updateList.add(book);
				}
				else if("ADO".equals(book.getType())) {
					if(dao.audiobookCodeDupCheck(book) > 0) {
						book.setBook_idx(dao.getBookIdx(book));
						updateList.add(book);
					} else {
						insertList.add(book);
					}
				}
				else {
					book.setBook_idx(dao.getBookIdx(book));
					updateList.add(book);
				}
			} else {
				insertList.add(book);
			}
		}
		
		for(Book book: insertList) {
			String type = book.getType();
			
			if(dao.codeDupCheck(book) > 0) {
				book.setBook_idx(dao.getBookIdx(book));
			} else {
				if(dao.addBook(book) == 0) {
					out.add("삽입 실패: " + bookString(book));
					failed = true;
					throw new RuntimeException();
	//				continue;
				}
				
				if(dao.addBookInfo(book) == 0) {
					out.add("삽입 실패: " + bookString(book));
					failed = true;
					throw new RuntimeException();
	//				continue;
				}
			}
			
			if("ADO".equals(type)) {
				if(dao.addAudiobook(book) == 0) {
					out.add("삽입 실패: " + bookString(book));
					failed = true;
					continue;
				}
			}
			
			if("WEB".equals(type)) {
				if(dao.addElearning(book) == 0) {
					out.add("삽입 실패: " + bookString(book));
					failed = true;
					continue;
				}
			}
			
			++insertCount;
			if(book.getBook_idx() > 0) insertIds.add(String.valueOf(book.getBook_idx()));
			out.add("삽입 성공: " + bookString(book));
		}
		
		for(Book book: updateList) {
			if(dao.codeDupCheck(book) > 0) {
				book.setBook_idx(dao.getBookIdx(book));
			}
			
				if(dao.modifyBook(book) == 0) {
					out.add("수정 실패: " + bookString(book));
					failed = true;
					throw new RuntimeException();
	//				continue;
				}
				
				if(dao.modifyBookInfo(book) == 0) {
					out.add("수정 실패: " + bookString(book));
					failed = true;
					throw new RuntimeException();
	//				continue;
				}
			
			if("ADO".equals(book.getType())) {
				book.setAudio_idx(dao.getAudioIdx(book));
				if(dao.modifyAudiobook(book) == 0) {
					out.add("수정 실패: " + bookString(book));
					failed = true;
					continue;
				}
			}
			
			if("WEB".equals(book.getType())) {
				book.setCourse_idx(dao.getCourseIdx(book));
				if(dao.modifyElearning(book) == 0) {
					out.add("수정 실패: " + bookString(book));
					failed = true;
					continue;
				}
			}
			
			++updateCount;
			updateIds.add(String.valueOf(book.getBook_idx()));
			out.add("수정 성공: " + bookString(book));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");

		if(failed) throw new RuntimeException();
		
		result.put("insertCount", String.valueOf(insertCount));
		result.put("updateCount", String.valueOf(updateCount));
		result.put("insertIds", StringUtils.join(insertIds, ", "));
		result.put("updateIds", StringUtils.join(updateIds, ", "));
		
		return result;
	}
	
	@Transactional
	public Map<String, String> batchDeleteBookList(List<Book> bookList, List<String> out, String run_mode) throws IOException {
		List<Book> deleteList = new ArrayList<Book>();
		List<Book> notExistList = new ArrayList<Book>();
		List<String> deleteIds = new ArrayList<String>();
		List<String> notExistIds = new ArrayList<String>();
		int deleteCount = 0;
		int notExistCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
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
		
		for(Book book: bookList) {
			if(dao.codeDupCheck(book) > 0) {
//				if("WEB".equals(book.getType())) {
//					if(dao.elearningCodeDupCheck(book) > 0) {
//						book.setBook_idx(dao.getBookIdx(book));
//						deleteList.add(book);
//					} else {
//						notExistList.add(book);
//					}
//				} else {
					book.setBook_idx(dao.getBookIdx(book));
					deleteList.add(book);
//				}
			} else {
				notExistList.add(book);
			}
		}
		
		for(Book book: deleteList) {
			if(dao.deleteBook(book) == 0) {
//				out.add("삭제 실패: " + bookString(book));
//				failed = true;
//				throw new RuntimeException();
////				continue;
			}
			
			if(dao.deleteBookInfo(book) == 0) {
//				out.add("삭제 실패: " + bookString(book));
//				failed = true;
//				throw new RuntimeException();
////				continue;
			}
			
			if("ADO".equals(book.getType())) {
				if(dao.deleteAudiobook(book) == 0) {
//					out.add("삭제 실패: " + bookString(book));
//					failed = true;
//					continue;
				}
			}
			
			if("WEB".equals(book.getType())) {
				if(dao.deleteElearning(book) == 0) {
//					out.add("삭제 실패: " + bookString(book));
//					failed = true;
//					continue;
				}
			}
			
			++deleteCount;
			deleteIds.add(String.valueOf(book.getBook_idx()));
			out.add("삭제 성공: " + bookString(book));
		}
		
		for(Book book: notExistList) {
			++notExistCount;
			notExistIds.add(String.valueOf(book.getBook_idx()));
			out.add("삭제 자료 없음: " + bookString(book));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");

		if(failed) throw new RuntimeException();
		
		result.put("deleteCount", String.valueOf(deleteCount));
		result.put("notExistCount", String.valueOf(notExistCount));
		result.put("deleteIds", StringUtils.join(deleteIds, ", "));
		result.put("notExistIds", StringUtils.join(notExistIds, ", "));
		
		return result;
	}
	
	@Transactional
	public Map<String, String> batchApproveBookList(List<Book> bookList, List<String> out, String run_mode) throws IOException {
		List<Book> approveList = new ArrayList<Book>();
		List<Book> notExistList = new ArrayList<Book>();
		List<String> approveIds = new ArrayList<String>();
		List<String> notExistIds = new ArrayList<String>();
		int approveCount = 0;
		int notExistCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
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
		
		for(Book book: bookList) {
			if(dao.codeDupCheck(book) > 0) {
//				if("WEB".equals(book.getType())) {
//					if(dao.elearningCodeDupCheck(book) > 0 && book.getLesson_no() > 0) {
//						book.setBook_idx(dao.getBookIdx(book));
////						book.setLesson_no(dao.getLessonNo(book));
//						approveList.add(book);
//					} else {
//						notExistList.add(book);
//					}
//				} else {
					book.setBook_idx(dao.getBookIdx(book));
					approveList.add(book);
//				}
			} else {
				notExistList.add(book);
			}
		}
		
		for(Book book: approveList) {
			if(dao.approveBook(book) == 0) {
				out.add("승인 실패: " + bookString(book));
				failed = true;
				throw new RuntimeException();
//				continue;
			}
			
			++approveCount;
			approveIds.add(String.valueOf(book.getBook_idx()));
			out.add("승인 성공: " + bookString(book));
		}
		
		for(Book book: notExistList) {
			++notExistCount;
			notExistIds.add(String.valueOf(book.getBook_idx()));
			out.add("승인 자료 없음: " + bookString(book));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");
		
		if(failed) throw new RuntimeException();
		
		result.put("approveCount", String.valueOf(approveCount));
		result.put("notExistCount", String.valueOf(notExistCount));
		result.put("approveIds", StringUtils.join(approveIds, ", "));
		result.put("notExistIds", StringUtils.join(notExistIds, ", "));
		
		return result;
	}
	
	@Transactional
	public Map<String, String> batchDisapproveBookList(List<Book> bookList, List<String> out, String run_mode) throws IOException {
		List<Book> disapproveList = new ArrayList<Book>();
		List<Book> notExistList = new ArrayList<Book>();
		List<String> disapproveIds = new ArrayList<String>();
		List<String> notExistIds = new ArrayList<String>();
		int disapproveCount = 0;
		int notExistCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
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
		
		for(Book book: bookList) {
			if(dao.codeDupCheck(book) > 0) {
//				if("WEB".equals(book.getType())) {
//					if(dao.elearningCodeDupCheck(book) > 0 && book.getLesson_no() > 0) {
//						book.setBook_idx(dao.getBookIdx(book));
////						book.setLesson_no(dao.getLessonNo(book));
//						approveList.add(book);
//					} else {
//						notExistList.add(book);
//					}
//				} else {
				book.setBook_idx(dao.getBookIdx(book));
				disapproveList.add(book);
//				}
			} else {
				notExistList.add(book);
			}
		}
		
		for(Book book: disapproveList) {
			if(dao.approveBook(book) == 0) {
				out.add("승인 취소 실패: " + bookString(book));
				failed = true;
				throw new RuntimeException();
//				continue;
			}
			
			++disapproveCount;
			disapproveIds.add(String.valueOf(book.getBook_idx()));
			out.add("승인 취소 성공: " + bookString(book));
		}
		
		for(Book book: notExistList) {
			++notExistCount;
			notExistIds.add(String.valueOf(book.getBook_idx()));
			out.add("승인 취소 자료 없음: " + bookString(book));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");
		
		if(failed) throw new RuntimeException();
		
		result.put("disapproveCount", String.valueOf(disapproveCount));
		result.put("notExistCount", String.valueOf(notExistCount));
		result.put("disapproveIds", StringUtils.join(disapproveIds, ", "));
		result.put("notExistIds", StringUtils.join(notExistIds, ", "));
		
		return result;
	}
	
	public int approveBook(Book book) {
		return dao.approveBook(book);
	}
	
	public int approveBookAll(Book book) {
		return dao.approveBookAll(book);
	}
	
}
