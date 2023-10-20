package kr.go.gbelib.app.cms.module.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;

@Service
public class InternationalTeachApiService extends BaseService {
	@Autowired
	private TeachService teachService;

	public InternationalTeachXmlResult internationalDataRoomList(Teach teach, HttpServletRequest request, HttpServletResponse response) {

		InternationalTeachXmlResult internationalTeachXmlResult = new InternationalTeachXmlResult();
		
		teach.setHomepage_id("h50");
		
		List<Teach> teachList = teachService.getInternationalDataRoomList(teach);
		
		try {
			if(teachList.size() > 0) {
				for(int i =0 ; i < teachList.size(); i++) {
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_name())) {
						internationalTeachXmlResult.setTeach_title(teachList.get(i).getTeach_name());
					}
					if(teachList.get(i).getTeach_join_count() > 0) {
						internationalTeachXmlResult.setLimit_count(teachList.get(i).getTeach_join_count());
					}
					if(teachList.get(i).getTeach_backup_join_count() > 0) {
						internationalTeachXmlResult.setBackup_count(teachList.get(i).getTeach_backup_join_count());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getStart_date())) {
						internationalTeachXmlResult.setTeach_date(teachList.get(i).getStart_date());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_day())) {
						if("Y".equals(teachList.get(i).getTeach_day_yn())) {
							internationalTeachXmlResult.setTeach_dayweek(teachList.get(i).getTeach_day_txt());
						} else {
							String teach_day_arr[] = teachList.get(i).getTeach_day().split(",");
							
							String teach_day = "";
							for(int j = 0; j < teach_day_arr.length; j++) {
								String day = teach_day_arr[j];
								
								if("1".equals(day)) {
									day = "일";
								} else if("2".equals(day)) {
									day = "월";
								} else if("3".equals(day)) {
									day = "화";
								} else if("4".equals(day)) {
									day = "수";
								} else if("5".equals(day)) {
									day = "목";
								} else if("6".equals(day)) {
									day = "금";
								} else if("7".equals(day)) {
									day = "토";
								}
								
								teach_day = teach_day+ "," + day;
							}
							
							internationalTeachXmlResult.setTeach_dayweek(teach_day.substring(1));
						}
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getStart_join_date())) {
						internationalTeachXmlResult.setJoin_date(teachList.get(i).getStart_join_date());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getGroup_name())) {
						internationalTeachXmlResult.setCategory(teachList.get(i).getGroup_name());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_desc())) {
						internationalTeachXmlResult.setContents(teachList.get(i).getTeach_desc());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_stage())) {
						internationalTeachXmlResult.setTeach_stage(teachList.get(i).getTeach_stage());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeacher_name())) {
						internationalTeachXmlResult.setTeacher(teachList.get(i).getTeacher_name());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_etc())) {
						internationalTeachXmlResult.setTeach_etc(teachList.get(i).getTeach_etc());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getTeach_target())) {
						internationalTeachXmlResult.setTeach_target(teachList.get(i).getTeach_target());
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getOrg_file_name())) {
						internationalTeachXmlResult.setFile_name("https://library.daegu.go.kr/cms/module/teach/download/h50/"+teachList.get(i).getGroup_idx()+"/"+teachList.get(i).getCategory_idx()+"/"+teachList.get(i).getTeach_idx()+".do");
					}
					if(StringUtils.isNotEmpty(teachList.get(i).getImage_org_file_name())) {
						internationalTeachXmlResult.setImage_url("https://library.daegu.go.kr/data/teach/h50/img/"+teachList.get(i).getImage_server_file_name());
					}
					internationalTeachXmlResult.setMessage("국제자료실 데이터 조회 성공.");
				}
			} else {
				internationalTeachXmlResult.setMessage("등록되어있는 국제자료실 데이터가 없습니다.");
			}
		} catch(Exception e) {
			internationalTeachXmlResult.setMessage("국제자료실 데이터를 조회하는데 오류가 발생하였습니다.");
			return internationalTeachXmlResult;
		}

		return internationalTeachXmlResult;
	}

}
