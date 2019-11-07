package kr.go.gbelib.app.module.sdi;

import java.util.List;

public interface SdiDao {
	
	public List<Sdi> getSdi(Sdi sdi);
	
	public Sdi getSdiOne(Sdi sdi);
	
	public int insertSdi(Sdi sdi);
	
	public int modifySdi(Sdi sdi);
	
	public int deleteSdi(Sdi sdi);

}
