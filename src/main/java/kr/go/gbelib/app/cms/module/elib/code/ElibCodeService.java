package kr.go.gbelib.app.cms.module.elib.code;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ElibCodeService extends BaseService {

	@Autowired
	private ElibCodeDao dao;
	
	public List<ElibCode> getProviders() {
		return dao.getProviders();
	}
	
	public List<ElibCode> getCompListCms(ElibCode code) {
		return dao.getCompListCms(code);
	}
	
	public List<ElibCode> getCompWithCntListCms(ElibCode code) {
		return dao.getCompWithCntListCms(code);
	}
	
	public List<ElibCode> getCompList(ElibCode code) {
		return dao.getCompList(code);
	}
	
	public List<ElibCode> getCompWithCntList(ElibCode code) {
		return dao.getCompWithCntList(code);
	}
	
	public List<ElibCode> getLibraryList() {
		return dao.getLibraryList();
	}
	
	public Map<String, String> getLibraryMap() {
		Map<String, String> map = new HashMap<String, String>();
		List<ElibCode> list = dao.getLibraryList();
		
		for(ElibCode code: list) {
			String library_code = code.getLibrary_code();
			String library_name = code.getLibrary_name();
			if(StringUtils.equals(library_code, "9999999")) {
				map.put(library_code, "통합");
			} else {
				map.put(library_code, library_name);
			}
		}
		
		return map;
	}
	
	public Map<String, String> getCompMap() {
		Map<String, String> map = new HashMap<String, String>();
		List<ElibCode> list = dao.getCompList(new ElibCode());
		
		for(ElibCode code: list) {
			map.put(code.getCom_code(), code.getComp_name());
		}
		
		return map;
	}
	
	public int addComp(ElibCode code) {
		return dao.addComp(code);
	}
	
	public int modifyComp(ElibCode code) {
		return dao.modifyComp(code);
	}
	
	public int deleteComp(ElibCode code) {
		return dao.deleteComp(code);
	}
	
	public int getCompListCnt(ElibCode code) {
		return dao.getCompListCnt(code);
	}
	
	public ElibCode getComp(ElibCode code) {
		return dao.getComp(code);
	}
	
}
