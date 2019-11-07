package kr.co.whalesoft.framework.file;

import java.io.IOException;

import org.springframework.dao.UncategorizedDataAccessException;

/**
 * 파일에 접근할 때 발생하는 오류
 * 
 */
public class FileAccessException extends UncategorizedDataAccessException {
	
	private static final long serialVersionUID = 1L;

	/**
	 * FileAccessException을 생성한다.
	 * 
	 * @param msg 오류 메시지
	 * @param e IOException
	 */
	public FileAccessException( String msg, IOException e ) {
		super( msg, e );
	}
}
