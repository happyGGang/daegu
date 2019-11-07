package kr.co.whalesoft.app.board.boardFile;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class BoardFileTag extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private String file_ext;
	
	private final String[] imgFileExtArray = {".jpeg", ".jpg", ".bmp", ".gif", ".png"};
	private final String[] xlsFileExtArray = {".xls", ".xlsx"};

	@Override
	public int doEndTag() throws JspException {
		
		boolean fileCheckComplete = false;
		String iconExtName = "file";
		file_ext = file_ext.toLowerCase();

		if(!fileCheckComplete) {
			if(file_ext != null && !file_ext.equals("")) {
				for(String imgFileExt : imgFileExtArray) {
					if(file_ext.equals(imgFileExt)) {
						iconExtName = "fa-file-image-o";
						fileCheckComplete = true;
						break;
					}
				}
			}
		}
		
		if(!fileCheckComplete) {
			if(file_ext != null && !file_ext.equals("")) {
				for(String imgFileExt : xlsFileExtArray) {
					if(file_ext.equals(imgFileExt)) {
						iconExtName = "fa-file-excel-o";
						fileCheckComplete = true;
						break;
					}
				}
			}
		}
		
		if(!fileCheckComplete) {
			if(file_ext != null && !file_ext.equals("")) {
				if(file_ext.equals(".doc")) {
					iconExtName = "fa-file-word-o";
				} else if(file_ext.equals(".hwp")) {
					iconExtName = "fa-file-o";
				} else if(file_ext.equals(".pdf")) {
					iconExtName = "fa-file-pdf-o";
				} else if(file_ext.equals(".zip")) {
					iconExtName = "fa-file-zip-o";
				} else {
					iconExtName = "fa-file-o";
				}
				
				fileCheckComplete = true;
			}
		}
		
		try {
			pageContext.getOut().println(iconExtName);
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return EVAL_PAGE;
	}

	public String getFile_ext() {
		return file_ext;
	}

	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
}
