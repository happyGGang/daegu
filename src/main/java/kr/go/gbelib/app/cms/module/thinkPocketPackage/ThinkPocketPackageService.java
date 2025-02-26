package kr.go.gbelib.app.cms.module.thinkPocketPackage;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ThinkPocketPackageService extends BaseService {

  @Autowired
  @Qualifier("thinkPocketPackageStorage")
  private FileStorage thinkPocketPackageStorage;

  @Autowired
  private ThinkPocketPackageDao dao;

  public String getRootPath() {
    return thinkPocketPackageStorage.getRootPath();
  }

  public int getThinkPocketPackageCount(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageCount(thinkPocketPackage);
  }

  public List<ThinkPocketPackage> getThinkPocketPackageList(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageList(thinkPocketPackage);
  }

  public ThinkPocketPackage getThinkPocketPackageOne(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageOne(thinkPocketPackage);
  }

  public void addThinkPocketPackage(ThinkPocketPackage thinkPocketPackage) {
    documentAndFileProcessing(thinkPocketPackage);

    dao.addThinkPocketPackage(thinkPocketPackage);
  }


  public void modifyThinkPocketPackage(ThinkPocketPackage thinkPocketPackage) {

    documentAndFileProcessing(thinkPocketPackage);

    dao.modifyThinkPocketPackage(thinkPocketPackage);
  }

  private void documentAndFileProcessing(ThinkPocketPackage thinkPocketPackage) {
    // 문서 파일 처리
    processFile(thinkPocketPackage.getDoc_file(), fileProps -> {
      thinkPocketPackage.setDoc_org_file_name((String) fileProps.get("fileName"));
      thinkPocketPackage.setDoc_server_file_name((String) fileProps.get("realFileName"));
      thinkPocketPackage.setDoc_file_extension((String) fileProps.get("fileExtension"));
      thinkPocketPackage.setDoc_file_size((Long) fileProps.get("fileSize"));
    });

    // 일반 파일 처리
    processFile(thinkPocketPackage.getMfile(), fileProps -> {
      thinkPocketPackage.setOrg_file_name((String) fileProps.get("fileName"));
      thinkPocketPackage.setServer_file_name((String) fileProps.get("realFileName"));
      thinkPocketPackage.setFile_extension((String) fileProps.get("fileExtension"));
      thinkPocketPackage.setFile_size((Long) fileProps.get("fileSize"));
    });
  }

  private void processFile(MultipartFile file, Consumer<Map<String, Object>> setter) {
    if (file != null && StringUtils.isNotEmpty(file.getOriginalFilename())) {
      String originalFilename = file.getOriginalFilename();
      int dotIndex = originalFilename.lastIndexOf(".");
      String fileName = dotIndex != -1 ? originalFilename.substring(0, dotIndex) : originalFilename;
      String realFileName = Long.toString(System.currentTimeMillis());
      String fileExtension = dotIndex != -1 ? FilenameUtils.getExtension(originalFilename) : "";
      String filePath = "/";

      File storedFile = thinkPocketPackageStorage.addFile(file, realFileName, filePath);
      long fileSize = storedFile.length();

      Map<String, Object> fileProps = new HashMap<>();
      fileProps.put("fileName", fileName);
      fileProps.put("realFileName", realFileName);
      fileProps.put("fileExtension", fileExtension);
      fileProps.put("fileSize", fileSize);

      setter.accept(fileProps);
    }
  }

  public void deleteThinkPocketPackage(ThinkPocketPackage thinkPocketPackage) {
    dao.deleteThinkPocketPackage(thinkPocketPackage);
  }

  public void deleteCheckThinkPocketPackage(ThinkPocketPackage thinkPocketPackage) {
    dao.deleteCheckThinkPocketPackage(thinkPocketPackage);
  }

  public int getThinkPocketPackageLoanCount(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageLoanCount(thinkPocketPackage);
  }

  @WorkingLogger(comment = "생각 주머니 대출신청 리스트 관리 조회", type = "P")
  public List<ThinkPocketPackage> getThinkPocketPackageLoanList(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageLoanList(thinkPocketPackage);
  }

  @WorkingLogger(comment = "생각 주머니 대출신청 리스트 관리 1건 조회", type = "P")
  public ThinkPocketPackage getThinkPocketPackageLoanOne(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageLoanOne(thinkPocketPackage);

  }

  public void addThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage) {
    dao.addThinkPocketPackageLoan(thinkPocketPackage);
  }

  @WorkingLogger(comment = "책 꾸러미 대출신청 리스트 관리 1건 수정", type = "P")
  public void modifyThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage) {
    dao.modifyThinkPocketPackageLoan(thinkPocketPackage);
  }

  @WorkingLogger(comment = "책 꾸러미 대출신청 리스트 관리 1건 취소", type = "P")
  public void deleteThinkPocketPackageLoan(ThinkPocketPackage thinkPocketPackage) {
    dao.deleteThinkPocketPackageLoan(thinkPocketPackage);
  }

  public void modifyReturnReq(ThinkPocketPackage thinkPocketPackage) {
    dao.modifyReturnReq(thinkPocketPackage);
  }

  public void statusChangeAll(ThinkPocketPackage thinkPocketPackage) {
    dao.statusChangeAll(thinkPocketPackage);
  }

  public List<ThinkPocketPackage> getThinkPocketPackageExcelList(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageExcelList(thinkPocketPackage);
  }
  @WorkingLogger(comment="책 꾸러미 대출신청 리스트 관리 엑셀 저장", type="P")
  public List<ThinkPocketPackage> getThinkPocketPackageLoanExcelList(ThinkPocketPackage thinkPocketPackage) {
    return dao.getThinkPocketPackageLoanExcelList(thinkPocketPackage);
  }

  public List<ThinkPocketPackage> getThinkPocketPackageLoanDate(ThinkPocketPackage thinkPocketData) {
    return dao.getThinkPocketPackageLoanDate(thinkPocketData);
  }

  public List<String> getThinkPocketPackageLoanDateList(Map<String, String> loanRequestData) {
    return dao.getThinkPocketPackageLoanDateList(loanRequestData);
  }

  public int getDuplicateLoanCount(ThinkPocketPackage thinkPocketPackage) {
    return dao.getDuplicateLoanCount(thinkPocketPackage);
  }

  public int setOutputOrder(ThinkPocketPackage thinkPocketPackage) {
    return dao.setOutputOrder(thinkPocketPackage);
  }
}
