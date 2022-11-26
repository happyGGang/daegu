package kr.go.gbelib.app.module.myLibrary;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyLibraryService extends BaseService {

    @Autowired
    private MyLibraryDao dao;

    public MyLibrary getMyLibrary(MyLibrary myLibrary) {
        return dao.getMyLibrary(myLibrary);
    }

    public int addMyLibrary(MyLibrary myLibrary) {
        return dao.addMyLibrary(myLibrary);
    }

    public int modifyLibrary(MyLibrary myLibrary) {
        return dao.modifyLibrary(myLibrary);
    }
}
