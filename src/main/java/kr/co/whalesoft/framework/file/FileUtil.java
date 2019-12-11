package kr.co.whalesoft.framework.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import kr.co.whalesoft.app.board.boardComment.boardCommentFile.BoardCommentFile;
import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.framework.utils.ImageUtils;

public class FileUtil {

	private static final String fileExtArray[] = {".jpeg", ".jpg", ".gif", ".bmp", ".png"};

	/**
	 * 파일 이동
	 * @param beforeFile
	 * @param afterFile
	 */
	public static void fileMove(String beforePath , String afterPath, String fileName) throws IOException {
		File beforeFile = new File(beforePath+"/"+fileName);
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
		}
 	}

	/**
	 * 폴더생성
	 * @param path
	 * @throws IOException
	 */
	public static void mkdir( String path ) throws IOException {
		File folder = new File( path );
		if( !folder.isDirectory() ) {

			/**
			 * 18. 중요한 자원에 대한 잘못된 권한 설정
			 * 시큐어 코딩 시정조치 - START
			 */
//			folder.setExecutable(false, true);
//			folder.setReadable(true);
//			folder.setWritable(false, true);
			/**
			 * 시큐어 코딩 시정조치 - END
			 */

			folder.mkdir();
		}
	}

	/**
	 * 게시판에서 사용되는 이미지 미리보기 생성(썸네일)
	 * @param path
	 * @param fileName
	 * @throws IOException
	 */
	public static boolean thumbImgMake(String path, String fileName, String fileExt, int width, int height) throws IOException {
		boolean imageFile = false;
		for(String fileExtTemp : fileExtArray) {
			if(fileExt.toLowerCase().equals(fileExtTemp)) {
				mkdir(path+"thumb/");
				ImageUtils.thumbMakeImg(path, fileName, width, height, 0);
				imageFile = true;
			}
		}
		return imageFile;
	}

	/**
	 * 필요없는 파일 삭제
	 * @param filePath
	 * @param fileName
	 * @throws IOException
	 */
	public static void noUseFileDelete(String filePath, String fileArray[]) throws IOException {
		File defaultfolder = new File( filePath );
		String children[] = defaultfolder.list();

		if((children != null && children.length > 0)) {
			for(int i=0; i<children.length; i++) {
				boolean exist = false;
				if(fileArray != null && fileArray.length > 0) {
					for(int j=0; j<fileArray.length; j++) {
						String fileName[] = fileArray[j].split("//");
						if(fileName != null && fileName.length > 4) {
							if(children[i].equals(fileName[1])) {
								exist = true;
								break;
							}
						}
					}
				}
				if(!exist) {
					File deleteFile = new File(filePath + children[i]);
					if(deleteFile.isFile()) {
						deleteFile.delete();
					}
				}
			}
		}
	}

	/**
	 * 필요없는 파일 삭제
	 * @param filePath
	 * @param boardFileList
	 * @throws IOException
	 */
	public static void noUseFileDelete( String filePath , List<BoardFile> boardFileList ) throws IOException {
		File defaultfolder = new File( filePath );
		String children[] = defaultfolder.list();
		BoardFile boardFile = null;

		if( (children!=null && children.length > 0) ) {
			for( int i=0;i<children.length;i++ ) {
				boolean exist = false;
				if( boardFileList!=null && boardFileList.size() > 0 ) {
					for( int j=0;j<boardFileList.size();j++ ) {
						boardFile = boardFileList.get( j );
						String fileName = boardFile.getServer_file_name();
						if( children[i].equals(fileName) ) {
							exist = true;
							break;
						}
					}
				}
				if( !exist ) {
					File deleteFile = new File( filePath+children[i] );
					if( deleteFile.isFile() ) {
						deleteFile.delete();
					}
				}
			}
		}
	}

	/**
	 * 필요없는 파일 삭제
	 * @param filePath
	 * @param boardFileList
	 * @throws IOException
	 */
	public static void noUseCommentFileDelete( String filePath , List<BoardCommentFile> boardCommentFileList ) throws IOException {
		File defaultfolder = new File( filePath );
		String children[] = defaultfolder.list();
		BoardCommentFile boardCommentFile = null;

		if( (children!=null && children.length > 0) ) {
			for( int i=0;i<children.length;i++ ) {
				boolean exist = false;
				if( boardCommentFileList!=null && boardCommentFileList.size() > 0 ) {
					for( int j=0;j<boardCommentFileList.size();j++ ) {
						boardCommentFile = boardCommentFileList.get( j );
						String fileName = boardCommentFile.getReal_file_name();
						if( children[i].equals(fileName) ) {
							exist = true;
							break;
						}
					}
				}
				if( !exist ) {
					File deleteFile = new File( filePath+children[i] );
					if( deleteFile.isFile() ) {
						deleteFile.delete();
					}
				}
			}
		}
	}


	/**
	 * 특정 디렉토리의 하위 파일(디렉토리) 목록을 Map 으로 반환한다.
	 */
	public static Map<String , String> childSearchFile ( String defaultPath ) throws IOException {
		File parentFolder = new File( defaultPath );
		String childFile[] = parentFolder.list();
		Map <String , String> saveFileMap = new HashMap<String , String>();

		if( childFile!=null && childFile.length > 0 ) {
			for( int i=0;i<childFile.length;i++ ) {
				saveFileMap.put( childFile[i] , childFile[i] );
			}
		}
		return saveFileMap;
	}

	/**
	 * 특정 디렉토리 하위 파일들의 총 사이즈를 반환한다.
	 * @param defaultPath
	 * @return
	 * @throws IOException
	 */
	public static Map<String , Long> childFileSize( String defaultPath ) throws IOException {
		File parentFolder = new File( defaultPath );
		File childFile[] = parentFolder.listFiles();
		Map <String , Long> saveFileMap = new HashMap<String , Long>();
		long totalFileSize = 0;
		long fileCount = 0;

		if( childFile!=null && childFile.length > 0 ) {
			for( int i=0;i<childFile.length;i++ ) {
				if( childFile[i].isFile() ) {
					totalFileSize += childFile[i].length();
					fileCount++;
				}
			}
		}
		saveFileMap.put( "totalFileSize" , totalFileSize );
		saveFileMap.put( "fileCount" , fileCount );

		return saveFileMap;
	}

}
