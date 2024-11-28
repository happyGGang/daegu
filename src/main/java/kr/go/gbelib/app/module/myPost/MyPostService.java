package kr.go.gbelib.app.module.myPost;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyPostService extends BaseService {

    @Autowired
    private MyPostDao dao;

    public int getPostCount(MyPost myPost) {
        return dao.getPostCount(myPost);
    }

    public List<MyPost> getPostList(MyPost myPost) {
        return dao.getPostList(myPost);
    }

    public List<MyPost> getLibraryList(MyPost myPost) {
        return dao.getLibraryList(myPost);
    }

    public List<MyPost> getBoardList(MyPost myPost) {
        return dao.getBoardList(myPost);
    }
}
