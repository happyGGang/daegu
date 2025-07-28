package kr.go.gbelib.app.cms.module.blackListDetail;

import kr.go.gbelib.app.cms.module.blackList.BlackList;

import java.util.List;

public interface BlackListDetailDao {

    public int addBlackListDetail(BlackListDetail blackListDetail);
    public int addBlackListDetailBatch(List<BlackListDetail> list);
    public int deleteBlackListDetails(BlackListDetail blackListDetail);
    public BlackListDetail getTeachCodeLists(BlackListDetail blackListDetail);
    public BlackListDetail checkBlackListCode(BlackListDetail blackListDetail);


}
