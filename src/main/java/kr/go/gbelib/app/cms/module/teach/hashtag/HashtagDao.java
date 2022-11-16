package kr.go.gbelib.app.cms.module.teach.hashtag;

import java.util.List;

public interface HashtagDao {

    public List<Hashtag> getHashtagList(Hashtag hashtag);

    public Hashtag getHashtagOne(Hashtag hashtag);

    public int insertHashtag(Hashtag hashtag);

    public int updateHashtag(Hashtag hashtag);

    public int deleteHashtag(Hashtag hashtag);

    public String checkHashtag(Hashtag hashtag);

    public List<Hashtag> getHashtagCodeList(Hashtag hashtag);
}
