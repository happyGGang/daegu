package kr.co.whalesoft.app.cms.taskManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class TaskManageService extends BaseService {
	
	@Autowired
	private TaskManageDao taskManageDao;
	
	public List<TaskManage> getTaskTypeList(TaskManage taskManage) {
		return taskManageDao.getTaskTypeList(taskManage);
	}
	
	public List<TaskManage> getTaskListAll(TaskManage taskManage) {
		return taskManageDao.getTaskListAll(taskManage);
	}
	 
	public List<TaskManage> getTaskList(TaskManage taskManage) {
		return taskManageDao.getTaskList(taskManage);
	}
	
	public int getTaskListCount(TaskManage taskManage) {
		return taskManageDao.getTaskListCount(taskManage);
	}
	
	public TaskManage getTaskOne(TaskManage taskManage) {
		return taskManageDao.getTaskOne(taskManage);
	}
	
	public int addTask(TaskManage taskManage) {
		return taskManageDao.addTask(taskManage);
	}
	
	public int modifyTask(TaskManage taskManage) {
		return taskManageDao.modifyTask(taskManage);
	}
	
	public int deleteTask(TaskManage taskManage) {
		return taskManageDao.deleteTask(taskManage);
	}
	
	public List<TaskManage> getTaskManagerListAll(TaskManage taskManage) {
		return taskManageDao.getTaskManagerListAll(taskManage);
	}
	
	public List<TaskManage> getMemberListNotInTaskManage(TaskManage taskManage) {
		return taskManageDao.getMemberListNotInTaskManage(taskManage); 
	}
	
	public int addTaskManager(TaskManage taskManage) {
		return taskManageDao.addTaskManager(taskManage);
	}
	
	public int deleteTaskManager(TaskManage taskManage) {
		return taskManageDao.deleteTaskManager(taskManage);
	}

	public int getMaxPrintSeq(TaskManage taskManage) {
		return taskManageDao.getMaxPrintSeq(taskManage);
	}
	
}