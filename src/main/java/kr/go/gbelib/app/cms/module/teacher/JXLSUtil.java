package kr.go.gbelib.app.cms.module.teacher;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;

public class JXLSUtil {

	private File templateFile;
	private InputStream is;
	
	public JXLSUtil(String templatePath) {
		// 템플릿 파일을 읽어와 is 생성
		templateFile = new File(templatePath);
		try {
			is = new BufferedInputStream(new FileInputStream(templateFile));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 템플릿 파일에 Data 쓰기
	 * @param Map (데이터파일)
	 * @return Workbook
	 */
	public Workbook getModifyWorkBook(Map<String, Object> dataMap) {
		XLSTransformer transfomer = new XLSTransformer();
		Workbook result = null;
		try {
			result =  transfomer.transformXLS(is, dataMap);
		} catch (ParsePropertyException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 파일 다운로드
	 * @param workbook
	 * @param fileName
	 * @param response
	 */
	public static void DownLoadExel(Workbook workbook, String fileName, HttpServletResponse response) {
		OutputStream os = null;
		try {
			os = response.getOutputStream();
			response.setHeader("Content-Disposition", "attachment; fileName=\""
					+ new String(fileName.toString().getBytes("euc-kr"), "8859_1")
					+ "\"; charset=\"UTF-8\";");
			response.setContentType("application/download");
			
			workbook.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				try {
					os.flush();
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public File getTemplateFile() {
		return templateFile;
	}

	public void setTemplateFile(File templateFile) {
		this.templateFile = templateFile;
	}

	public InputStream getIs() {
		return is;
	}

	public void setIs(InputStream is) {
		this.is = is;
	}
}
