package kr.co.whalesoft.app.board.boardComment.boardCommentFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.app.board.boardComment.BoardComment;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.file.FileUtil;

@Service
public class BoardCommentFileService extends BaseService {

	@Autowired
	@Qualifier("boardCommentStorage")
	private FileStorage boardCommentStorage;
	
	@Autowired
	@Qualifier("boardCommentTempStorage")
	private FileStorage boardCommentTempStorage;
	
	@Autowired
	private BoardCommentFileDao dao;
	
	@Autowired
	private BoardManageService boardManageService;
	
	private String generateUniqueFileName(String path) {
		String filename = "";
		String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
		String rndchars = RandomStringUtils.randomAlphanumeric(7);
		do {
			filename = datetime + "_" + rndchars;
		} while(new File(path + filename).exists());

		return filename;
	}
	
	@Transactional
	public BoardCommentFile upload(MultipartFile multiFile, HttpServletRequest request) throws IOException {
		int manage_idx = Integer.parseInt(request.getParameter("manage_idx"));
		BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(null, manage_idx));
		
		BoardCommentFile boardCommentFile = null;
		String filePath = "";
		
		String fileName = generateUniqueFileName("") + multiFile.getOriginalFilename().substring(multiFile.getOriginalFilename().lastIndexOf("."));
		
		if(request.getParameter("mode").equals("ADD") || request.getParameter("mode").equals("REPLY")) {
			filePath = boardCommentTempStorage.getRootPath() + "/" + request.getSession().getId() + "/";
//			Map<String, Object> fileMap = boardFileService.fileCheck(filePath, multiFile.getOriginalFilename(), multiFile.getSize(), request);
//			
//			if((Boolean)fileMap.get("valid")) {
				filePath = request.getSession().getId();
				boardCommentFile = new BoardCommentFile(boardCommentTempStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				boardCommentFile.setFile_size((int)multiFile.getSize()); 
//			} else {
//				boardCommentFile = new BoardCommentFile((Boolean)fileMap.get("valid"), (String)fileMap.get("msg"));
//			}
		} else if(request.getParameter("mode").equals("MODIFY")) {
			int comment_idx = Integer.parseInt(request.getParameter("comment_idx"));
			filePath = boardCommentStorage.getRootPath() + "/" + boardManage.getManage_idx() + "/" + comment_idx + "/";
			
//			Map<String, Object> fileMap = boardFileService.fileCheck(filePath, multiFile.getOriginalFilename(), multiFile.getSize(), request);
			
//			if((Boolean)fileMap.get("valid")) {
				filePath = "/" + boardManage.getManage_idx() + "/" + comment_idx;
				boardCommentFile = new BoardCommentFile(boardCommentStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				boardCommentFile.setFile_size((int)multiFile.getSize());
//			} else {
//				boardCommentFile = new BoardCommentFile((Boolean)fileMap.get("valid"), (String)fileMap.get("msg"));
//			}
		}
				
		return boardCommentFile;
	}

	public BoardCommentFile getBoardCommentFileOne(BoardCommentFile boardCommentFile) {
		return dao.getBoardCommentFileOne(boardCommentFile);
	}

	public String getFilePath() {
		return boardCommentStorage.getRootPath();
	}

	public int addBoardCommentFileCount(BoardCommentFile boardCommentFile) {
		return dao.addBoardCommentFileCount(boardCommentFile);
	}

	public void deleteFile(BoardCommentFile boardCommentFile, HttpServletRequest request) throws IOException {
		String mode = request.getParameter("mode");
		if (mode.equals("ADD")) {
			String fileName = boardCommentFile.getFile_name();
			String filePath = request.getSession().getId() + "/";
			boardCommentTempStorage.deleteFile(fileName, filePath);
		} else if (mode.equals("MODIFY")) {
			String fileName = boardCommentFile.getFile_name();
			String filePath = request.getParameter("manage_idx") + "/" + boardCommentFile.getComment_idx() + "/";
			boardCommentStorage.deleteFile(fileName, filePath);
		}
	}
	
	public void initBoardFile(HttpServletRequest request) throws IOException {
		String mode = request.getParameter("mode");
		
		if(mode != null) {
			if(mode.equals("MODIFY")) {		// 수정시 쓰레기 파일 삭제
				int comment_idx = Integer.parseInt(request.getParameter("comment_idx"));
				String manage_idx = request.getParameter("manage_idx");
				//String date_file_path = boardService.getAddBoardDate(board_idx);
				String filePath = boardCommentStorage.getRootPath() + "/" + manage_idx + "/" + comment_idx + "/";
				List<BoardCommentFile> boardFileList = dao.getBoardCommentFile(comment_idx);
				FileUtil.noUseCommentFileDelete(filePath, boardFileList);
				/*String fileTempPath = boardTempStorage.getRootPath() + "/" + manage_idx + "/" + board_idx + "/";
				boardTempStorage.deleteFolder(fileTempPath);*/
			} else if(mode.equals("ADD")) {	// 입력시 쓰레기 파일 삭제
				String filePath = request.getSession().getId() + "/"; 
				boardCommentTempStorage.deleteFolder(filePath);
			}
		}
	}

	
	/**
	 * 파일 처리
	 * @param boardFileArray
	 * @param boardComment
	 * @param mode
	 * @param request
	 */
	@Transactional
	public void fileProcess(String[] boardFileArray, BoardComment boardComment, String mode, HttpServletRequest request) {
		try {
			//String date_file_path = boardService.getAddBoardDate(board.getBoard_idx());
			
			if(mode.equals("ADD")) {
				String beforePath = boardCommentTempStorage.getRootPath() + "/" + request.getSession().getId() + "/";
				String afterPath = boardCommentStorage.getRootPath() + "/" + boardComment.getManage_idx() + "/" + boardComment.getComment_idx() + "/";
				
				for(String fileInfo : boardFileArray) {
					BoardCommentFile boardCommentFile = new BoardCommentFile(fileInfo.split("//"), boardComment);
					
					FileUtil.fileMove(beforePath, afterPath, fileInfo.split("//")[1]);
					FileUtil.thumbImgMake(afterPath, boardCommentFile.getReal_file_name(), boardCommentFile.getFile_ext_name(), 236, 163);
					dao.addBoardCommentFile(boardCommentFile);
				}
				
				/**
				 * 파일의 이동이 끝나면 임시폴더는 삭제한다. 
				 */
				boardCommentTempStorage.deleteFolder(request.getSession().getId());
			} else if(mode.equals("MODIFY")) {
				//String beforePath = boardTempStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";
				String afterPath = boardCommentStorage.getRootPath() + "/" + boardComment.getManage_idx() + "/" + boardComment.getComment_idx() + "/";
				
				for(String fileInfo : boardFileArray) {
					BoardCommentFile boardFile = new BoardCommentFile(fileInfo.split("//"), boardComment);
					
					//FileUtil.fileMove(beforePath, afterPath, fileInfo.split("//")[1]);
					
					FileUtil.thumbImgMake(afterPath, boardFile.getReal_file_name(), boardFile.getFile_ext_name(), 236, 163);
					dao.addBoardCommentFile(boardFile);
				}
				
				FileUtil.noUseFileDelete(boardCommentStorage.getRootPath() + "/" + boardComment.getManage_idx() + "/" + boardComment.getComment_idx() + "/", boardFileArray);	// 필요없는 파일 삭제
				FileUtil.noUseFileDelete(boardCommentStorage.getRootPath() + "/" + boardComment.getManage_idx() + "/" + boardComment.getComment_idx() + "/thumb/", boardFileArray);	// 필요없는 파일 삭제(썸네일)
				
				/**
				 * 파일의 이동이 끝나면 임시폴더는 삭제한다. 
				 */
				//boardTempStorage.deleteFolder(Integer.toString(board.getManage_idx()));
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		//등록, 수정된 게시물의 파일에 따라 미리보기 이미지 수정
//		boardService.modifyPreviewImg(boardComment);
	}

	public List<BoardCommentFile> getBoardCommentFile(BoardComment cmt) {
		return dao.getBoardCommentFile(cmt.getComment_idx());
	}
}
