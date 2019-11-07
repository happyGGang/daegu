package kr.co.whalesoft.framework.file;

/**
 * 금지된 확장자의 파일을 업로드할 때 발생하는 오류
 * 
 */
public class ForbiddenExtensionException extends FileAccessException {
	
	private static final long serialVersionUID = 1L;

	/**
	 * ForbiddenExtensionException 생성한다.
	 */
	public ForbiddenExtensionException() {
		super( "업로드가 금지된 확장자입니다.", null );
	}
}
