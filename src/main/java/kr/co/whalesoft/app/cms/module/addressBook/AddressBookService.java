package kr.co.whalesoft.app.cms.module.addressBook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.StrUtil;

@Service
public class AddressBookService extends BaseService {

	@Autowired
	
	private AddressBookDao dao;
	
	public List<AddressBook> getAddressTreeList(AddressBook addressBook) {
		return dao.getAddressTreeList(addressBook);
	}

	public AddressBook getAddressBookOne(AddressBook addressBook) {
		return dao.getAddressBookOne(addressBook);
	}

	public List<AddressBook> getMyItemList(AddressBook addressBook) {
		return dao.getMyItemList(addressBook);
	}

	public int addAddressBookGroup(AddressBook addressBook) {
		return dao.addAddressBookGroup(addressBook);
	}

	public int modifyAddressBookGroup(AddressBook addressBook) {
		return dao.modifyAddressBookGroup(addressBook);
	}

	public int getChildCount(AddressBook addressBook) {
		return dao.getChildCount(addressBook);
	}

	public int deleteAddressBookGroup(AddressBook addressBook) {
		return dao.deleteAddressBookGroup(addressBook);
	}

	public int addAddressBook(AddressBook addressBook) {
		return dao.addAddressBook(addressBook);
	}

	public int modifyAddressBook(AddressBook addressBook) {
		return dao.modifyAddressBook(addressBook);
	}

	public int deleteAddressBook(AddressBook addressBook) {
		return dao.deleteAddressBook(addressBook);
	}

	public int deleteAddressBookBatch(AddressBook addressBook) {
		return dao.deleteAddressBookBatch(addressBook);
	}

	public String getExcelRows(AddressBook addressBook) throws Exception {
		MultipartFile mFile = addressBook.getUploadFile();
		File excelFile = new File(mFile.getOriginalFilename());
		
		mFile.transferTo(excelFile);
//		convert(mFile);
//		XSSFWorkbook wb = (XSSFWorkbook) WorkbookFactory.create(excelFile);
		Workbook work = WorkbookFactory.create(new FileInputStream(excelFile));
		Sheet sheet = work.getSheetAt(0);
		return (sheet.getPhysicalNumberOfRows()) + "";
	}

	
	public List<AddressBook> getExcelList(AddressBook addressBook) throws Exception {
		MultipartFile mFile = addressBook.getUploadFile();
		File excelFile = new File(mFile.getOriginalFilename());
		mFile.transferTo(excelFile);
		
		return getXlsxData(excelFile);
	}
	
	private List<AddressBook> getXlsxData(File excelFile) throws Exception {
		List<AddressBook> list = new ArrayList<AddressBook>();
		String msg = "";
		Workbook work = WorkbookFactory.create(new FileInputStream(excelFile));
		Sheet sheet = work.getSheetAt(0);
		Set<String> set = new HashSet<String>();
		
		//운반용기 정보등록부터 한다.
		int rows = sheet.getPhysicalNumberOfRows();
		for (int i = 0; i < rows; i++) {
			AddressBook form2 = new AddressBook();
			Row row = sheet.getRow(i);
			if(row == null) continue;
//			int cells = row.getPhysicalNumberOfCells();
			for (int j = 0; j < 3; j++) {
				Cell cell = row.getCell(j);
				String tempValue = "";
				if (cell != null) {
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_FORMULA:
						try {
							tempValue = String.valueOf(cell.getNumericCellValue());
						} catch (IllegalStateException e) {
							tempValue = cell.getStringCellValue();
						}
						break;
					case Cell.CELL_TYPE_STRING:
						tempValue = cell.getStringCellValue();
						break;
						
					case Cell.CELL_TYPE_NUMERIC:
						
						if(DateUtil.isCellDateFormatted(cell)){ // 날짜 유형의 데이터일 경우,
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
							String formattedStr = dateFormat.format(cell.getDateCellValue());
							tempValue = formattedStr;
						}else{ // 순수하게 숫자 데이터일 경우,
							Double numericCellValue = cell.getNumericCellValue();
							if(Math.floor(numericCellValue) == numericCellValue){ // 소수점 이하를 버린 값이 원래의 값과 같다면,,
								tempValue = numericCellValue.intValue() + ""; // int형으로 소수점 이하 버리고 String으로 데이터 담는다.
							}else{
								tempValue = numericCellValue + "";
							}
						}					
						break;
						
					case Cell.CELL_TYPE_BLANK:
						tempValue = cell.getStringCellValue();
						break;
					}
					
					msg = setInfo(form2, j, tempValue);
					
				}
				
				if (msg != null && !msg.equals("")) {
					msg = "Row : "+(i+1) + " 전화번호 형식이 아닙니다."; 
					List<AddressBook> returnList = new ArrayList<AddressBook>();
					AddressBook form = new AddressBook();
					form.setFlag(false);
					form.setMsg(msg);
					returnList.add(form);
					return returnList;
				}
				
			}
			
			if(set.contains(form2.getAddress_cell_phone())) continue;
			else set.add(form2.getAddress_cell_phone());
			
			list.add(form2);
		}
		excelFile.delete();
		return list;
	}
	
	/**
	 * 엑셀 셀 데이터를 객체에 저장
	 * getXlsxData() 하위 메소드. 
	 * @param form2
	 * @param j
	 * @param tempValue
	 * @param cellHeaderName
	 * @return 오류발생시 오류메시지
	 */
	private String setInfo(AddressBook form2, int j, String tempValue) {
		String msg = "";
		tempValue = tempValue.trim();
		switch (j) {
		case 0://이름
			if (StringUtils.isNotEmpty(tempValue)) {
				form2.setAddress_name(tempValue);
			}
			break;	
		case 1:	//전화번호
			if (StringUtils.isNotEmpty(tempValue)) {
				form2.setAddress_cell_phone(StrUtil.getPhoneNumber(tempValue).replaceAll("-", ""));
			}
			break;
		case 2:	//이메일
			if (StringUtils.isNotEmpty(tempValue)) {
				form2.setAddress_email(tempValue);
			}
		}
		return msg;
	}

	public int addExcelDataList(AddressBook addressBook, List<AddressBook> list) {
		
		for ( AddressBook bean : list ) {
			if (StringUtils.isNotEmpty(bean.getAddress_name())) {
				bean.setAddress_book_idx(addressBook.getAddress_book_idx());
				bean.setMemberInfo(addressBook.getMemberInfo());
				dao.addAddressBook(bean);
			}
		}
		
		return 1;
	}

	public void writeExcelDataSample(OutputStream out ) throws RowsExceededException, WriteException, IOException {
		
		WritableWorkbook workbook = jxl.Workbook.createWorkbook( out );
		WritableSheet sheet = workbook.createSheet( "주소록업로드양식", 0 );
		
		// 헤더 스타일
		WritableCellFormat format = new WritableCellFormat();
//		format.setAlignment( Alignment.CENTRE );
//		format.setBackground( Colour.LIGHT_GREEN );

		//중앙정렬
		WritableCellFormat format1 = new WritableCellFormat();		
		format1.setAlignment(Alignment.CENTRE);

		//테두리선,중앙정렬
		WritableCellFormat format2 = new WritableCellFormat();		
		format2.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		//중앙정렬,배경색,테두리 색
		WritableCellFormat format3 = new WritableCellFormat();
		format3.setAlignment( Alignment.CENTRE );
		format3.setBackground( Colour.LIGHT_GREEN );
		format3.setBorder(Border.ALL,BorderLineStyle.MEDIUM);
		
		// 컬럼 폭 지정
		sheet.setColumnView( 0,  20 );
		sheet.setColumnView( 1,  20 );
		sheet.setColumnView( 2,  20 );
		
		// 헤더 컬럼 지정
		sheet.addCell( new Label( 0,  0, "홍길동" ) );
		sheet.addCell( new Label( 1,  0, "01011112222") );
		sheet.addCell( new Label( 2,  0, "hong@gil.dong") );

		sheet.addCell( new Label( 0,  1, "이순신" ) );
		sheet.addCell( new Label( 1,  1, "01012345678") );
		sheet.addCell( new Label( 2,  1, "lee@sunshin.com") );

		sheet.addCell( new Label( 0,  2, "김엑셀" ) );
		sheet.addCell( new Label( 1,  2, "010-1234-5678") );
		
		sheet.addCell( new Label( 0,  3, "박전화" ) );
		sheet.addCell( new Label( 1,  3, "01012123434") );

		
		workbook.write();
		workbook.close();
	}

	public File convert(MultipartFile file) throws IOException
	{    
	    File convFile = new File(file.getOriginalFilename());
	    convFile.createNewFile(); 
	    FileOutputStream fos = new FileOutputStream(convFile); 
	    fos.write(file.getBytes());
	    fos.close(); 
	    return convFile;
	}
	
}
