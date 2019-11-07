package kr.go.gbelib.app.cms.module.lockerPre;

import java.util.List;

public interface LockerPreDao {

	public List<LockerPre> getLockerPreAll(LockerPre lockerPre);

	public List<LockerPre> getLockerPre(LockerPre lockerPre);

	public int getLockerPreCount(LockerPre lockerPre);

	public int getLockerPrePreCount(LockerPre lockerPre);

	public LockerPre getLockerPreOne(LockerPre lockerPre);

	public int addLockerPre(LockerPre LockerPre);

	public int lockerPreIdx(LockerPre lockerPre);

	public int modifyLocekrPre(LockerPre lockerPre);

	public int deleteLockerPre(LockerPre lockerPre);

	public int deleteAllLockerPre(LockerPre lockerPre);
	
	public int deleteLockerReq(LockerPre lockerPre);

	public int getMaxIdxOfLockerPre(LockerPre lockerPre);

	public int deleteFile(LockerPre lockerPre);
}
