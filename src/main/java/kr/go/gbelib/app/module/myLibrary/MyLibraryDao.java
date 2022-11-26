package kr.go.gbelib.app.module.myLibrary;

public interface MyLibraryDao {

    public MyLibrary getMyLibrary(MyLibrary myLibrary);

    public int addMyLibrary(MyLibrary myLibrary);

    public int modifyLibrary(MyLibrary myLibrary);
}
