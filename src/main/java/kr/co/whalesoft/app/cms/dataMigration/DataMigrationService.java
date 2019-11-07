package kr.co.whalesoft.app.cms.dataMigration;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.file.FileUtil;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DataMigrationService extends BaseService{

	@Autowired
	private DataMigrationDao dao;

	@Autowired
	@Qualifier("boardStorage")
	private FileStorage storage;

	@Autowired
	@Qualifier("boardStorage")
	private FileStorage boardStorage;

	@DataSource(DataSourceType.SLAVE1)
	public List<DataMigration> orgList(int manager_seq) {
		List<DataMigration> list = dao.orgList(manager_seq);
		System.out.println("@@@@@@@@@@@@@@@@@ listSize : " + list.size());
		return list;
	}

	@Transactional
	@DataSource(DataSourceType.MASTER)
	public void migration2(List<DataMigration> list, int manager_seq, int manage_idx) {

		for (int i = 0; i < list.size(); i++) {

			DataMigration orgMap = list.get(i);

			List<Map<String, Object>> orgFileMap = dao.getFileData(Integer.parseInt(String.valueOf(orgMap.getBoard_seq())));
			int boardIdx = dao.getNextBoardIdx();
			orgMap.setBoard_idx(boardIdx);
			orgMap.setManage_idx(manage_idx);
			dao.insertBoard(orgMap);
			boolean hasFile = false;
			for (Map<String, Object> map2 : orgFileMap) {
				map2.put("board_idx", boardIdx);
				dao.insertBoardFile(map2);
				hasFile = true;
			}

			if (hasFile) {
				System.out.println("### : " + storage.getRootPath() + "/" + manager_seq + "/" + orgMap.getBoard_seq());
				File sourceLocation = new File(storage.getRootPath() + "/" + manager_seq + "/" + orgMap.getBoard_seq());// 원본폴더
				File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx);// 게시판번호
																								// 폴더
				File targetLocation2 = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.getBoard_seq());// 게게시물번호
																																// 폴더
				File targetLocation3 = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.getBoard_idx());// 바꿀이름

				try {
					FileUtils.copyDirectoryToDirectory(sourceLocation, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (targetLocation2.isDirectory()) {
					System.out.println(targetLocation2.renameTo(targetLocation3));
				}
			}

		}
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListInfoset(int parseInt) {
		List<DataMigration> list = dao.getOrgListInfoset(parseInt);
		System.out.println("@@@@@@@@@@@@@@@@@ listSize : " + list.size());
		return null;
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListDK(int manager_seq) {
		List<DataMigration> list = dao.orgListDK(manager_seq);
		System.out.println("@@@@@@@@@@@@@@@@@ listSize : " + list.size());
		return list;
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getFileDataDK(int bb_code) {
		return dao.getFileDataDK(bb_code);
	}

	public int getNextBoardIdx() {
		return dao.getNextBoardIdx();
	}

	public int insertBoard(DataMigration dataMigration) {
		return  dao.insertBoard(dataMigration);
	}

	public int insertBoardFile(Map<String, Object> map2) {
		return dao.insertBoardFile(map2);
	}

	public void fileMoveDK(Map<String, Object> orgMap, int manage_idx) {

		String fileName = String.valueOf(orgMap.get("REAL_FILE_NAME"));
		String fileName2 = String.valueOf(orgMap.get("FILE_NAME"));

		File sourceFile = new File("D:\\develop_tool\\board\\" + fileName);

		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/");// 대상폴더


		if (!targetLocation.exists()) {
			targetLocation.mkdir();
		}

		try {
			FileUtils.copyFileToDirectory(sourceFile, targetLocation);

			File targetFile =  new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName);// 대상폴더
			File targetLocationRename = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName2);// 대상폴더
			targetFile.renameTo(targetLocationRename);
		} catch (IOException e) {
			e.printStackTrace();
		}

		File thumbFile = new File("D:\\develop_tool\\board\\thumb1_" + fileName);

		if (thumbFile.exists()) {
			targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

			if (!targetLocation.exists()) {
				targetLocation.mkdir();
			}

			try {
				FileUtils.copyFileToDirectory(thumbFile, targetLocation);
			} catch (IOException e) {
				e.printStackTrace();
			}

			File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/Thum_" + fileName);// 이동된 섬네일
			File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

			newThumbFile.renameTo(renameThumbFile);
		} else {
			String ext = "jpg|bmp|gif|png|jpeg";
			String extname = String.valueOf(orgMap.get("FILE_EXT")).replace(".", "");
			if (ext.indexOf(extname) > -1) {
				thumbFile = new File("D:\\develop_tool\\board\\" + fileName);

				targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

				if (!targetLocation.exists()) {
					targetLocation.mkdir();
				}

				try {
					FileUtils.copyFileToDirectory(thumbFile, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}

				File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName);// 이동된 섬네일
				File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

				newThumbFile.renameTo(renameThumbFile);
			}
		}



	}

	public void fileMoveGM(Map<String, Object> orgMap, int manage_idx) {

		String fileName = String.valueOf(orgMap.get("REAL_FILE_NAME"));
		String fileNametmp = fileName.substring(fileName.lastIndexOf("/")+1);
		String fileName2 = String.valueOf(orgMap.get("FILE_NAME"));

		File sourceFile = new File("D:\\develop_tool\\board\\" + fileName);

		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/");// 대상폴더


		if (!targetLocation.exists()) {
			targetLocation.mkdir();
		}

		try {
			FileUtils.copyFileToDirectory(sourceFile, targetLocation);

			File targetFile =  new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileNametmp);// 대상폴더
			File targetLocationRename = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName2);// 대상폴더
			targetFile.renameTo(targetLocationRename);
		} catch (IOException e) {
			e.printStackTrace();
		}

		File thumbFile = new File("D:\\develop_tool\\board\\Thumb_" + fileName);

		if (thumbFile.exists()) {
			targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

			if (!targetLocation.exists()) {
				targetLocation.mkdir();
			}

			try {
				FileUtils.copyFileToDirectory(thumbFile, targetLocation);
			} catch (IOException e) {
				e.printStackTrace();
			}

			File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/Thumb_" + fileName);// 이동된 섬네일
			File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

			newThumbFile.renameTo(renameThumbFile);
		} else {
			String ext = "jpg|bmp|gif|png|jpeg";
			String extname = String.valueOf(orgMap.get("FILE_EXT")).replace(".", "");
			if (ext.indexOf(extname) > -1) {
				thumbFile = new File("D:\\develop_tool\\board\\" + fileName);

				targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

				if (!targetLocation.exists()) {
					targetLocation.mkdir();
				}

				try {
					FileUtils.copyFileToDirectory(thumbFile, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}

				File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileNametmp);// 이동된 섬네일
				File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

				newThumbFile.renameTo(renameThumbFile);
			}
		}



	}


	public void fileMovebookDK(Map<String, Object> orgMap, int manage_idx) {

		String fileName = String.valueOf(orgMap.get("REAL_FILE_NAME"));
		String fileName2 = String.valueOf(orgMap.get("FILE_NAME"));

		File sourceFile = new File("D:\\develop_tool\\book\\" + fileName);

		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/");// 대상폴더


		if (!targetLocation.exists()) {
			targetLocation.mkdir();
		}

		try {
			FileUtils.copyFileToDirectory(sourceFile, targetLocation);
			File targetFile =  new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName);// 대상폴더
			File targetLocationRename = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName2);// 대상폴더
			targetFile.renameTo(targetLocationRename);
		} catch (IOException e) {
			e.printStackTrace();
		}

		File thumbFile = new File("D:\\develop_tool\\book\\Thum_" + fileName);

		if (thumbFile.exists()) {
			targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

			if (!targetLocation.exists()) {
				targetLocation.mkdir();
			}

			try {
				FileUtils.copyFileToDirectory(thumbFile, targetLocation);
			} catch (IOException e) {
				e.printStackTrace();
			}

			File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/Thum_" + fileName);// 이동된 섬네일
			File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

			newThumbFile.renameTo(renameThumbFile);
		} else {
			String ext = "jpg|bmp|gif|png|jpeg";
			String extname = String.valueOf(orgMap.get("FILE_EXT")).replace(".", "");
			if (ext.indexOf(extname) > -1) {
				thumbFile = new File("D:\\develop_tool\\book\\" + fileName);

				targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

				if (!targetLocation.exists()) {
					targetLocation.mkdir();
				}

				try {
					FileUtils.copyFileToDirectory(thumbFile, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}

				File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName);// 이동된 섬네일
				File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

				newThumbFile.renameTo(renameThumbFile);
			}
		}



	}


	public int insertBoarddk(DataMigration orgMap) {
		return dao.insertBoarddk(orgMap);
	}

	public int insertBoardFiledk(Map<String, Object> map2) {
		return dao.insertBoardFiledk(map2);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getCommentDK(int bb_code) {
		return dao.getCommentDK(bb_code);
	}

	public int addBoardCommentdk(Map<String, Object> map2) {
		return dao.addBoardCommentdk(map2);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListDKtheme(int manager_seq) {
		return dao.orgListDKtheme(manager_seq);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListDKbook(int manager_seq) {
		return dao.orgListDKbook(manager_seq);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListDK2(String categoryName) {
		return dao.orgListDK2(categoryName);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListINFO(int manager_seq) {
		return dao.orgListINFO(manager_seq);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListyd(DataMigration dm) {
		return dao.orgListyd(dm);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListyd2(DataMigration dm) {
		return dao.orgListyd2(dm);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListyd3(DataMigration dm) {
		return dao.orgListyd3(dm);
	}

	public int insertBoardyd(DataMigration orgMap) {
		return dao.insertBoardyd(orgMap);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getFileDataYD(int board_seq) {
		return dao.getFileDataYD(board_seq);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListDK3(String categoryName) {
		return dao.orgListDK3(categoryName);
	}

	public List<BoardFile> getFileList(int board_seq) {
		return dao.getFileList(board_seq);
	}

	public List<DataMigration> boardList(int manager_seq) {
		return dao.boardList(manager_seq);
	}

	public void makeThumb(int manage_idx, BoardFile boardFile) {
		File path = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + boardFile.getBoard_idx() + "/");
		File sourceFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + boardFile.getBoard_idx() + "/" + boardFile.getReal_file_name());// 원본파일
		String afterPath = boardStorage.getRootPath() + "/" + manage_idx + "/" + boardFile.getBoard_idx() + "/";

		try {
			FileUtil.thumbImgMake(afterPath, boardFile.getReal_file_name(), boardFile.getFile_ext_name(), 236, 163);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getFileData(int board_seq) {
		return dao.getFileData(board_seq);
	}

	public void fileMove(Map<String, Object> map2, int manager_seq, int manage_idx) {
		System.out.println("### : " + storage.getRootPath() + "/" + manager_seq + "/" + String.valueOf(map2.get("BOARD_SEQ")));
		File sourceLocation = new File(storage.getRootPath() + "/" + manager_seq + "/" + String.valueOf(map2.get("BOARD_SEQ")));// 원본폴더
		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx);// 게시판번호
																						// 폴더
		File targetLocation2 = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + String.valueOf(map2.get("BOARD_SEQ")));// 게게시물번호
																														// 폴더
		File targetLocation3 = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + String.valueOf(map2.get("board_idx")));// 바꿀이름

		try {
			FileUtils.copyDirectoryToDirectory(sourceLocation, targetLocation);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (targetLocation2.isDirectory()) {
			System.out.println(targetLocation2.renameTo(targetLocation3));
		}
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getCommentData(int board_seq) {
		return dao.getCommentData(board_seq);
	}

	public int insertBoardComment(Map<String, Object> map2) {
		return dao.insertBoardComment(map2);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getReadCommentDK(int board_seq) {
		return dao.getReadCommentDK(board_seq);
	}




	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListGM(int manager_seq) {
		List<DataMigration> list = dao.orgListGM(manager_seq);
		System.out.println("@@@@@@@@@@@@@@@@@ listSize : " + list.size());
		return list;
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getFileDataGM(int bb_code) {
		return dao.getFileDataGM(bb_code);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListGM3(String categoryName) {
		return dao.orgListGM3();
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListGM2(String string) {
		return dao.orgListGM2();
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListOD2(String string) {
		return dao.orgListOD2(string);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListJC(DataMigration tabaleName) {
		return dao.orgListJC(tabaleName);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<Map<String, Object>> getFileDataJC(DataMigration orgMap) {
		return dao.getFileDataJC(orgMap);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListJCBook() {
		return dao.orgListJCBook();
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListJCMovie() {
		return dao.orgListJCMovie();
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListPG(int manager_seq) {
		return dao.orgListPG(manager_seq);
	}

	@DataSource(DataSourceType.SLAVE2)
	public List<DataMigration> orgListPG2(String string) {
		return dao.orgListPG2();
	}


	public void fileMovePG(Map<String, Object> orgMap, int manage_idx) {

		String fileName = String.valueOf(orgMap.get("REAL_FILE_NAME"));
		String fileName2 = String.valueOf(orgMap.get("FILE_NAME"));


		File sourceFile = new File("D:\\develop_tool\\board\\" + fileName);

		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/");// 대상폴더


		if (!targetLocation.exists()) {
			targetLocation.mkdir();
		}

		try {
			FileUtils.copyFileToDirectory(sourceFile, targetLocation);
			int indexSlash = fileName.indexOf("/");

			if (indexSlash > -1) {
				fileName = fileName.substring(indexSlash+1);
			}
			File targetFile =  new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName);// 대상폴더
			File targetLocationRename = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/" + fileName2);// 대상폴더
			targetFile.renameTo(targetLocationRename);
		} catch (IOException e) {
			e.printStackTrace();
		}

		File thumbFile = new File("D:\\develop_tool\\board\\Thum_" + String.valueOf(orgMap.get("REAL_FILE_NAME")));

		if (thumbFile.exists()) {
			targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

			if (!targetLocation.exists()) {
				targetLocation.mkdir();
			}

			try {
				FileUtils.copyFileToDirectory(thumbFile, targetLocation);
			} catch (IOException e) {
				e.printStackTrace();
			}

			File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/Thum_" + fileName);// 이동된 섬네일
			File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

			newThumbFile.renameTo(renameThumbFile);
		} else {
			String ext = "jpg|bmp|gif|png|jpeg";
			String extname = String.valueOf(orgMap.get("FILE_EXT")).replace(".", "");
			if (ext.indexOf(extname) > -1) {
				thumbFile = new File("D:\\develop_tool\\board\\" + String.valueOf(orgMap.get("REAL_FILE_NAME")));

				targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/");// 게시판번호

				if (!targetLocation.exists()) {
					targetLocation.mkdir();
				}

				try {
					FileUtils.copyFileToDirectory(thumbFile, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}

				File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName);// 이동된 섬네일
				File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + orgMap.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

				newThumbFile.renameTo(renameThumbFile);
			}
		}



	}

	@DataSource(DataSourceType.SLAVE1)
	public List<DataMigration> orgGbccsList(int parseInt) {
		return dao.orgGbccsList(parseInt);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getGbccsFileData(DataMigration dm) {
		return dao.getGbccsFileData(dm);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getGbccsCommentData(DataMigration orgMap) {
		return dao.getGbccsCommentData(orgMap);
	}

	public void fileMoveGbccs(Map<String, Object> map2, int manager_seq, int manage_idx) {
		String fileName = String.valueOf(map2.get("RENAME_FILE_NAME"));
		String fileName2 = String.valueOf(map2.get("FILE_NAME"));
		String path = String.valueOf(map2.get("PATH"));


//		File sourceFile = new File("D:\\develop_tool\\board\\" + fileName);
		File sourceFile = new File("D:\\develop_tool\\uploadFiles\\commBoard\\" + path + "\\" + fileName);

		File targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/");// 대상폴더


		if (!targetLocation.exists()) {
			targetLocation.mkdir();
		}

		try {
			FileUtils.copyFileToDirectory(sourceFile, targetLocation);
			int indexSlash = fileName.indexOf("/");

			if (indexSlash > -1) {
				fileName = fileName.substring(indexSlash+1);
			}
			File targetFile =  new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/" + fileName);// 대상폴더
			File targetLocationRename = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/" + fileName2);// 대상폴더
			targetFile.renameTo(targetLocationRename);
		} catch (IOException e) {
//			e.printStackTrace();
		}

		String name = fileName.substring(0, fileName.indexOf("."));

		File thumbFile = new File("D:\\develop_tool\\uploadFiles\\commBoard\\" + path + "\\" + name + "_thumb_middle." + String.valueOf(map2.get("FILE_EXT")));

		if (thumbFile.exists()) {
			targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/");// 게시판번호

			if (!targetLocation.exists()) {
				targetLocation.mkdir();
			}

			try {
				FileUtils.copyFileToDirectory(thumbFile, targetLocation);
			} catch (IOException e) {
//				e.printStackTrace();
			}

			File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/Thum_" + fileName);// 이동된 섬네일
			File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

			newThumbFile.renameTo(renameThumbFile);
		} else {
			String ext = "jpg|bmp|gif|png|jpeg";
			String extname = String.valueOf(map2.get("FILE_EXT")).replace(".", "");
			if (ext.indexOf(extname) > -1) {
				thumbFile = new File("D:\\develop_tool\\uploadFiles\\commBoard\\" + path + "\\" + String.valueOf(map2.get("rename_file_name")));

				targetLocation = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/");// 게시판번호

				if (!targetLocation.exists()) {
					targetLocation.mkdir();
				}

				try {
					FileUtils.copyFileToDirectory(thumbFile, targetLocation);
				} catch (IOException e) {
					e.printStackTrace();
				}

				File newThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/" + fileName);// 이동된 섬네일
				File renameThumbFile = new File(boardStorage.getRootPath() + "/" + manage_idx + "/" + map2.get("board_idx") + "/thumb/" + fileName2);// 이동된 섬네일

				newThumbFile.renameTo(renameThumbFile);
			}
		}
	}

	/**
	 * @author whalesoft YONGJU 2019. 10. 26.
	 * @return
	 */
	public List<Map<String, Object>> getTableMap() {
		return dao.getTableMap();
	}

	/**
	 * @author whalesoft YONGJU 2019. 10. 26.
	 * @param object
	 * @return
	 */
	public List<Map<String, Object>> getColumns(Map<String, Object> a) {
		return dao.getColumns(a);
	}

	/**
	 * @author whalesoft YONGJU 2019. 10. 26.
	 * @param outputStream
	 * @param request
	 */
	public void table(OutputStream outputStream, HttpServletRequest request) throws Exception {
		String sampleFilePath = request.getSession().getServletContext().getRealPath("/") + "/resources/module/teacher/table.xls";
		Workbook workbook = null;

		List<Map<String, Object>> map = getTableMap();

		for (int i = 0; i < map.size(); i++) {
			Map<String, Object> a = map.get(i);
			a.put("data", getColumns(a));
		}


//		teacher = dao.getTeacherOne(teacher);
//		teacher.setCert_seq_num(dao.getCertSeq());
//		List<Teacher> historyList = dao.getHistoryList(teacher);
//
//		int limitRowCount = 13;
//		if ( historyList.size() > limitRowCount ) {
//			while ( historyList.size() != limitRowCount ) {
//				historyList.remove(historyList.remove(0));
//			}
//		}
//		else if ( historyList.size() < limitRowCount ) {
//			while ( historyList.size() != limitRowCount ) {
//				historyList.add(new Teacher());
//			}
//		}
//
//		int sum_total_time = 0;
//		for ( Teacher one : historyList ) {
//			sum_total_time = sum_total_time + one.getTotal_time();
//		}
//		teacher.setSum_total_time(sum_total_time);
//
//		SimpleDateFormat sfYear = new SimpleDateFormat("yyyy-MM-dd");
//
//		Date now = new Date();
//		String[] nows = sfYear.format(now).split("-");

		Map<String, Object> dataMap = new HashMap<String, Object>();
//		dataMap.put("curYear", nows[0]);
//		dataMap.put("curMonth", nows[1]);
//		dataMap.put("curDay", nows[2]);
//		dataMap.put("teacher", teacher);
		dataMap.put("tableList", map);
//		dataMap.put("homepageName", teacher.getHomepage_name());
		workbook = new XLSTransformer().transformXLS(new BufferedInputStream(new FileInputStream(new File(sampleFilePath))), dataMap);

		workbook.write(outputStream);
	}
}
