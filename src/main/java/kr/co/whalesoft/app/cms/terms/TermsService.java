package kr.co.whalesoft.app.cms.terms;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.teach.Teach;

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

	@WorkingLogger(comment="이용약관 관리 1건 추가")
	public int addTerms(Terms terms) {
		return dao.addTerms(terms);
	}

	@WorkingLogger(comment="이용약관 관리 1건 수정")
	public int modifyTerms(Terms terms) {
		return dao.modifyTerms(terms);
	}

	@WorkingLogger(comment="이용약관 관리 1건 삭제")
	public int deleteTerms(Terms terms) {
		return dao.deleteTerms(terms);
	}

	public List<Terms> getTermsListInModule(Terms terms) {
		return dao.getTermsListInModule(terms);
	}
	
	public List<Terms> getTermsListNotInModule(Terms terms) {
		return dao.getTermsListNotInModule(terms);
	}

	public List<Terms> getTermsListInBoard(Terms terms) {
		return dao.getTermsListInBoard(terms);
	}
	
	public List<Terms> getTermsListByTeach(Teach teach) {
		return dao.getTermsListByTeach(teach);
	}

}
