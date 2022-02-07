package kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class WalkingThruSettingService extends BaseService {
	
	@Autowired 
	WalkingThruSettingDao dao;

	@Autowired
	private TermsService termsService;

	public List<WalkingThruSetting> getWalkingThruSettingList(WalkingThruSetting walkingThruSetting) {
		return dao.getWalkingThruSettingList(walkingThruSetting);
	}
	
	public List<Terms> getWalkingThruSettingTerms(String homepage_id) {
		Terms terms = new Terms();
		terms.setHomepage_id(homepage_id);

		List<Terms> termList = termsService.getTermsList(terms);
		List<Terms> walkingThruTermList = new ArrayList<Terms>();

		for(Terms item : termList) {
			if(item.getTerms_type().equals("130")) {
				walkingThruTermList.add(item);
			}
		}

		return walkingThruTermList;
	}

	public WalkingThruSetting getWalkingThruSettingOne(String homepage_id) {
		return dao.getWalkingThruSettingOne(homepage_id);
	}

	public int modifyWalkingThruSetting(WalkingThruSetting walkingThruSetting) {
		return dao.modifyWalkingThruSetting(walkingThruSetting);
	}

	public int checkReserveTime(WalkingThruSetting walkingThruSetting) {
		return dao.checkReserveTime(walkingThruSetting);
	}
}
