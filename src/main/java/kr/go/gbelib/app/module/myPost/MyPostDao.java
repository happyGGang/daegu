package kr.go.gbelib.app.module.myPost;

import java.util.List;

public interface MyPostDao {
    public int getPostCount(MyPost myPost);

    public List<MyPost> getPostList(MyPost myPost);

    public List<MyPost> getLibraryList(MyPost myPost);

    public List<MyPost> getBoardList(MyPost myPost);
}
