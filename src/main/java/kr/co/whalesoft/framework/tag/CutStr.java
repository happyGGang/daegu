package kr.co.whalesoft.framework.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class CutStr extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private int 		cutNum;
	private String	inStr;
	private boolean addSuffix = true;
	
	@Override
	public int doEndTag() throws JspException {
		
		try {
			String suffix = ".."; 
			String result = "";
			byte[] by = inStr.getBytes(); 
			
			if( by.length > cutNum ) {
				int count = 0; 
					for(int i = 0; i < cutNum; i++) { 
						if((by[i] & 0x80) == 0x80) count++; 
					} 
					if((by[cutNum - 1] & 0x80) == 0x80 && (count % 3) == 1) cutNum--;
					result = new String(by, 0, cutNum);
					result = result.substring(0 , result.length()-1);
					if (addSuffix) {
						result = result + suffix;
					}
			} else {
				result = inStr;
			}
		
			pageContext.getOut().println(result);
		} catch (IOException e) {
			throw new JspException( e );
		}
		return EVAL_PAGE;
	} 
	
	public int getCutNum() {
		return cutNum;
	}
	
	public void setCutNum(int cutNum) {
		this.cutNum = cutNum;
	}

	public String getInStr() {
		return inStr;
	}

	public void setInStr(String inStr) {
		this.inStr = inStr;
	}

	public boolean isAddSuffix() {
		return addSuffix;
	}

	public void setAddSuffix(boolean addSuffix) {
		this.addSuffix = addSuffix;
	}

}