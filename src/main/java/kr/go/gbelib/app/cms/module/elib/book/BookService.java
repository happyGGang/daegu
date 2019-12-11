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

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
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
	
//	@Autowired
//	private ElibCategoryService elibCategoryService;
	
	public int getBookListCnt(Book book) {
		return dao.getBookListCnt(book);
	}
	
	public List<Book> getBookList(Book book) {
		return dao.getBookList(book);
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
		return dao.getBookInfo(book);
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
		return dao.getBookSearchedList(book);
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
	
	private String bookString(Book book) {
//		return String.format("공급사: %s | 북타입: %s | 북코드: %s | 도서관: %s", book.getCom_code(), book.getType(), book.getBook_code(), book.getLibrary_code());
		return String.format("%s,%s,%s,%s,\"%s\"", book.getType(), book.getCom_code(), book.getLibrary_code(), book.getBook_code(), book.getBook_name());
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
	
	@Transactional
	public Map<String, Object> batchGetMarcUrlList(List<Book> bookList, List<String> out, String run_mode) throws IOException {
		List<Book> marcUrlList = new ArrayList<Book>();
		List<Book> notExistList = new ArrayList<Book>();
		List<String> marcUrlIds = new ArrayList<String>();
		List<String> notExistIds = new ArrayList<String>();
		int marcUrlsCount = 0;
		int notExistCount = 0;
		boolean failed = false;
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("insertCount", "0");
		result.put("updateCount", "0");
		result.put("deleteCount", "0");
		result.put("approveCount", "0");
		result.put("disapproveCount", "0");
		result.put("notExistCount", "0");
		result.put("marcUrlsCount", "0");
		result.put("insertIds", "없음");
		result.put("updateIds", "없음");
		result.put("deleteIds", "없음");
		result.put("approveIds", "없음");
		result.put("disapproveIds", "없음");
		result.put("notExistIds", "없음");
		result.put("marcUrlstIds", "없음");
		
		for(Book book: bookList) {
			if(dao.codeDupCheck(book) > 0) {
				book.setBook_idx(dao.getBookIdx(book));
				Book bookinfo = dao.getBookInfo(book);
				marcUrlList.add(bookinfo);
				++marcUrlsCount;
				marcUrlIds.add(String.valueOf(book.getBook_idx()));
				out.add("마크URL 추출 성공: " + bookString(book));
			} else {
				notExistList.add(book);
				out.add("마크URL 추출 실패: " + bookString(book));
				failed = true;
				throw new RuntimeException("마크URL 추출 실패. 자료가 존재하지 않음.");
			}
		}
		
		for(Book book: notExistList) {
			++notExistCount;
			notExistIds.add(String.valueOf(book.getBook_idx()));
			out.add("마크URL 추출 자료 없음: " + bookString(book));
		}
		
//		마크URL 추출 시에는 테스트 모드가 필요 없음
//		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");
		
		if(failed) throw new RuntimeException();
		
		result.put("marcUrlsCount", String.valueOf(marcUrlsCount));
		result.put("notExistCount", String.valueOf(notExistCount));
		result.put("marcUrlIds", StringUtils.join(marcUrlIds, ", "));
		result.put("notExistIds", StringUtils.join(notExistIds, ", "));
		result.put("marcUrlList", marcUrlList);
		
		return result;
	}
	
	public int approveBook(Book book) {
		return dao.approveBook(book);
	}
	
	public int approveBookAll(Book book) {
		return dao.approveBookAll(book);
	}
	
}
