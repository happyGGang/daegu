package kr.go.gbelib.app.cms.module.division;

import java.util.List;

public interface DivisionDao {

    List<Division> getDivisionList(Division division);

    List<Division> findByDepthAndParent(Division division);
}
