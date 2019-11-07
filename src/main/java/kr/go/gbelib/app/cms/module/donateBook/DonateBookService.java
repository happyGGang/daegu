package kr.go.gbelib.app.cms.module.donateBook;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DonateBookService extends BaseService {
	
	@Autowired
	private DonateBookDao dao;
	
	public List<DonateBook> getDonateBookListAll(DonateBook donateBook) {
		return dao.getDonateBookListAll(donateBook);
	}
	 
	public List<DonateBook> getDonateBookList(DonateBook donateBook) {
		return dao.getDonateBookList(donateBook);
	}
	
	public int getDonateBookListCount(DonateBook donateBook) {
		return dao.getDonateBookListCount(donateBook);
	}
	
	public DonateBook getDonateBookOne(DonateBook donateBook) {
		return dao.getDonateBookOne(donateBook);
	}
	
	public int addDonateBook(DonateBook donateBook) {
		return dao.addDonateBook(donateBook);
	}
	
	public int modifyDonateBook(DonateBook donateBook) {
		return dao.modifyDonateBook(donateBook);
	}
	
	public int deleteDonateBook(DonateBook donateBook) {
		return dao.deleteDonateBook(donateBook);
	}
}