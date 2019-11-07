package kr.go.gbelib.app.module.sdi;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SdiService extends BaseService {
	
	@Autowired
	private SdiDao dao;
	
	public List<Sdi> getSdi(Sdi sdi) {
		return dao.getSdi(sdi);
	}
	
	public Sdi getSdiOne(Sdi sdi) {
		return dao.getSdiOne(sdi);
	}
	
	public int insertSdi(Sdi sdi) {
		return dao.insertSdi(sdi);
	}
	
	public int modifySdi(Sdi sdi) {
		return dao.modifySdi(sdi);
	}
	
	public int deleteSdi(Sdi sdi) {
		return dao.deleteSdi(sdi);
	}

}
