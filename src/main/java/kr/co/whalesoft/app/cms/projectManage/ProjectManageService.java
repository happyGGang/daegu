package kr.co.whalesoft.app.cms.projectManage;

import java.io.File;
import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProjectManageService extends BaseService {
	
	@Autowired
	@Qualifier("projectManageStorage")
	private FileStorage projectManageStorage;
	
	@Autowired
	private ProjectManageDao projectManageDao;
	
	public List<ProjectManage> getProjectManageListAll(ProjectManage projectManage) {
		return projectManageDao.getProjectManageListAll(projectManage);
	}
	 
	public List<ProjectManage> getProjectManageList(ProjectManage projectManage) {
		return projectManageDao.getProjectManageList(projectManage);
	}
	
	public int getProjectManageListCount(ProjectManage projectManage) {
		return projectManageDao.getProjectManageListCount(projectManage);
	}
	
	public ProjectManage getProjectManageOne(ProjectManage projectManage) {
		return projectManageDao.getProjectManageOne(projectManage);
	}
	
	public int addProjectManage(ProjectManage projectManage) {
		MultipartFile mFile = projectManage.getFile();
		
		if ( mFile != null ) {
			File f = projectManageStorage.addFile(mFile, mFile.getOriginalFilename(), projectManage.getHomepage_id());
			projectManage.setFile_name(f.getName());
		}
		
		return projectManageDao.addProjectManage(projectManage);
	}
	
	public int modifyProjectManage(ProjectManage projectManage) {
		MultipartFile mFile = projectManage.getFile();
		
		if ( mFile != null ) {
			projectManageStorage.deleteFile(projectManage.getFile_name(), projectManage.getHomepage_id());
			
			File f = projectManageStorage.addFile(mFile, mFile.getOriginalFilename(), projectManage.getHomepage_id());
			projectManage.setFile_name(f.getName());
		}
		
		return projectManageDao.modifyProjectManage(projectManage);
	}
	
	public int deleteProjectManage(ProjectManage projectManage) {
		ProjectManage delProjectManage = getProjectManageOne(projectManage);
		String fileName = delProjectManage.getFile_name();
		if ( !StringUtils.isEmpty(fileName) ) {
			projectManageStorage.deleteFile(fileName, projectManage.getHomepage_id());	
		}
		
		return projectManageDao.deleteProjectManage(projectManage);
	}
}