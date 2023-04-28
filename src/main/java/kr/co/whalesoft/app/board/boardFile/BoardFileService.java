package kr.co.whalesoft.app.board.boardFile;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
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
				String filePath2 = filePath;
				filePath = request.getSession().getId();
				boardFile = new BoardFile(boardTempStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				boardFile.setFile_size((int)multiFile.getSize());
				
				
				if(boardManage.getManage_idx() == 1008){
					File file2 = new File(filePath2 + "\\"+ fileName);//어떤 경로의 어떤 파일을 읽을것인지 설정하고 해당 파일객체 생성
					try {
						
						PDDocument document = PDDocument.load(file2);//pdf문서 객체 생성
						
						PDFRenderer pdfRenderer = new PDFRenderer(document);
						
						BufferedImage imageObj = pdfRenderer.renderImageWithDPI(0, 300, ImageType.RGB);//pdf파일의 페이지를돌면서 이미지 파일 변환
						File outputfile = new File(filePath2 + "\\" + 
									boardFile.getOrg_file_name().substring(0,boardFile.getOrg_file_name().length()-4) + ".jpg");
						
						ImageIO.write(imageObj, "jpg", outputfile);//변환한 파일 업로드
						document.close();
						
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			} else {
				boardFile = new BoardFile((Boolean)fileMap.get("valid"), (String)fileMap.get("msg"));
			}
		} else if(request.getParameter("mode").equals("MODIFY")) {
			int board_idx = Integer.parseInt(request.getParameter("board_idx"));
			filePath = boardStorage.getRootPath() + "/" + boardManage.getManage_idx() + "/" + board_idx + "/";
			String filePath2 = boardStorage.getRootPath() + "/" + boardManage.getManage_idx() + "/" + board_idx + "/";

			Map<String, Object> fileMap = fileCheck(filePath, multiFile.getOriginalFilename(), multiFile.getSize(), request);

			if((Boolean)fileMap.get("valid")) {
				filePath = "/" + boardManage.getManage_idx() + "/" + board_idx;
				boardFile = new BoardFile(boardStorage.addFile(multiFile, fileName, filePath), fileName, filePath);
				
				if(boardManage.getManage_idx() == 1008){
					File file2 = new File(filePath2 + "\\"+ fileName);//어떤 경로의 어떤 파일을 읽을것인지 설정하고 해당 파일객체 생성
					try {
						
						PDDocument document = PDDocument.load(file2);//pdf문서 객체 생성
						
						PDFRenderer pdfRenderer = new PDFRenderer(document);
						
						BufferedImage imageObj = pdfRenderer.renderImageWithDPI(0, 300, ImageType.RGB);//pdf파일의 페이지를돌면서 이미지 파일 변환
						File outputfile = new File(filePath2 + "\\" + 
									boardFile.getOrg_file_name().substring(0,boardFile.getOrg_file_name().length()-4) + ".jpg");
						
						ImageIO.write(imageObj, "jpg", outputfile);//변환한 파일 업로드
						document.close();
						
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
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
			String extSample = "jsp|cgi|php|asp|aspx|exe|com|html|htm|cab|php3|pl|java|class|js|css";
			String extCheck[] = extSample.split( "\\|" );
			String extension = "";
			int pos = fileName.lastIndexOf( "." );
			if ( pos > -1 ) {
				extension = fileName.substring( pos+1 );		// .을 포함한 확장자
			}
			
			for(String check : extCheck) {
				if(check.toLowerCase().equals(extension.toLowerCase())) {
					fileMap.put("valid", false);
					fileMap.put("msg", "파일 업로드가 불가능한 확장자 파일입니다. " + extension.toLowerCase());
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
					if(board.getManage_idx() == 1008) {
						String replace = fileInfo.split("//")[1].replace(".pdf", ".jpg");
						FileUtil.fileMove(beforePath, afterPath, replace);
						
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
						boardFile.setServer_file_name(replace);
						dao.addBoardFile(boardFile);
					} else if(board.getManage_idx() == 1133 || board.getManage_idx() == 1134 || board.getManage_idx() == 1135) {
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 2000, 1381);
						dao.addBoardFile(boardFile);
					} else {
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
						dao.addBoardFile(boardFile);
					}
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
					if(board.getManage_idx() == 1008) {
						
						String replace = fileInfo.split("//")[1].replace(".pdf", ".jpg");
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
						boardFile.setServer_file_name(replace);
						dao.addBoardFile(boardFile);
						
						FileUtil.noUseFileDeletePdf(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/", boardFileArray);	// 필요없는 파일 삭제
						FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/thumb/", boardFileArray);	// 필요없는 파일 삭제(썸네일)
					} else if(board.getManage_idx() == 1133 || board.getManage_idx() == 1134 || board.getManage_idx() == 1135) {
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 2000, 1381);
						dao.addBoardFile(boardFile);
						FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/", boardFileArray);	// 필요없는 파일 삭제
						FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/thumb/", boardFileArray);	// 필요없는 파일 삭제(썸네일)
					} else {
						FileUtil.thumbImgMake(afterPath, boardFile.getServer_file_name(), boardFile.getFile_ext_name(), 236, 163);
						dao.addBoardFile(boardFile);
						FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/", boardFileArray);	// 필요없는 파일 삭제
						FileUtil.noUseFileDelete(boardStorage.getRootPath() + "/" + board.getManage_idx() + "/" + board.getBoard_idx() + "/thumb/", boardFileArray);	// 필요없는 파일 삭제(썸네일)
					}

				}
				

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
			
			String fileLastName = fileName.substring(fileName.length()-3, fileName.length());
			if (fileLastName.equals("pdf")) {
			String changFileName = fileName.replace(".pdf", ".jpg"); 
			boardTempStorage.deleteFile(changFileName, filePath);
				
			}
			
		} else if (mode.equals("MODIFY")) {
			String fileName = boardFile.getServer_file_name();
			String filePath = request.getParameter("manage_idx") + "/" + boardFile.getBoard_idx() + "/";
			boardStorage.deleteFile(fileName, filePath);
			
			int board_idx = boardFile.getBoard_idx();
			dao.deleteBoardFile(board_idx);
			
			boardTempStorage.deleteFolder(filePath);
			
			int boardNum = Integer.parseInt(filePath.split("/")[0]); 
			if (boardNum == 1008) {
				String replace = fileName.replace(".jpg", ".pdf");
				boardStorage.deleteFile(replace, filePath);
				
			}
		}
	}

	@Transactional
	public int addBoardFileCount(BoardFile boardFile) {
		boardService.addFileDownloadCount(boardFile);
		return dao.addBoardFileCount(boardFile);
	}

}
