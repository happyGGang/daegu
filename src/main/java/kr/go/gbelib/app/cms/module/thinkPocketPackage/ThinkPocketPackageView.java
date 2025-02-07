package kr.go.gbelib.app.cms.module.thinkPocketPackage;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import org.springframework.web.servlet.view.document.AbstractJExcelView;

public class ThinkPocketPackageView extends AbstractJExcelView {
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, WritableWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings ("unchecked")
		List<ThinkPocketPackage> thinkPocketPackageList = (List<ThinkPocketPackage>) model.get("thinkPocketPackageList");
		ThinkPocketPackage thinkPocketPackage = (ThinkPocketPackage)model.get("thinkPocketPackage");
		
		String editMode = thinkPocketPackage.getEditMode();
		
		String name = "";
		if(editMode.equals("thinkPocketPackage")) {
			name = "책 꾸러미 리스트.xls";
		} else if(editMode.equals("thinkPocketPackageLoan")) {
			name = "책 꾸러미 대출신청.xls";
		}
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(name, request.getHeader("user-agent")));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("Application/Msexcel");

		new ThinkPocketPackageWorkbook().workbookForm(workbook, editMode, thinkPocketPackageList, request, response);
	}
}
