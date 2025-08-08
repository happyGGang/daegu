package kr.go.gbelib.app.cms.module.division;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DivisionService extends BaseService {

    @Autowired
	private DivisionDao dao;

    public List<Division> getDivisionList(Division division) {
        return dao.getDivisionList(division);
    }

    public List<Division> findByDepthAndParent(Division division) {
        return dao.findByDepthAndParent(division);
    }
}
