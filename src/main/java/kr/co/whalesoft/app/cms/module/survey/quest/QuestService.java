package kr.co.whalesoft.app.cms.module.survey.quest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetailService;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrixService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class QuestService extends BaseService {

	@Autowired
	private QuestDao dao;
	
	@Autowired
	private QuestMatrixService questMatrixService;
	
	@Autowired
	private QuestDetailService questDetailService;
	
	@Autowired
	@Qualifier("questImageStorage")
	private FileStorage questImageStorage;
	
	public List<Quest> getQuest(Quest quest) {
		
		List<Quest> questList = dao.getQuest(quest);
		
		for(Quest questBean : questList) {
			if(questBean.getQuest_type().equals("MATRIX")) {
				questBean.setQuest_matrix_list(questMatrixService.getQuestMatrix(questBean));
			}
			
			questBean.setQuest_detail_list(questDetailService.getQuestDetail(questBean));
			
		}
		
		return questList;
	}
	
	public int getQuestCnt(Quest quest) {
		return dao.getQuestCnt(quest);
	}
	
	public Quest getQuestOne(Quest quest) {
		Quest questBean = dao.getQuestOne(quest);
		
		if(questBean != null && questBean.getQuest_type().equals("MATRIX")) {
			questBean.setQuest_matrix_list(questMatrixService.getQuestMatrix(questBean));
		}
		
		questBean.setQuest_detail_list(questDetailService.getQuestDetail(questBean));
		
		return questBean;
	}
	
	@Transactional
	public int addQuest(Quest quest) {
		
		if (quest.getMultiFile() != null) {
			MultipartFile mFile = quest.getMultiFile();
			String fileName = String.valueOf(System.currentTimeMillis());
			
			String filePath = "/" + quest.getHomepage_id() + "/" + quest.getSurvey_idx() ;
			questImageStorage.addFile(mFile, fileName, filePath);
			quest.setQuest_content("/data/questImage" + filePath + "/" + fileName);
		}
		
		
		if(dao.addQuest(quest) > 0) {
			
			if(quest.getQuest_matrix_list() != null && quest.getQuest_matrix_list().size() > 0) {
				int i = 1;
				
				if(quest.getQuest_type().equals("MATRIX")) {
					for(QuestMatrix questMatrix : quest.getQuest_matrix_list()) {
						questMatrix.setHomepage_id(quest.getHomepage_id());
						questMatrix.setAdd_id(quest.getAdd_id());
						questMatrix.setSurvey_idx(quest.getSurvey_idx());
						questMatrix.setQuest_idx(quest.getQuest_idx());
						questMatrix.setMatrix_order(i++);
						
						questMatrixService.addQuestMatrix(questMatrix);
					}
				}
			}
			
			if(quest.getQuest_detail_list() != null && quest.getQuest_detail_list().size() > 0) {
				int i = 1;
				
				for(QuestDetail questDetail : quest.getQuest_detail_list()) {
					questDetail.setHomepage_id(quest.getHomepage_id());
					questDetail.setAdd_id(quest.getAdd_id());
					questDetail.setSurvey_idx(quest.getSurvey_idx());
					questDetail.setQuest_idx(quest.getQuest_idx());
					questDetail.setQuest_detail_order(i++);
					
					questDetailService.addQuestDetail(questDetail);
				}
			}
			
		}
		
		return 1;
	}
	
	@Transactional
	public int modifyQuestOrder(Quest quest) {
		Quest temp1 = new Quest();		
		temp1.setSurvey_idx(quest.getSurvey_idx());
		temp1.setQuest_idx(quest.getQuest_idx());
		temp1.setModify_id(quest.getModify_id());
		temp1.setHomepage_id(quest.getHomepage_id());
		
		Quest temp2 = new Quest();
		temp2.setSurvey_idx(quest.getSurvey_idx());
		temp2.setQuest_idx(quest.getQuest_idx_fr());
		temp2.setModify_id(quest.getModify_id());
		temp2.setHomepage_id(quest.getHomepage_id());

		temp1.setQuest_order(dao.getQuestOrderOne(temp2));
		temp2.setQuest_order(dao.getQuestOrderOne(temp1));
		
		dao.modifyQuestOrder(temp1);
		dao.modifyQuestOrder(temp2);	
		
		return 1;
	}
	
	@Transactional
	public int modifyQuest(Quest quest) {
		if (quest.getMultiFile() != null) {
			Quest questOne = dao.getQuestOne(quest);
			String fileName = questOne.getQuest_content().substring(questOne.getQuest_content().lastIndexOf("/")+1);
			String filePath = questOne.getQuest_content().substring(0, questOne.getQuest_content().lastIndexOf("/"));
			questImageStorage.deleteFile(fileName, filePath);
			MultipartFile mFile = quest.getMultiFile();
			fileName = String.valueOf(System.currentTimeMillis());
			filePath = "/" + quest.getHomepage_id() + "/" + quest.getSurvey_idx() ;
			questImageStorage.addFile(mFile, fileName, filePath);
			quest.setQuest_content("/data/questImage" + filePath + "/" + fileName);
		}
		if(dao.modifyQuest(quest) > 0) {
			
			if(quest.getQuest_matrix_list() != null && quest.getQuest_matrix_list().size() > 0) {
				if(quest.getQuest_type().equals("MATRIX")) {
					questMatrixService.deleteQuestMatrix(quest);
					
					int i = 1;
					
					for(QuestMatrix questMatrix : quest.getQuest_matrix_list()) {
						questMatrix.setHomepage_id(quest.getHomepage_id());
						questMatrix.setAdd_id(quest.getAdd_id());
						questMatrix.setSurvey_idx(quest.getSurvey_idx());
						questMatrix.setQuest_idx(quest.getQuest_idx());
						questMatrix.setMatrix_order(i++);
						
						questMatrixService.addQuestMatrix(questMatrix);
					}
				}
			}
			
			if(quest.getQuest_detail_list() != null && quest.getQuest_detail_list().size() > 0) {
				questDetailService.deleteQuestDetail(quest);
				
				int i = 1;
				
				for(QuestDetail questDetail : quest.getQuest_detail_list()) {
					questDetail.setHomepage_id(quest.getHomepage_id());
					questDetail.setAdd_id(quest.getAdd_id());
					questDetail.setSurvey_idx(quest.getSurvey_idx());
					questDetail.setQuest_idx(quest.getQuest_idx());
					questDetail.setQuest_detail_order(i++);
					
					questDetailService.addQuestDetail(questDetail);
				}
			} 
		}
		
		return 1;
	}
	
	@Transactional
	public int deleteQuest(Quest quest) {
		
		questDetailService.deleteQuestDetail(quest);
		Quest tempQuest = getQuestOne(quest);
		dao.deleteQuest(quest);
		dao.reOrderQuest(tempQuest);
		
		return 1;
	}

		
	public List<Quest> getQuestBranch(Quest quest) {
		return dao.getQuestBranch(quest);
	}
	
	public int getQuestMatrixCount(Quest quest) {
		return questMatrixService.getQuestMatrix(quest).size();
	}
	
}