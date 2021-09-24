package kr.co.whalesoft.app.board.boardFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.file.FileUtil;

@Service
public class BoardFileService extends BaseService {

	@Autowired
	@Qualifier("boardStorage")
	private FileStorage boardStorage;

	@Autowired
	@Qualifier("boardTempStorage")
	private FileStorage boardTempStorage;

	@Autowired
	private BoardFileDao dao;

	@Autowired
	private BoardService boardService;

	@Autowired
	private BoardManageService boardManageService;

	public List<BoardFile> getBoardFile(int board_idx) {
		return dao.getBoardFile(board_idx);
	}

	public BoardFile getBoardFileOne(BoardFile boardFile) {
		return dao.getBoardFileOne(boardFile);
	}

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
	public BoardFile upload(MultipartFile multiFile, HttpServletRequest request) throws IOException {
		int manage_idx = Integer.parseInt(request.getParameter("manage_idx"));
		BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(null, manage_idx));

		BoardFile boardFile = null;
		String filePath = "";

		String fileName = generateUniqueFileName("") + multiFile.getOriginalFilename().substring(multiFile.getOriginalFilename().lastIndexOf("."));

		if(request.getParameter("mode").equals("ADD") || request.getParameter("mode").equals("REPLY")) {
			filePath = boardTempStorage.getRootPath() + "/" + request.getSession().getId() + "/";
			Map<String, Object> fileMap = fileCheck(filePath, multiFile.getOriginalFilename(), multiFile.getSize(), request);

			if((Boolean)fileMap.get("valid")) {
				filePath = request.getSession().getId();
				boardFile = new BoardFile(boardTempStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				boardFile.setFile_size((int)multiFile.getSize());
			} else {
				boardFile = new BoardFile((Boolean)fileMap.get("valid"), (String)fileMap.get("msg"));
			}
		} else if(request.getParameter("mode").equals("MODIFY")) {
			int board_idx = Integer.parseInt(request.getParameter("board_idx"));
			filePath = boardStorage.getRootPath() + "/" + boardManage.getManage_idx() + "/" + board_idx + "/";

			Map<String, Object> fileMap = fileCheck(filePath, multiFile.getOriginalFilename(), multiFile.getSize(), request);

			if((Boolean)fileMap.get("valid")) {
				filePath = "/" + boardManage.getManage_idx() + "/" + board_idx;
				boardFile = new BoardFile(boardStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				boardFile.setFile_size((int)multiFile.getSize());
			} else {
				boardFile = new BoardFile((Boolean)fileMap.get("valid"), (String)fileMap.get("msg"));
			}
		}

		return boardFile;
	}

	/**
	 * 파일 유효성 검증
	 * @param filePath
	 * @param fileName
	 * @param fileSize
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public Map<String, Object> fileCheck(String filePath, String fileName, long fileSize, HttpServletRequest request) throws IOException {
		int manage_idx = Integer.parseInt(request.getParameter("manage_idx"));
		BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(null, manage_idx));

		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("valid", true);

		Map<String , Long> fileInfoMap = FileUtil.childFileSize(filePath);
		long totalFileSize = fileInfoMap.get("totalFileSize");
		long fileCount = fileInfoMap.get("fileCount");

		if((boardManage.getFile_size_total() * 1024 * 1024) < (totalFileSize+fileSize)) {			// 파일 총 용량 체크
			fileMap.put("valid", false);
			fileMap.put("msg", "파일의 총 용량이 " +boardManage.getFile_size_total()+" MB를 넘을 수 없습니다.");
		} else if(boardManage.getFile_count() <= fileCount) {
			fileMap.put("valid", false);
			fileMap.put("msg", "파일의 갯수가 " +boardManage.getFile_count()+" 개를 넘을 수 없습니다.");
		}

		if(boardManage.getFile_ban_ext() != null) {
			String extCheck[] = boardManage.getFile_ban_ext().split( "|" );
			String extension = "";
			int pos = fileName.lastIndexOf( "." );
			if ( pos > -1 ) {
				extension = fileName.substring( pos+1 );		// .을 포함한 확장자
			}
			for( int i=0;i<extCheck.length;i++ ) {
				if(extCheck[i].trim().toLowerCase().equals(extension.toLowerCase())) {
					fileMap.put("valid", false);
					fileMap.put("msg", "파일 업로드가 불가능한 확장자 파일입니다.");
					break;
				}
			}
		}

		return fileMap;
	}

	/**
	 * 파일 처리
	 * @param boardFileArray
	 * @param board
	 * @param mode
	 * @param request
	 */
	@Transactional
	public void fileProcess(String[] boardFileArray, Board board, String mode, HttpServletRequest request) {
		try {
			//String date_file_path = boardService.getAddBoardDate(board.getBoard_idx());

			if(mode.equals("ADD")) {
				String beforePath = boardTempStorage.getRootPath() + "/" + request.getSession().getId() + "/";
				String afterPath = boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";

				for(String fileInfo : boardFileArray) {
					BoardFile boardFile = new BoardFile(fileInfo.split("//"), board);

					FileUtil.fileMove(beforePath, afterPath, fileInfo.split("//")[1]);
					FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
					dao.addBoardFile(boardFile);
				}

				/**
				 * 파일의 이동이 끝나면 임시폴더는 삭제한다.
				 */
				boardTempStorage.deleteFolder(request.getSession().getId());
			} else if(mode.equals("MODIFY")) {
				//String beforePath = boardTempStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";
				String afterPath = boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/";

				for(String fileInfo : boardFileArray) {
					BoardFile boardFile = new BoardFile(fileInfo.split("//"), board);

					//FileUtil.fileMove(beforePath, afterPath, fileInfo.split("//")[1]);

					FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
					dao.addBoardFile(boardFile);
				}

				FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/", boardFileArray);	// 필요없는 파일 삭제
				FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/thumb/", boardFileArray);	// 필요없는 파일 삭제(썸네일)

				/**
				 * 파일의 이동이 끝나면 임시폴더는 삭제한다.
				 */
				//boardTempStorage.deleteFolder(Integer.toString(board.getManage_idx()));
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		//등록, 수정된 게시물의 파일에 따라 미리보기 이미지 수정
		boardService.modifyPreviewImg(board);
	}

	public String getFilePath() {
		return boardStorage.getRootPath();
	}

	public int deleteBoardFile(int board_idx) {
		return dao.deleteBoardFile(board_idx);
	}

	public void initBoardFile(Board board, HttpServletRequest request) throws IOException {
		String mode = board.getEditMode();

		if(mode != null) {
//			if(mode.equals("MODIFY")) {		// 수정시 쓰레기 파일 삭제
//				int board_idx = board.getBoard_idx();
//				int manage_idx = board.getManage_idx();
//				//String date_file_path = boardService.getAddBoardDate(board_idx);
//				String filePath = boardStorage.getRootPath() + "/" + manage_idx + "/" + board_idx + "/";
//				List<BoardFile> boardFileList = dao.getBoardFile(board_idx);
//				FileUtil.noUseFileDelete(filePath, boardFileList);
//				String fileTempPath = boardTempStorage.getRootPath() + "/" + manage_idx + "/" + board_idx + "/";
//				boardTempStorage.deleteFolder(fileTempPath);
//			} else if(mode.equals("ADD")) {	// 입력시 쓰레기 파일 삭제
				String filePath = request.getSession().getId() + "/";
				boardTempStorage.deleteFolder(filePath);
//			}
		}
	}

	public void deleteFile(BoardFile boardFile, HttpServletRequest request) throws IOException {
		String mode = request.getParameter("mode");
		if (mode.equals("ADD")) {
			String fileName = boardFile.getServer_file_name();
			String filePath = request.getSession().getId() + "/";
			boardTempStorage.deleteFile(fileName, filePath);
		} else if (mode.equals("MODIFY")) {
			String fileName = boardFile.getServer_file_name();
			String filePath = request.getParameter("manage_idx") + "/" + boardFile.getBoard_idx() + "/";
			boardStorage.deleteFile(fileName, filePath);
			
			int board_idx = boardFile.getBoard_idx();
			dao.deleteBoardFile(board_idx);
			
			boardTempStorage.deleteFolder(filePath);
		}
	}

	@Transactional
	public int addBoardFileCount(BoardFile boardFile) {
		boardService.addFileDownloadCount(boardFile);
		return dao.addBoardFileCount(boardFile);
	}

}
