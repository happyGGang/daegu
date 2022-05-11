package kr.co.whalesoft.app.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.boardManage.BoardManageDao;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.googlecode.ehcache.annotations.Cacheable;

import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.board.boardFile.BoardFileDao;
import kr.co.whalesoft.app.board.boardFile.BoardFileService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.boardAccess.BoardAccess;
import kr.co.whalesoft.app.cms.module.boardFileAccess.BoardFileAccess;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.file.FileUtil;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.co.whalesoft.framework.utils.RequestUtils;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Service
public class BoardService extends BaseService {

	@Autowired
	private BoardDao dao;

	@Autowired
	private LoginService loginService;

	@Autowired
	private BoardFileService boardFileService;

	@Autowired
	@Qualifier("boardStorage")
	private FileStorage boardStorage;

	@Autowired
	@Qualifier("boardTempStorage")
	private FileStorage boardTempStorage;

	@Autowired
	private BoardFileDao boardFileDao;

	@Autowired
	private BoardManageService boardManageService;

	public Board copyObjectPaging(BoardManage boardManage, Board originalBoard, Board copyTargetBoard) {
		copyTargetBoard.setPagingUtils(originalBoard);
		copyTargetBoard.setMenu_idx(originalBoard.getMenu_idx());
		copyTargetBoard.setEditMode(originalBoard.getEditMode());

		return copyTargetBoard;
	}

	public String getBoardStoragePath() {
		return boardStorage.getContextPath();
	}

	public List<Board> getBoard(BoardManage boardManage, Board board) {

		board.setRequest_code(boardManage.getRequest_code());
		board.setCategory1Manage(boardManage.getCategory1());
		board.setCategory2Manage(boardManage.getCategory2());
		board.setCategory3Manage(boardManage.getCategory3());
		board.setCategory4Manage(boardManage.getCategory4());
		board.setCategory5Manage(boardManage.getCategory5());

		board.setReply_list_yn(boardManage.getReply_list_yn());

		if(boardManage.getBoard_type().indexOf("CUSTOM") > -1) {
			if(boardManage.getBoard_type().equals("CUSTOM_QNA")) {
				return dao.getCustomQnaBoard(board);
			} else {
				return dao.getCustomBoard(board);
			}
		} else {
			if(boardManage.getBoard_type().equals("QNA")) {
				return dao.getQnABoard(board);
			} else if(boardManage.getBoard_type().equals("BOOK") || boardManage.getBoard_type().equals("THEMEBOOK")
					|| boardManage.getBoard_type().equals("BOOK_PORTAL")) {
				return dao.getBOOKBoard(board);
			} else if(boardManage.getBoard_type().equals("MOVIE")) {
				return dao.getMovieBoard(board);
			} else if(boardManage.getBoard_type().equals("LOSTCARD")) {
				return dao.getLostCardBoard(board);
			} else {
				return dao.getBoard(board);
			}
		}

	}

	public List<Board> getDeleteBoard(BoardManage boardManage, Board board) {

		return dao.getDeleteBoard(board);

	}



	public List<Board> selectBoardToMainOrderBy(Board board) {
		return dao.selectBoardToMainOrderBy(board);
	}

	@Cacheable(cacheName="getBoardByMain")
	public List<Board> getBoardByMain(Board board) {

//		BoardManage boardManage = new BoardManage(manage_idx);
		List<Board> list = dao.getBoardByMain(board);

		for (Board one : list) {
			if (!StringUtils.isEmpty(one.getContent_summary())) {
				one.setContent_summary(one.getContent_summary().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("<[^>]*..", ""));
			}
		}
		return list;
	}

	@Cacheable(cacheName="getBoardByMain")
	public List<Board> getBoardByMain(int manage_idx, int count) {

//		BoardManage boardManage = new BoardManage(manage_idx);
		List<Board> list = dao.getBoardByMain(new Board(manage_idx, count));

		for (Board board : list) {
			if (!StringUtils.isEmpty(board.getContent_summary())) {
				board.setContent_summary(board.getContent_summary().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("<[^>]*..", ""));
			}
		}
		return list;
	}

	@Cacheable(cacheName="getBoardByMain")
	public List<Board> getBoardByMain(int manage_idx, int count, String boardType) {

		BoardManage boardManage = new BoardManage();
		boardManage.setManage_idx(manage_idx);

		boardManage = boardManageService.getBoardManageOne(boardManage);

		Board board1 = new Board(manage_idx, count, boardType);
		if (boardManage != null) {
			board1.setHomepage_id(boardManage.getHomepage_id());
			board1.setCategory1Manage(boardManage.getCategory1());
			board1.setCategory2Manage(boardManage.getCategory2());
			board1.setCategory3Manage(boardManage.getCategory3());
		}
		List<Board> list = dao.getBoardByMain(board1);

		for (Board board : list) {
			if (!StringUtils.isEmpty(board.getContent_summary())) {
				board.setContent_summary(board.getContent_summary().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("<[^>]*..", ""));
			}
		}
		return list;
	}

	@Cacheable(cacheName="getBoardByMainTopNotice")
	public List<Board> getBoardByMainTopNotice(int manage_idx, int count, String boardType) {

//		BoardManage boardManage = new BoardManage(manage_idx);
		List<Board> list = dao.getBoardByMainTopNotice(new Board(manage_idx, count, boardType));

		for (Board board : list) {
			if (!StringUtils.isEmpty(board.getContent_summary())) {
				board.setContent_summary(board.getContent_summary().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("<[^>]*..", ""));
			}
		}
		return list;
	}

	@Cacheable(cacheName="getBoardByMain")
	public List<Board> getBoardByDepMain(int manage_idx, int count, String dept_cd) {
		return dao.getBoardByDepMain(new Board(manage_idx, count, dept_cd));
	}

	@Cacheable(cacheName="getBoardByMain")
	public List<Board> getQnaBoardByDepMain(int manage_idx, int count, String dept_cd) {
		return dao.getQnaBoardByDepMain(new Board(manage_idx, count, dept_cd));
	}

	public List<Board> getBoardByMainAll(Board board) {
		return dao.getBoardByMainAll(board);
	}

	public List<Board> getAllHomepageBoardListByMain(PagingUtils pagingUtils) {
		return dao.getAllHomepageBoardListByMain(pagingUtils);
	}

	public int getBoardCount(BoardManage boardManage, Board board) {
		board.setCategory1Manage(boardManage.getCategory1());
		board.setCategory2Manage(boardManage.getCategory2());
		board.setCategory3Manage(boardManage.getCategory3());
		board.setCategory4Manage(boardManage.getCategory4());
		board.setCategory5Manage(boardManage.getCategory5());

		board.setReply_list_yn(boardManage.getReply_list_yn());

		if(boardManage.getBoard_type().equals("QNA")) {
			return dao.getQnABoardCount(board);
		} else if(boardManage.getBoard_type().equals("BOOK") || boardManage.getBoard_type().equals("MOVIE") || boardManage.getBoard_type().equals("THEMEBOOK")
				|| boardManage.getBoard_type().equals("BOOK_PORTAL")) {
			return dao.getBOOKBoardCount(board);
		} else {
			return dao.getBoardCount(board);
		}
	}

	public int getDeleteBoardCount(BoardManage boardManage, Board board) {
		return dao.getDeleteBoardCount(board);
	}

	public List<Board> getBoardNotice(Board board) {
		return dao.getBoardNotice(board);
	}

	public List<Board> getBoardNotice2(Board board) {
		return dao.getBoardNotice2(board);
	}

	public List<Board> getBoardNews2(Board board) {
		return dao.getBoardNews2(board);
	}

	public int addViewCount(Board board) {
		return dao.addViewCount(board);
	}

	public Board getBoardOne(Board board) {
		return dao.getBoardOne(board);
	}

	public Board getMoviewBoardOne(Board board) {
		return dao.getMoviewBoardOne(board);
	}

	public List<Board> getQnABoard(Board board){
		return dao.getQnABoard(board);
	}


	public Board getPrevBoardOne(Board board) {
		return dao.getPrevBoardOne(board);
	}

	public Board getNextBoardOne(Board board) {
		return dao.getNextBoardOne(board);
	}

	public int checkLostCardBoard(Board board) {
		return dao.checkLostCardBoard(board);
	}

	@Transactional
	public int addReplyBoard(BoardManage boardManage, Board board, HttpServletRequest request) throws Exception {
		addBoard(boardManage, board, request);
		if (boardManage.getBoard_type().equals("LOSTCARD")) {
			dao.modifyLostCardBoard(board);
		} else {
			dao.modifyQnaBoard(board);
		}
		return 1;
	}

	@Transactional
	public int addReplyBoardToParentUpdate(BoardManage boardManage, Board board, HttpServletRequest request) throws Exception {
		board.setHomepage_id(boardManage.getHomepage_id());
		dao.addParentBoardUpdate(board);
		return 1;
	}

	@Transactional
	public String addBoard(BoardManage boardManage, Board board, HttpServletRequest request) throws Exception {
		Member member = (Member)loginService.getSessionMember(request);
		if ( StringUtils.isNotEmpty(board.getUser_password()) ) {
			board.setUser_password(CalculateHashUtils.calculateHash(board.getUser_password()));
		}

		if (member.isAnonymous()) {
			SupportMember supportMember = (SupportMember)request.getSession().getAttribute("loginSupport");
			PortalMember portalMember = (PortalMember)request.getSession().getAttribute("loginPortal");
			if(!member.isLogin() && supportMember != null) {
				board.setAdd_id(supportMember.getMember_id());
			} else if(!member.isLogin() && portalMember != null) {
				board.setAdd_id(portalMember.getAgency_id());
			} else {
				board.setAdd_id("ANONYMOUS");
				Object certObject = request.getSession().getAttribute("certMember");
				if (certObject != null && certObject instanceof Member) {
					Member certMember = (Member) certObject;
					board.setImsi_v_20(certMember.getCi_value());
				}
			}
		} else {
			board.setAdd_id(member.getMember_id());
		}

		if (StringUtils.isEmpty(board.getUser_name())) {
			board.setUser_name(member.getMember_name());
		}

		board.setUser_ip(RequestUtils.getClientIpAddr(request));

		board.setBeforeFilePath(boardTempStorage.getContextPath()+"/"+request.getSession().getId());
		board.setAfterFilePath(boardStorage.getContextPath());

		board.setBoard_idx(dao.getBoardIdx(board));
		if(board.getGroup_idx() == 0) {
			board.setGroup_idx(board.getBoard_idx());
		}

		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(member.getMember_name(), board, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}

//		board.setContent(xssFilter.doFilter(board.getContent()));
		if (StringUtils.isNotBlank(board.getContent())) {
			board.setContent(board.getContent().replaceAll(board.getBeforeFilePath(), board.getAfterFilePath() + "/" + boardManage.getManage_idx() + "/" + board.getBoard_idx()));
			board.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(board.getContent()),1000));
		}

		if(dao.addBoard(board) > 0) {

			if(board.getBoardFileArray()!=null && board.getBoardFileArray().length > 0) {
				boardFileService.fileProcess(board.getBoardFileArray(), board, "ADD", request);
					
				board.setFile_count(board.getBoardFileArray().length);
				dao.modifyBoardFileCount(board);
			}
		}

		return null;
	}

	@Transactional
	public String modifyBoard(BoardManage boardManage, Board board, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		if ( StringUtils.isNotEmpty(board.getUser_password()) && board.getUser_password().length() != 88 ) {
			board.setUser_password(CalculateHashUtils.calculateHash(board.getUser_password().trim()));
		}
//		board.setContent(xssFilter.doFilter(board.getContent()));
		board.setContent_summary(StrUtil.previewContent(StrUtil.delHtmlTagPatterns(board.getContent()),1000));

		if (member.isAnonymous()) {
			SupportMember supportMember = (SupportMember)request.getSession().getAttribute("loginSupport");
			PortalMember portalMember = (PortalMember)request.getSession().getAttribute("loginPortal");
			if(!member.isLogin() && supportMember != null) {
				board.setModify_id(supportMember.getMember_id());
			} else if(!member.isLogin() && portalMember != null) {
				board.setModify_id(portalMember.getAgency_id());
			} else {
				board.setModify_id("ANONYMOUS");
				board.setAdd_id("ANONYMOUS");
			}
		} else {
			board.setAdd_id(member.getMember_id());
			board.setModify_id(member.getMember_id());
		}

		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(member.getMember_name(), board, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}
		if(boardManage.getBoard_type().equals("LOSTCARD")) {
			dao.modifyLostCardBoard(board);
		}

		if(dao.modifyBoard(board) > 0) {
			boardFileService.deleteBoardFile(board.getBoard_idx());

			if(board.getBoardFileArray()!=null && board.getBoardFileArray().length > 0) {
				boardFileService.fileProcess(board.getBoardFileArray(), board, "MODIFY", request);
				board.setFile_count(board.getBoardFileArray().length);
				dao.modifyBoardFileCount(board);
			}
			if(boardManage.getBoard_type().equals("QNA")){
				dao.modifyQnaBoard(board);
			}
		}

		return null;
	}

	public int deleteBoard(Board board, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		SupportMember supportMember = (SupportMember)request.getSession().getAttribute("loginSupport");
		PortalMember portalMember = (PortalMember)request.getSession().getAttribute("loginPortal");
		if (member.isLogin() && member.getLoginType().equals("CMS")) {
			board.setModify_id(member.getMember_id());
		} else {
			if(!member.isLogin() && supportMember != null) {
				board.setModify_id(supportMember.getMember_id());
			} else if(!member.isLogin() && portalMember != null) {
				board.setModify_id(portalMember.getAgency_id());
			} else if (StringUtils.isNotEmpty(member.getWeb_id())) {
				board.setModify_id(member.getWeb_id());//일반이용자는 web_id로만 한다
			} else {
				board.setModify_id(member.getMember_id());//web_id가 없는경우 대출자번호를 넣는다.
			}
		}
		return dao.deleteBoard(board);
	}

	public int getReplyCount(Board board) {
		return dao.getReplyCount(board);
	}

	public int recoveryBoard(Board board) {
		return dao.recoveryBoard(board);
	}

	@Transactional
	public int moveBoard(Board board) {
		int moveResult = dao.moveBoard(board);
		if (moveResult > 0) {
			try {
				String filePath = boardFileService.getFilePath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx();
				File srcFile = new File(filePath);
				File targetDir = new File(boardFileService.getFilePath() + "/" + board.getTarget_manage_idx() + "/" + board.getBoard_idx());
//					FileUtils.copyFileToDirectory(srcFile, targetDir);
				FileUtils.copyDirectory(srcFile, targetDir, true);
			} catch (IOException e) {
				System.out.println("@@@@@@@@@@@@@@@@ boardFileMoveError");
				System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + board.getManage_idx());
				System.out.println("@@@@@@@@@@@@@@@@ board_idx : " + board.getBoard_idx());
				System.out.println("@@@@@@@@@@@@@@@@ target_manage_idx : " + board.getTarget_manage_idx());
				return moveResult;
			}
		}

		return moveResult;
	}

	public int updatePreviewImg(int board_idx, String preview_img) {
		return dao.updatePreviewImg(board_idx, preview_img);
	}

	public int updatePreviewImg(Board board) {
		return dao.updatePreviewImg(board);
	}

	/*public int modifyPreviewImg(Board board) {
		return dao.modifyPreviewImg(board);
	}*/

	/**********************/
	@Transactional
	public String migration() {
		String result = "";
		String board_table = "";
		List<Board> list = dao.selectArchBoard();

		if (list.size() > 0) {
			for (Board board : list) {
				if (!board_table.equals(board.getBoard_table())) {
					result += "---------------------------------------------------------------------------<br/>";
					result += "<------------"+ board.getBoard_table() + "[manage_idx : " + board.getManage_idx() + "] Start ------------><br/>" ;
					board_table = board.getBoard_table();
				}
				String beforePath = boardStorage.getRootPath() + "/board/" + board.getBoard_table() + "/";
				String afterPath = boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";
				List<String> file_arr = new ArrayList<String>();
				if (board.getB_file1() != null && !board.getB_file1().equals("")) {
					file_arr.add(board.getB_file1());
				}
				if (board.getB_file2() != null && !board.getB_file2().equals("")) {
					file_arr.add(board.getB_file2());
				}
				if (board.getB_file3() != null && !board.getB_file3().equals("")) {
					file_arr.add(board.getB_file3());
				}
				if (board.getB_file4() != null && !board.getB_file4().equals("")) {
					file_arr.add(board.getB_file4());
				}
				if (board.getB_file5() != null && !board.getB_file5().equals("")) {
					file_arr.add(board.getB_file5());
				}

				if (file_arr.size() > 0) {
					boardFileDao.deleteBoardFile(board.getBoard_idx());
					for (String fileName : file_arr) {
						try {
							fileName = fileName.replaceAll("&#33;", "!");
							fileName = fileName.replaceAll("&#40;", "\\(");
							fileName = fileName.replaceAll("&#41;", "\\)");
							fileName = fileName.replaceAll("&#58;", ":");
							fileName = fileName.replaceAll("&#60;", "<");
							fileName = fileName.replaceAll("&#61;", "=");
							fileName = fileName.replaceAll("&#62;", ">");
							BoardFile boardFile = new BoardFile();

							if (copyArchFile(beforePath, fileName, afterPath, boardFile)) {
								FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);

								boardFile.setBoard_idx(board.getBoard_idx());
								boardFileDao.addBoardFile(boardFile);
								if (board.getBoard_mode().equals("GALLERY")) {
									dao.updatePreviewImg(boardFile.getBoard_idx(), boardFile.getServer_file_name());
								}
							} else {
								result += board.getBoard_table() + "[board_idx : " + board.getBoard_idx() + "/beforeIdx : " + board.getB_num() +"/file : " + fileName + "] 파일 없음 !!<br/>";
							}
						} catch (Exception e) {
							e.printStackTrace();
							result = board.getBoard_table() + "[board_idx : " + board.getBoard_idx() + "/beforeIdx : " + board.getB_num() + "/file : " + fileName + "] 복사 중 에러 !!";
							TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							return result;
						}
					}
				}
			}
			result += "---------------------------------------------------------------------------<br/>완료!!";
		} else {
			result = "게시판 없음";
			return result;
		}

		return result;
	}

	private Boolean copyArchFile(String beforePath, String beforeFileName, String afterPath, BoardFile boardFile) throws IOException {
		String fileExt = beforeFileName.substring(beforeFileName.lastIndexOf("."));
		String fileName = Long.toString((System.currentTimeMillis())) + fileExt;

		File beforeFile = new File(beforePath+"/"+beforeFileName);
		File afterFile = new File(afterPath);

		/**
		 * 18. 중요한 자원에 대한 잘못된 권한 설정
		 * 시큐어 코딩 시정조치 - START
		 */
//		afterFile.setExecutable(false, true);
//		afterFile.setReadable(true);
//		afterFile.setWritable(false, true);
		/**
		 * 시큐어 코딩 시정조치 - END
		 */

		if(!afterFile.isDirectory()) {
			afterFile.mkdirs();
		}

		afterFile = new File(afterPath+"/"+fileName);

		if( beforeFile.exists() ) {
			FileInputStream inputStream = new FileInputStream(beforeFile);
			FileOutputStream outputStream = new FileOutputStream(afterFile);

			FileChannel fcin = inputStream.getChannel();
			FileChannel fcout = outputStream.getChannel();
			long size = 0;
			size = fcin.size();
	        fcin.transferTo(0, size, fcout);

	        fcout.close();
	        fcin.close();
	        outputStream.close();
	        inputStream.close();
		} else {
			return false;
		}

		boardFile.setOrg_file_name(beforeFileName);
		boardFile.setServer_file_name(fileName);
		boardFile.setFile_ext_name(fileExt);
		boardFile.setFile_size((int) afterFile.length());

		return true;
	}

	public int modifyApprovalCount(int board_idx) {
		return dao.modifyApprovalCount(board_idx);
	}

	public int modifyContraryCount(int board_idx) {
		return dao.modifyContraryCount(board_idx);
	}

	public Board getBoardOneMOIVE(Board board) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 *
	 * @param board - homepage_id, imsi_v_1 (YYYY-MM)
	 * @return
	 */
	public List<Board> getBoardMovie(Board board) {
		return dao.getBoardMovie(board);
	}
	
	/**
	 *
	 * @param board - homepage_id, imsi_v_1 (YYYY-MM)
	 * @return
	 */
	public List<Board> getCalendarBoardMovie(Board board) {
		return dao.getCalendarBoardMovie(board);
	}

	public int checkPassword(Board board) {
		board.setUser_password(CalculateHashUtils.calculateHash(board.getUser_password()));
		return dao.checkPassword(board);
	}

	public int modifyPreviewImg(Board board) {
		return dao.modifyPreviewImg(board);
	}

	public List<CalendarStatus> getBoardStatus(CalendarStatus calendarStatus) {
		return dao.getBoardStatus(calendarStatus);
	}

	public List<CalendarStatus> getBoardMonthStatus(CalendarStatus calendarStatus) {
		return dao.getBoardMonthStatus(calendarStatus);
	}

	public List<CalendarStatus> getBoardYearStatus(CalendarStatus calendarStatus) {
		return dao.getBoardYearStatus(calendarStatus);
	}

	public List<BoardFileAccess> getBoardFileAccess(BoardFileAccess boardFileAccess) {
		return dao.getBoardFileAccess(boardFileAccess);
	}

	public List<Board> getQnABoardOne(Board boardData) {
		return dao.getQnABoardOne(boardData);
	}

	private String webFilterCheck(String memberName, Board board, HttpServletRequest request) throws Exception {
//		Homepage homepage = (Homepage)request.getAttribute("homepage");
//		/*
//		 * WFMultiPartPost(웹서버도메인, 웹필터서버아이피, 웹필터서버포트)
//		 */
//		WFMultiPartPost wfsend = new WFMultiPartPost(homepage.getDomainWithoutProtocol(), "117.111.136.240", 80);
////		WFMultiPartPost wfsend = new WFMultiPartPost("localhost", "183.107.177.73", 80);
//
//		/*
//		 * WFMultiPartPost.sendWebFilter(작성자, 제목, 내용, 첨부파일경로)   - 첨부파일이 여러개 존재 시 , 로 구분하여 전송
//		 * 웹필터서버 응답  : 	Y = 차단		 N = 등록			B = 바이패스
//		 */
//
////		for (String fileName : board.getBoardFileArray()) {
////		}
//		String fileList = "";
//		for (String fileNameArry : board.getBoardFileArray()) {
//			String fileName = fileNameArry.split("//")[1];
//			String filePath = "";
//			if (board.getEditMode().equals("MODIFY")) {
//				filePath = boardFileService.getFilePath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";
//			} else {
//				filePath = boardTempStorage.getRootPath() + "/" + request.getSession().getId() + "/";
//			}
//
//			if (fileList.equals("")) {
//				fileList += filePath+fileName;
//			} else {
//				fileList += "," + filePath+fileName;
//			}
//		}
//
//		String wfResponse = wfsend.sendWebFilter(memberName, board.getTitle(), board.getContent(), fileList);
////		String wfResponse = wfsend.sendWebFilter(memberName, board.getTitle(), board.getContent(), "/data/homepage/data/board/229/80089/1487227701749.txt");
////	String wfResponse = wfsend.sendWebFilter("홍길동", "제목테스트 101111-1111111", "내용테스트 101111-1111111", "D:/101010.PNG");
//		if(wfResponse.equals("Y")){
//			// 차단내용 팝업창 URL 출력
////			res.setValid(true);
////			res.setUrl(wfsend.getDenyURL());
////			res.setTargetOpener(true);
//			return wfsend.getDenyURL();
//		} else if(wfResponse.equals("N")){
//
//			return null;
//		} else if(wfResponse.equals("B")){
//
//			return null;
//		}
		return null;
	}

	public List<Board> getBoardApi(BoardManage boardManage, Board board) {
		return dao.getBoardApi(board);
	}

	/**
	 * 데이터 완전삭제. 첨부파일 포함.
	 * @param board
	 * @return
	 */
	@Transactional
	public int dropBoard(Board board) {
		for (String idx : board.getBoardIdxArray()) {
			List<BoardFile> boardFiles = boardFileService.getBoardFile(Integer.parseInt(idx));
			for (BoardFile boardFile : boardFiles) {
				String fileName = boardFile.getOrg_file_name();
				String filePath = board.getManage_idx() + "/" + boardFile.getBoard_idx() + "/";
				boardStorage.deleteFile(fileName, filePath);
			}
			boardFileService.deleteBoardFile(Integer.parseInt(idx));
		}
		return dao.dropBoard(board);
	}

	public List<BoardAccess> getBoardAccessResult(BoardAccess boardAccess) {
		return dao.getBoardAccessResult(boardAccess);
	}

	public int getTotalSearchByTypeCount(Board board) {
		return dao.getTotalSearchByTypeCount(board);
	}

	public List<Board> getTotalSearchByType(Board board) {
		return dao.getTotalSearchByType(board);
	}

	/**
	 * 게시물 카테고리 이동
	 * @param board
	 * @return
	 */
	public int moveBoardCategory(Board board) {
		if (CollectionUtils.sizeIsEmpty(board.getBoardIdxArray())) {
			return dao.moveBoardCategory(board);
		} else {
			for (String idx : board.getBoardIdxArray()) {
				board.setBoard_idx(Integer.parseInt(idx));
				board.setTarget_category(board.getMoveCategory1Target());
				dao.moveBoardCategory(board);
			}
			return 1;
		}

	}

	/**
	 * PMS 게시판 카테고리별 상태 카운트
	 * @return
	 */
	public List<Map<String, String>> getRequestBoardStateCount(Board board) {
		return dao.getRequestBoardStateCount(board);
	}

	public int addFileDownloadCount(BoardFile boardFile) {
		return dao.addFileDownloadCount(boardFile);
	}

	public List<Board> getBoardRSS(Board board) {
		return dao.getBoardRSS(board);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 22.
	 * @param board
	 * @return
	 */
	public Map<String, Object> getBoardLibInfoCategoryCount(Board board) {
		String c2 = board.getCategory2();
		board.setCategory2("");
		List<Map<String, Object>> list = dao.getBoardLibInfoCategoryCount(board);
		 Map<String, Object> map = new HashMap<String, Object>();
		for (Map<String, Object> m : list) {
			map.put((String) m.get("CATEGORY2"), m.get("CNT"));
		}
		board.setCategory2(c2);

		return map;
	}

	public void initPass() {
		List<Board> list = dao.getAnonyList();
		for (Board board : list) {
			board.setUser_password(CalculateHashUtils.calculateHash(board.getImsi_v_17()));
			dao.updatePassword(board);
			System.out.println("@@@@@@@@@@@@@@@@ iipp : " + board.getBoard_idx());
		}
	}

	public List<Board> getSubBoardByMain(Board board) {
		return dao.getSubBoardByMain(board);
	}

	public List<Board> getSubBoardByMainDalseo(Board board) {
		return dao.getSubBoardByMainDalseo(board);
	}

	public int modifyThemeBook(Board board) {
		return dao.modifyThemeBook(board);
	}

	public Map<String, Object> getThemeCollection(Board board) {
		return dao.getThemeCollection(board);
	}

	public int delThemeBook(Board board) {
		return dao.delThemeBook(board);
	}

	public List<Board> getBoardBookJungu() {
		return dao.getBoardBookJungu(new Board());
	}
}