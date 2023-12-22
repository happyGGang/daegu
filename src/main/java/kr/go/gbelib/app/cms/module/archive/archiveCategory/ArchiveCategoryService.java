package kr.go.gbelib.app.cms.module.archive.archiveCategory;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.archive.Archive;
import kr.go.gbelib.app.cms.module.archive.ArchiveService;

@Service
public class ArchiveCategoryService extends BaseService {

	@Autowired
	private ArchiveCategoryDao dao;
	
	@Autowired
	private ArchiveService archiveService;
	
	public List<ArchiveCategory> getLargeCategoryList() {
		return dao.getLargeCategoryList();
	}

	public List<ArchiveCategory> getMidCategoryList(ArchiveCategory archiveCategory) {
		return dao.getMidCategoryList(archiveCategory);
	}

	public List<ArchiveCategory> getSmallCategoryList(ArchiveCategory archiveCategory) {
		return dao.getSmallCategoryList(archiveCategory);
	}
	
	public int getLargeCategoryCnt(ArchiveCategory archiveCategory) {
		return dao.getLargeCategoryCnt(archiveCategory);
	}
	
	public int getMidCategoryCnt(ArchiveCategory archiveCategory) {
		return dao.getMidCategoryCnt(archiveCategory);
	}
	
	public int getSmallCategoryCnt(ArchiveCategory archiveCategory) {
		return dao.getSmallCategoryCnt(archiveCategory);
	}
	
//	public 
	
	public int dupCheck(ArchiveCategory archiveCategory) {
		if (StringUtils.equals(archiveCategory.getLarge_code(), "0")) {
			archiveCategory.setLarge_code(archiveCategory.getTempCode());
			archiveCategory.setMid_code("--");
			archiveCategory.setSmall_code("--");
		} else if (StringUtils.equals(archiveCategory.getMid_code(), "0")) {
			archiveCategory.setMid_code(archiveCategory.getTempCode());
			archiveCategory.setSmall_code("--");
		} else if (StringUtils.equals(archiveCategory.getSmall_code(), "0")) {
			archiveCategory.setSmall_code(archiveCategory.getTempCode());
		}
		
		//중복 카운트
		int dupCheck = dao.getCategoryInfo(archiveCategory);
		if (dupCheck > 0) {
			return 1;
		}
		//카테고리명 중복 카운트
		int dupCheck2 = dao.getCategoryInfoByName(archiveCategory);
		if (dupCheck2 > 0) {
			return 2;
		}
		
		return 0;
	}

	public int addArchiveCategory(ArchiveCategory archiveCategory) {
		if (StringUtils.equals(archiveCategory.getLarge_code(), "0")) {
			archiveCategory.setLarge_code(archiveCategory.getTempCode());
			archiveCategory.setMid_code("--");
			archiveCategory.setSmall_code("--");
		} else if (StringUtils.equals(archiveCategory.getMid_code(), "0")) {
			archiveCategory.setMid_code(archiveCategory.getTempCode());
			archiveCategory.setSmall_code("--");
		} else if (StringUtils.equals(archiveCategory.getSmall_code(), "0")) {
			archiveCategory.setSmall_code(archiveCategory.getTempCode());
		}

		return dao.addArchiveCategory(archiveCategory);
	}
	
	public int modifyArchiveCategory(ArchiveCategory archiveCategory) {
//		int dupCheck = dao.getCategoryInfo(archiveCategory);
//		if (dupCheck > 0) {
//			return dupCheck;
//		}
		return dao.modifyArchiveCategory(archiveCategory);
	}

	@Transactional
	public int deleteArchiveCategory(ArchiveCategory archiveCategory) {
		//pk 위배에 의해 delete_yn = 'Y'인 것 있으면 실제 삭제
		if (checkAlreadyDeleted(archiveCategory) > 0) {
			realDeleteArchiveCategory(archiveCategory);
		}
		return dao.deleteArchiveCategory(archiveCategory);
	}

	private int realDeleteArchiveCategory(ArchiveCategory archiveCategory) {
		return dao.realDeleteArchiveCategory(archiveCategory);
	}

	@Transactional
	public int saveCategoryList(ArchiveCategory[] archiveCategoryList, String cud_id) {
		int result = 0;

		for(ArchiveCategory code: archiveCategoryList) {
//			if(getCategoryInfo(code) == null) {
//				throw new RuntimeException();
//			}
			code.setCud_id(cud_id);
			result += dao.modifyPrintSeq(code);
		}

		return result;
	}

	public int childCheck(ArchiveCategory archiveCategory) {
		int childCheck = 0;
		
		if (StringUtils.equals(archiveCategory.getMid_code(), "--")) {
			ArchiveCategory one = new ArchiveCategory();
			one.setLarge_code(archiveCategory.getLarge_code());
			childCheck = dao.childCheck(one);
			return childCheck;
		}
		
		if (StringUtils.equals(archiveCategory.getSmall_code(), "--")) {
			ArchiveCategory one = new ArchiveCategory();
			one.setLarge_code(archiveCategory.getLarge_code());
			one.setMid_code(archiveCategory.getMid_code());
			childCheck = dao.childCheck(one);
			return childCheck;
		}
		
		return childCheck;
	}
	
	public int checkAlreadyDeleted(ArchiveCategory archiveCategory) {
		return dao.checkAlreadyDeleted(archiveCategory);
	}

	public String getLargeCategoryCodeId(ArchiveCategory archiveCategory) {
		return dao.getLargeCategoryCodeId(archiveCategory);
	}

	public String getMidCategoryCodeId(ArchiveCategory archiveCategory) {
		return dao.getMidCategoryCodeId(archiveCategory);
	}

	public String getSmallCategoryCodeId(ArchiveCategory archiveCategory) {
		return dao.getSmallCategoryCodeId(archiveCategory);
	}

	public int archiveDataCheck(ArchiveCategory archiveCategory) {
		Archive archive = new Archive();
		archive.setLarge_code(archiveCategory.getLarge_code());
		archive.setMid_code(archiveCategory.getMid_code());
		archive.setSmall_code(archiveCategory.getSmall_code());
		return dao.archiveDataCheck(archive);
	}

	public String getLargeCategoryCodeName(ArchiveCategory archiveCategory) {
		return dao.getLargeCategoryCodeName(archiveCategory);
	}

	public String getMidCategoryCodeName(ArchiveCategory archiveCategory) {
		return dao.getMidCategoryCodeName(archiveCategory);
	}

	public String getSmallCategoryCodeName(ArchiveCategory archiveCategory) {
		return dao.getSmallCategoryCodeName(archiveCategory);
	}

}
