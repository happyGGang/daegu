package kr.co.whalesoft.app.cms.taskManage;

import java.util.List;

public interface TaskManageDao  {

	public List<TaskManage> getTaskTypeList(TaskManage taskManage);
	
	public List<TaskManage> getTaskListAll(TaskManage taskManage);
	
	public List<TaskManage> getTaskList(TaskManage taskManage);
	
	public int getTaskListCount(TaskManage taskManage);
	
	public TaskManage getTaskOne(TaskManage taskManage);
	
	public int addTask(TaskManage taskManage);
	
	public int modifyTask(TaskManage taskManage);
	
	public int deleteTask(TaskManage taskManage);
	
	public List<TaskManage> getTaskManagerListAll(TaskManage taskManage);

	public List<TaskManage> getMemberListNotInTaskManage(TaskManage taskManage);

	public int addTaskManager(TaskManage taskManage);
	
	public int deleteTaskManager(TaskManage taskManage);

	public int getMaxPrintSeq(TaskManage taskManage);

}