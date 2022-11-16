package kr.go.gbelib.app.cms.module.specializedServices;

import java.io.File;
import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class SpecializedServicesService extends BaseService {

    @Autowired
    private SpecializedServicesDao dao;

    @Autowired
    @Qualifier("specializedServicesStorage")
    private FileStorage specializedServicesStorage;

    public List<SpecializedServices> getSpecializedServicesList(SpecializedServices specializedServices) {
        return dao.getSpecializedServicesList(specializedServices);
    }

    public int getSpecializedServicesCount(SpecializedServices specializedServices) {
        return dao.getSpecializedServicesCount(specializedServices);
    }

    public SpecializedServices getSpecializedServicesOne(SpecializedServices specializedServices) {
        return dao.getSpecializedServicesOne(specializedServices);
    }

    public int addSpecializedServices(SpecializedServices specializedServices, MultipartHttpServletRequest mpRequest) {
        MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
        if(mFile != null) {
            String realFileName 	= Long.toString((System.currentTimeMillis()));
            String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
            String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
            String filePath 		= "/" + specializedServices.getHomepage_id();

            File f = specializedServicesStorage.addFile(mFile, realFileName, filePath);

            specializedServices.setOrg_file_name(fileName);
            specializedServices.setServer_file_name(realFileName);
            specializedServices.setFile_extension(fileExtension);
            specializedServices.setFile_size(f.length());
        }

        return dao.addSpecializedServices(specializedServices);
    }

    public int modifySpecializedServices(SpecializedServices specializedServices, MultipartHttpServletRequest mpRequest) {
        MultipartFile mFile = mpRequest.getFileMap().get("imgFile");

        if(mFile != null) {
            String realFileName 	= Long.toString((System.currentTimeMillis()));
            String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
            String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
            String filePath 		= "/" + specializedServices.getHomepage_id();

            File f = specializedServicesStorage.addFile(mFile, realFileName, filePath);

            specializedServices.setOrg_file_name(fileName);
            specializedServices.setServer_file_name(realFileName);
            specializedServices.setFile_extension(fileExtension);
            specializedServices.setFile_size(f.length());
        }

        return dao.modifySpecializedServices(specializedServices);
    }

    public int deleteSpecializedServices(SpecializedServices specializedServices) {
        return dao.deleteSpecializedServices(specializedServices);
    }

    public String addImgFile(String homepage_id, MultipartHttpServletRequest mpRequest) {
        MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
        File f 	= null;
        String filePath = "/" + homepage_id;

        if ( mFile != null ) {
            String realFileName 	= Long.toString((System.currentTimeMillis()));
            f = specializedServicesStorage.addFile(mFile, realFileName, filePath);
        }

        return specializedServicesStorage.getContextPath() + filePath + "/" + f.getName();
    }

    public List<SpecializedServices> getSpecializedServicesMainList(SpecializedServices specializedServices) {
        return dao.getSpecializedServicesMainList(specializedServices);
    }
}
