package kr.co.whalesoft.app.cms.terms;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TermsService extends BaseService {
	
	@Autowired
	private TermsDao dao;
	
	public List<Terms> getTermsList(Terms terms) {
		return dao.getTermsList(terms);
	}
	
	public int getTermsListCount(Terms terms) {
		return dao.getTermsListCount(terms);
	}
	
	public Terms getTermsOne(Terms terms) {
		return dao.getTermsOne(terms);
	}
	
	public int addTerms(Terms terms) {
		return dao.addTerms(terms);
	}
	
	public int modifyTerms(Terms terms) {
		return dao.modifyTerms(terms);
	}
	
	public int deleteTerms(Terms terms) {
		return dao.deleteTerms(terms);
	}

	public List<Terms> getTermsListInModule(Terms terms) {
		return dao.getTermsListInModule(terms);
	}
	
	public List<Terms> getTermsListNotInModule(Terms terms) {
		return dao.getTermsListNotInModule(terms);
	}
}
