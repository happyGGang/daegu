package kr.go.gbelib.app.cms.module.teach.teachCode;

import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class TeachCodeService extends BaseService {

	@Autowired
	private TeachCodeDao dao;

	public List<TeachCode> getLargeCodeList() {
		return dao.getLargeCodeList();
	}
	
	public List<TeachCode> getMidCodeList(TeachCode teachCode) {
		return dao.getMidCodeList(teachCode);
	}
	
	public List<TeachCode> getSmallCodeList(TeachCode teachCode) {
		return dao.getSmallCodeList(teachCode);
	}

	public int addTeachCode(TeachCode teachCode) {
		if (StringUtils.equals(teachCode.getLarge_code(), "0")) {
			teachCode.setLarge_code(teachCode.getTempCode());
			teachCode.setMid_code("--");
			teachCode.setSmall_code("--");
		} else if (StringUtils.equals(teachCode.getMid_code(), "0")) {
			teachCode.setMid_code(teachCode.getTempCode());
			teachCode.setSmall_code("--");
		} else if (StringUtils.equals(teachCode.getSmall_code(), "0")) {
			teachCode.setSmall_code(teachCode.getTempCode());
		}
		
		//중복 카운트
		int dupCheck = dao.getCodeInfo(teachCode);
		if (dupCheck > 0) {
			return dupCheck;
		}
		
		return dao.addTeachCode(teachCode);
	}

	public int modifyTeachCode(TeachCode teachCode) {
		int dupCheck = dao.getCodeInfo(teachCode);
		if (dupCheck > 0) {
			return dupCheck;
		}
		return dao.modifyTeachCode(teachCode);
	}

	public int deleteTeachCode(TeachCode teachCode) {
		return dao.deleteTeachCode(teachCode);
	}

	@Transactional
	public int saveCodeList(TeachCode[] codeList, String cud_id) {
		int result = 0;
		
		for(TeachCode code: codeList) {
//			if(getCategoryInfo(code) == null) {
//				throw new RuntimeException();
//			}
			code.setCud_id(cud_id);
			result += dao.modifyPrintSeq(code);
		}
		
		return result;		
	}
	
}
