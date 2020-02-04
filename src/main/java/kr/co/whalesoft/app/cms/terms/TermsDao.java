package kr.co.whalesoft.app.cms.terms;

import java.util.List;

public interface TermsDao {
	
	public List<Terms> getTermsList(Terms terms);
	
	public int getTermsListCount(Terms terms);
	
	public Terms getTermsOne(Terms terms);
	
	public int addTerms(Terms terms);
	
	public int modifyTerms(Terms terms);
	
	public int deleteTerms(Terms terms);

	public List<Terms> getTermsListInModule(Terms terms);

	public List<Terms> getTermsListNotInModule(Terms terms);

	public List<Terms> getTermsListInBoard(Terms terms);
} 
