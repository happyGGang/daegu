package kr.co.whalesoft.app.cms.projectManage;

import java.util.List;

public interface ProjectManageDao  {

	public List<ProjectManage> getProjectManageList(ProjectManage projectManage);
	
	public List<ProjectManage> getProjectManageListAll(ProjectManage projectManage);
	
	public int getProjectManageListCount(ProjectManage projectManage);
	
	public ProjectManage getProjectManageOne(ProjectManage projectManage);
	
	public int addProjectManage(ProjectManage projectManage);
	
	public int modifyProjectManage(ProjectManage projectManage);
	
	public int deleteProjectManage(ProjectManage projectManage);
}