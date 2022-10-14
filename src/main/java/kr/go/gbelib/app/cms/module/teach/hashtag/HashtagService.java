package kr.go.gbelib.app.cms.module.cultureTeach.hashtag;

import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HashtagService extends BaseService {

    @Autowired
    private HashtagDao dao;

    public List<Hashtag> getHashtagList(Hashtag hashtag) {
        return dao.getHashtagList(hashtag);
    }

    public Hashtag getHashtagOne(Hashtag hashtag) {
        return dao.getHashtagOne(hashtag);
    }

    public int insertHashtag(Hashtag hashtag) {
        return dao.insertHashtag(hashtag);
    }

    public int updateHashtag(Hashtag hashtag) {
        return dao.updateHashtag(hashtag);
    }

    public int deleteHashtag(Hashtag hashtag) {
        return dao.deleteHashtag(hashtag);
    }
}
