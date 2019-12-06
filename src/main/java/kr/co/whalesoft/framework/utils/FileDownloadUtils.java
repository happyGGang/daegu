
package kr.co.whalesoft.framework.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * 다운로드
 *
 * @author 김민수
 */
public class FileDownloadUtils {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private OutputStream out;

	/**
	 * Download를 생성한다.
	 *
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param downloadFileName 다운로드 시 사용되는 파일명
	 * @throws IOException
	 */
	public FileDownloadUtils( HttpServletRequest request, HttpServletResponse response, String downloadFileName ) throws IOException {
		this.request = request;
		this.response = response;

		out = response.getOutputStream();

		initResponse( downloadFileName );
	}

	private void initResponse( String fileName ) throws UnsupportedEncodingException {

		StringBuffer cd = new StringBuffer();

		// 개발환경의 경우 파일명의 인코딩 변환이 필요하다. 운영환경은 변환을 하지 않아야 한다.
		if(StringUtils.equals(System.getProperty("spring.profiles.active"), "localServer")) fileName = new String( fileName.getBytes( "EUC-KR" ), "ISO-8859-1" );

		// 다운로드 할 때의 기본 파일명 지정
		cd.append( "filename=\"" );
		cd.append( fileName );
		cd.append( "\";" );

		if ( request.getHeader( "User-Agent" ).indexOf( "MSIE 5.5" ) == -1 )
			cd.insert( 0, "attachment; " );

		response.reset();
		response.setContentType( "application/download" );
		response.setHeader( "Content-Disposition", cd.toString() );
	}

	private void setContentLength( int contentLength ) {
		response.setContentLength( contentLength );
	}

	/**
	 * 파일을 다운로드 한다.
	 *
	 * @param file 파일
	 * @throws IOException
	 */
	public void downloadFile( MultipartFile file ) throws IOException {

		// 파일이 없으면
		if ( file == null || file.getSize() == 0 ) {
			//JavaScript.alert( "파일이 존재하지 않습니다." ).execute( request, response );
			return;
		}

		setContentLength( (int) file.getSize() );
		downloadInputStream( file.getInputStream() );
	}

	/**
	 * InputStream을 읽어서 다운로드한다.
	 *
	 * @param in InputStream
	 * @throws IOException
	 */
	public void downloadInputStream( InputStream in ) throws IOException {

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try {
			bis = new BufferedInputStream( in );
			bos = new BufferedOutputStream( response.getOutputStream() );

			int bytesRead = 0;
			byte[] buffer = new byte[ 10240 ];

			while ( ( bytesRead = bis.read( buffer ) ) != -1 )
				bos.write( buffer, 0, bytesRead );
		}
		finally {
			if ( bis != null ) bis.close();
			if ( bos != null ) bos.close();
		}
	}

	/**
	 * Response의 OutputStream을 구한다.
	 *
	 * @return Response의 OutputStream
	 */
	public OutputStream getOutputStream() {
		return out;
	}

	/**
	 * Response의 OutputStream을 닫는다.
	 *
	 * @throws IOException
	 */
	public void close() throws IOException {
		if ( out != null ) out.close();
	}
}
