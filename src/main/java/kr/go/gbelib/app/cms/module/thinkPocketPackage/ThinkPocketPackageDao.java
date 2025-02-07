package kr.go.gbelib.app.cms.module.thinkPocketPackage;

import java.util.List;
import java.util.Map;

public interface ThinkPocketPackageDao {

  int getThinkPocketPackageCount(ThinkPocketPackage thinkPocketPackage);

  List<ThinkPocketPackage> getThinkPocketPackageList(ThinkPocketPackage thinkPocketPackage);

  ThinkPocketPackage getThinkPocketPackageOne(ThinkPocketPackage thinkPocketPackage);

  void addThinkPocketPackage(ThinkPocketPackage thinkPocketPackage);

  void modifyThinkPocketPackage(ThinkPocketPackage thinkPocketPackage);

  void deleteThinkPocketPackage(ThinkPocketPackage thinkPocketPackage);

  void deleteCheckThinkPocketPackage(ThinkPocketPackage thinkPocketPackage);

  int getThinkPocketPackageLoanCount(ThinkPocketPackage thinkPocketPackage);

  List<ThinkPocketPackage> getThinkPocketPackageLoanList(ThinkPocketPackage thinkPocketPackage);

  ThinkPocketPackage getThinkPocketPackageLoanOne(ThinkPocketPackage thinkPocketPackage);

  void addThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage);

  void modifyThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage);

  void deleteThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage);

  void modifyReturnReq(ThinkPocketPackage thinkPocketPackage);

  void statusChangeAll(ThinkPocketPackage thinkPocketPackage);

  List<ThinkPocketPackage> getThinkPocketPackageExcelList(ThinkPocketPackage thinkPocketPackage);

  List<ThinkPocketPackage> getThinkPocketPackageLoanExcelList(ThinkPocketPackage thinkPocketPackage);

  List<ThinkPocketPackage> getThinkPocketPackageLoanDate(ThinkPocketPackage thinkPocketData);

  List<String> getThinkPocketPackageLoanDateList(Map<String, String> loanRequestData);

  int getDuplicateLoanCount(ThinkPocketPackage thinkPocketPackage);
}
