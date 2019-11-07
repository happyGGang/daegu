package kr.co.whalesoft.framework.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;


/**
 * 파일을 보관하는 저장소
 * 
 */
public class FileStorage implements ServletContextAware {
	
	private static final String[] FORBIDDEN_EXTS = new String[] { ".jsp", ".exe", ".vbs", ".jspx" };
	private ServletContext		context;
	private String					rootPath;
	private String					contextPath;
	private boolean					basedOnServletContext = false;
	private File						storage;

	public void setServletContext( ServletContext context ) {
		this.context = context;
	}
	
	@Required
	public String getRootPath() {
		return rootPath;
	}

	public void setRootPath(String rootPath) {
		this.rootPath = rootPath;
	}
	
	/**
	 * 서블릿 컨텍스트 기반 경로인지를 지정한다.
	 * true로 지정하면 저장소의 경로는 서블릿 컨텍스트 아래로 지정된다.
	 * 
	 * @param basedOnServletContext 서블릿 컨텍스트 기반 경로 여부
	 */
	public void setBasedOnServletContext( boolean basedOnServletContext ) {
		this.basedOnServletContext = basedOnServletContext;
	}
	
	@PostConstruct
	public void init() {
		contextPath = rootPath;
		if ( basedOnServletContext ) rootPath = context.getRealPath( rootPath );
		mkdir(rootPath);
	}
	
	/**
	 * 저장소의 절대경로를 구한다.
	 * 
	 * @return 저장소의 절대경로
	 */
	public String getAbsolutePath() {
		return storage.getAbsolutePath();
	}
	
	/**
	 * 저장소 내의 File을 생성한다.
	 * 
	 * @param fileName 파일명
	 * @return File
	 */
	private File createFile( String fileName , String filePath ) {
		return new File( rootPath + "/" + filePath + File.separator + fileName );
	}
	
	/**
	 * 저장소에 파일을 추가한다.
	 * 
	 * @param file 추가할 파일
	 * @param fileName 저장할 파일명, 같은 이름의 파일이 이미 존재하면 이름이 바뀌므로 반드시 이 이름으로 저장되지는 않는다.
	 * @return 저장된 파일명
	 */
	public File addFile( MultipartFile file , String fileName, String filePath ) {
		
		if ( isForbiddenFile( file.getOriginalFilename() ) ) throw new ForbiddenExtensionException();
		if ( file == null || file.getSize() == 0 ) return null;
		
		File f = createUniqueFile( fileName , filePath);
		
		try {
			file.transferTo( f );
			
			return f;
		}
		catch ( IOException e ) {
			throw new FileAccessException( "저장소에 파일을 추가할 수 없습니다.", e );
		}
	}
		
	private File createUniqueFile(String fileName , String filePath) {
		mkdir(filePath);
		
		File f = createFile( fileName , filePath );
		
		String extension = "";
		
		// 파일명에 .가 포함되어 있는 경우는 확장자를 따로 분리한다.
		int pos = fileName.lastIndexOf( "." );
		if ( pos > -1 ) {
			extension = fileName.substring( pos );		// .을 포함한 확장자
			fileName = fileName.substring( 0, pos );	// 확장자를 제외한 파일명
		}
		
		// 파일이 존재하면 이름을 바꾼다.
		for ( int i = 1; f.exists(); i++ )
			f = createFile( fileName + "_" + i + extension , filePath );
		
		return f;
	}
	
	/**
	 * 저장소 내의 파일을 삭제한다.
	 * 
	 * @param fileName 파일명
	 */
	public void deleteFile(String fileName, String filePath) {
		createFile(fileName, filePath).delete();
	}
	
	public void mkdir(String filePath) {
		File directory = new File(rootPath + "/" + filePath);
		if(!directory.exists()) {
			directory.mkdirs();
		}
	}
	
	/**
	 * 저장소 내의 폴더를 삭제한다.
	 * @param dir
	 * @throws IOException 
	 * @throws IOException
	 */
	public void deleteFolder(String dir) throws IOException {
		FileUtils.deleteDirectory(new File(rootPath + "/" + dir));
	}
	
	/**
	 * 업로드 금지된 파일인지 검사한다.
	 * 
	 * @param fileName 파일명
	 * @return 금지된 파일이면 true, 아니면 false
	 */
	private boolean isForbiddenFile( String fileName ) {
		
		if ( fileName == null ) return false;
		
		for ( String ext : FORBIDDEN_EXTS )
			if ( fileName.toLowerCase().endsWith( ext ) ) return true;
		
		return false;
	}
	
	public void copyDirectory(File sourceLocation , File targetLocation) throws IOException {
        
        //소스가 디렉토리인 경우
        // --> 해당 디렉토리의 모든 파일을 타겟 디렉토리에 복사
		if (sourceLocation.isDirectory()) {
	        if (!targetLocation.exists()) {
	            targetLocation.mkdir();
	        }
	        
	        String[] children = sourceLocation.list();
	        for (int i=0; i<children.length; i++) {
	            copyDirectory(new File(sourceLocation, children[i]), new File(targetLocation, children[i]));
	        }
	    } else { // 소스가 파일 인경우 --> 해당 파일을 타겟 디렉토리로 이동
	        InputStream in = new FileInputStream(sourceLocation);
	        OutputStream out = new FileOutputStream(targetLocation);
	        
	        // Copy the bits from instream to outstream
	        byte[] buf = new byte[1024];
	        int len;
	        while ((len = in.read(buf)) > 0) {
	            out.write(buf, 0, len);
	        }
	        in.close();
	        out.close();
		}
	}


	public File getStorage() {
		return storage;
	}

	public void setStorage(File storage) {
		this.storage = storage;
	}

	public boolean isBasedOnServletContext() {
		return basedOnServletContext;
	}

	public String getContextPath() {
		return contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
	
	public String generateUniqueFileName(String path) {
		String filename = "";
		String datetime = new SimpleDateFormat("yyyyMMddHHmm").format(new Date());
		String rndchars = RandomStringUtils.randomAlphanumeric(7);
		do {
			filename = datetime + "_" + rndchars;
		} while(new File(path + filename).exists());

		return filename;
	}
	
}