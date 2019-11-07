package kr.go.gbelib.app.cms.module.teachBook;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.student.Student;

public class TeachBookWorkbook {

	protected WritableWorkbook buildExcelDocument(WritableWorkbook workbook, Teach teach, List<Student> studentList, List<CalendarManage> calendar, TeachBook teachBook,
			Map<Integer, Map<String, String>> teachBookRepo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sheetName = teach.getTeach_name(); // 시트이름
		workbook.createSheet(sheetName, 0); // 시트설정

		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
		format.setAlignment(Alignment.CENTRE);
		format.setBackground(Colour.LIGHT_GREEN);
		format.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
		// 중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();
		format1.setAlignment(Alignment.CENTRE);

		// 테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();
		format2.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment(Alignment.CENTRE);
		format3.setBackground(Colour.LIGHT_GREEN);
		format3.setBorder(Border.ALL, BorderLineStyle.MEDIUM);

		// 컬럼 폭 지정
		workbook.getSheet(0).setColumnView(0, 20);
		workbook.getSheet(0).setColumnView(1, 20);

		// 헤더 컬럼 지정
		String title = String.format("[%s-%s] %s / 강의기간 : %s ~ %s, 강의시간 : %s ~ %s, 총 인원 : %s", teach.getGroup_name(), teach.getCategory_name(), teach.getTeach_name(), teach.getStart_date(), teach.getEnd_date(), teach.getStart_time(), teach.getEnd_time(), studentList.size());
		workbook.getSheet(0).addCell(new Label(5, 0, title));
		
		workbook.getSheet(0).addCell(new Label(0, 2, "번호", format));
		workbook.getSheet(0).addCell(new Label(1, 2, "성명", format));
		
		// 일자 시작 컬럼 
		int startDayCul = 2;
 		for ( CalendarManage c : calendar ) {
			if ( StringUtils.isNotEmpty(c.getSun()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getSun(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getSun())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getMon()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getMon(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getMon())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getTue()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getTue(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getTue())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getWed()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getWed(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getWed())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getThu()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getThu(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getThu())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getFri()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getFri(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getFri())), format));
				startDayCul ++;
			}
			if ( StringUtils.isNotEmpty(c.getSat()) ) {
				workbook.getSheet(0).setColumnView(startDayCul, 10);
				workbook.getSheet(0).addCell(new Label(startDayCul, 1, c.getSat(), format));
				workbook.getSheet(0).addCell(new Label(startDayCul, 2, getDayKorea(String.format("%s-%s", c.getPlan_date(), c.getSat())), format));
				startDayCul ++;
			}
		}
 		workbook.getSheet(0).addCell(new Label(startDayCul, 2, "수강료", format));
 		workbook.getSheet(0).addCell(new Label(startDayCul + 1, 2, "교재비", format));
 		workbook.getSheet(0).addCell(new Label(startDayCul + 2, 2, "재료비", format));
		
 		int studentRowStart = 3;
		for ( int i = 0; i < studentList.size(); i ++ ) {
			Student oneStudent = studentList.get(i);
			workbook.getSheet(0).addCell(new Label(0, studentRowStart, String.valueOf(i + 1))); //번호
			workbook.getSheet(0).addCell(new Label(1, studentRowStart, oneStudent.getStudent_name())); //이름

			// 다시 초기화
	 		startDayCul = 2;
			// ${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}
			for ( CalendarManage c : calendar ) {
				if ( StringUtils.isNotEmpty(c.getSun()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getSun().length() == 1 ? "0" + c.getSun():c.getSun());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getMon()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getMon().length() == 1 ? "0" + c.getMon():c.getMon());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getTue()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getTue().length() == 1 ? "0" + c.getTue():c.getTue());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getWed()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getWed().length() == 1 ? "0" + c.getWed():c.getWed());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getThu()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getThu().length() == 1 ? "0" + c.getThu():c.getThu());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getFri()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getFri().length() == 1 ? "0" + c.getFri():c.getFri());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
				if ( StringUtils.isNotEmpty(c.getSat()) ) {
					String key = String.format("%s-%s", c.getPlan_date(), c.getSat().length() == 1 ? "0" + c.getSat():c.getSat());
					String status = null;
					try {
						status = teachBookRepo.get(oneStudent.getStudent_idx()).get(key);
					} catch ( Exception e ) {
					}
					workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, getStatus(status)));
					startDayCul ++;
				}
			}
			
			workbook.getSheet(0).addCell(new Label(startDayCul, studentRowStart, oneStudent.getPay1_yn())); //수강료
			workbook.getSheet(0).addCell(new Label(startDayCul + 1, studentRowStart, oneStudent.getPay2_yn())); //교재비
			workbook.getSheet(0).addCell(new Label(startDayCul + 2, studentRowStart, oneStudent.getPay3_yn())); //재료비
			
			studentRowStart ++;
		}
		
		return workbook;
	}
	
	private String getDayKorea(String oneDate) {
		String dayStr = "";
		String[] pattern = {"yyyy-MM-d"};
		Date targetDate = null;
		try {
			targetDate = DateUtils.parseDate(oneDate, pattern);
			Calendar c = Calendar.getInstance();
			c.setTime(targetDate);
			
			int day = c.get(Calendar.DAY_OF_WEEK);
			// 1 = 일 , 7 = 토 
			switch ( day ) {
			case 1 :
				return "일";
			case 2 :
				return "월";
			case 3 :
				return "화";
			case 4 :
				return "수";
			case 5 :
				return "목";
			case 6 :
				return "금";
			case 7 :
				return "토";
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dayStr;
	}
	
	
	private String getStatus(String status) {
		
		if ( StringUtils.isEmpty(status) ) {
			return "-";
		}
		else {
			int statusValue = Integer.parseInt(status);
			switch ( statusValue ) {
			case 1 :
				return "●";
			case 2 :
				return "△";
			case 3 :
				return "×";
			case 4 :
				return "◇";
			case 5 :
				return "■";
			default : return "-";
			}	
		}
	}
}
