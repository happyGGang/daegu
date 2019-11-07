package kr.co.whalesoft.framework.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

/**
 * 파일을 나타낸다.
 * java.io.File의 대용
 * 
 */
public class MultipartFileImpl implements MultipartFile, Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private File file;
	
	/**
	 * MultipartFileImpl을 생성한다.
	 * 
	 * @param file File
	 */
	public MultipartFileImpl( File file ) {
		this.file = file;
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getBytes()
	 */
	public byte[] getBytes() throws IOException {
		// 필요없어서 구현하지 않음
		return null;
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getContentType()
	 */
	public String getContentType() {
		// 필요없어서 구현하지 않음
		return null;
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getInputStream()
	 */
	public InputStream getInputStream() throws IOException {
		return new FileInputStream( file );
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getName()
	 */
	public String getName() {
		return file.getName();
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getOriginalFilename()
	 */
	public String getOriginalFilename() {
		return getName();
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#getSize()
	 */
	public long getSize() {
		return file.length();
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#isEmpty()
	 */
	public boolean isEmpty() {
		return file.length() == 0;
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.multipart.MultipartFile#transferTo(java.io.File)
	 */
	public void transferTo( File file ) throws IOException, IllegalStateException {
		// 필요없어서 구현하지 않음
	}
}
