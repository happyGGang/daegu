package kr.go.gbelib.app.cms.module.circlesRoom;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Service
public class CirclesRoomService extends BaseService {


	@Autowired
	private CirclesRoomDao dao;
	@Autowired
	@Qualifier("circlesRoomStorage")
	private FileStorage circlesRoomStorage;

	public int getCirclesRoomCount(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomCount(circlesRoom);
	}

	public List<CirclesRoom> getCirclesRoomList(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomList(circlesRoom);
	}
	
	public List<CirclesRoom> getCirclesRoomReqView(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomReqView(circlesRoom);
	}
	
	public List<CirclesRoom> getCirclesRoomMyList(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomMyList(circlesRoom);
	}

	public int addCirclesRoom(CirclesRoom circlesRoom) {
		return dao.addCirclesRoom(circlesRoom);
	}

	public int deleteCirclesRoom(CirclesRoom circlesRoom) {
		return dao.deleteCirclesRoom(circlesRoom);
	}

	public int modifyStatus(CirclesRoom circlesRoom) {
		return dao.modifyStatus(circlesRoom);
	}

	public int deleteCirclesRoomList(CirclesRoom circlesRoom) {
		return dao.deleteCirclesRoomList(circlesRoom);
	}

	public int addCheckData(CirclesRoom circlesRoom) {
		return dao.addCheckData(circlesRoom);
	}
	
	public List<CirclesRoom> getCirclesRoomRss(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomRss(circlesRoom);
	}

	public CirclesRoom getCirclesRoomUserInfo(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomUserInfo(circlesRoom);
	}

    public int getMonthCount(CirclesRoom circlesRoom) {return dao.getMonthCount(circlesRoom);}

	public int getWeekCount(CirclesRoom circlesRoom) {
		return dao.getWeekCount(circlesRoom);
	}

	public void getSendSms(CirclesRoom circlesRoom, Member sessionMemberInfo,HttpServletRequest request) {
		if (org.apache.commons.lang.StringUtils.isNotEmpty(sessionMemberInfo.getRec_key()) || (circlesRoom.getStatus() > 0 && circlesRoom.getStatus() < 3)) {

			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setManageCode("BS");
			String sms_msg;

			switch (circlesRoom.getStatus()) {
				case 0 :
					sms_msg = "신청완료(대구도서관)";
					librarySearch.setUserkey(sessionMemberInfo.getRec_key());
					break;
				case 1 :
					sms_msg = "승인완료(대구도서관)";
					librarySearch.setUserkey(circlesRoom.getRec_key());
					break;
				case 2 :
					sms_msg = "미승인(대구도서관)";
					librarySearch.setUserkey(circlesRoom.getRec_key());
					break;
				default:
					throw new IllegalArgumentException();
			}

			LibSearchAPI.sendSms(librarySearch, sms_msg, request.getRemoteAddr());
		}
	}

	public CirclesRoom getCirclesRoomTodayUserInfo(String user_id, String facility_id) {
		return dao.getCirclesRoomTodayUserInfo(user_id, facility_id);
	}

	public CirclesRoom getCirclesRoomOne(CirclesRoom circlesRoom) {
		return dao.getCirclesRoomOne(circlesRoom);
	}

	public CirclesRoom addCirclesFile(CirclesRoom circlesRoom) {
		MultipartFile mFile = circlesRoom.getCircles_file();
		String[] extensionArray = {"hwp", "txt", "pdf", "xlsx", "xls", "ppt", "docs"};

		if ( mFile != null ) {
			String serverFileName = Long.toString((System.currentTimeMillis()));
			String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + circlesRoom.getHomepage_id();

			for (String extension : extensionArray) {
				if(fileExtension.equals(extension)) {
					File f = circlesRoomStorage.addFile(mFile, serverFileName, filePath);
					circlesRoom.setServer_file_name(serverFileName);
					circlesRoom.setOrigin_file_name(originFileName);
					circlesRoom.setFile_extension(fileExtension);
					circlesRoom.setFile_size(f.length());
				}
			}
		}

		return circlesRoom;
	}

	public String getRootPath() {
		return circlesRoomStorage.getRootPath();
	}

	public void getDeleteFile(CirclesRoom circlesRoom) {
		String filePath = circlesRoom.getHomepage_id() + File.separator;
		circlesRoomStorage.deleteFile(circlesRoom.getServer_file_name(), filePath);
	}
}
