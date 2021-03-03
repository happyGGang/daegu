package kr.go.gbelib.app.cms.module.readingNotes;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class ReadingNotesService extends BaseService {

	@Autowired
	private ReadingNotesDao dao;

	public int getReadingNotesCount(ReadingNotes readingNotes) {
		return dao.getReadingNotesCount(readingNotes);
	}

	public List<ReadingNotes> getReadingNotesList(ReadingNotes readingNotes) {
		return dao.getReadingNotesList(readingNotes);
	}

	public int addReadingNotes(ReadingNotes readingNotes) {
		return dao.addReadingNotes(readingNotes);
	}

	public ReadingNotes getReadingNotesOne(ReadingNotes readingNotes) {
		return dao.getReadingNotesOne(readingNotes);
	}

	public int modifyReadingNotes(ReadingNotes readingNotes) {
		return dao.modifyReadingNotes(readingNotes);
	}

	public int deleteReadingNotes(ReadingNotes readingNotes) {
		return dao.deleteReadingNotes(readingNotes);
	}

	public int modifyReadingNotesStatusOne(ReadingNotes readingNotes) {
		if (readingNotes.getApprove_status_replace().equals("C")) {
			readingNotes.setCancel_reason_replace("");
		} else if (readingNotes.getApprove_status_replace().equals("Y")) {
			readingNotes.setCancel_reason_replace("");
		}
		return dao.modifyReadingNotesStatusOne(readingNotes);
	}

	public int modifyReadingNotesStatus(ReadingNotes readingNotes) {
		int[] reading_notes_idx_arr = readingNotes.getReading_notes_idx_arr();
		String[] member_id_arr = readingNotes.getMember_id_arr();
		String[] cancel_reason_arr = readingNotes.getCancel_reason_arr();
		
		for (int i = 0; i < readingNotes.getReading_notes_idx_arr().length; i++) {
			if (readingNotes.getApprove_status_modify().equals("C")) {
				readingNotes.setApprove_status_replace("C");
				readingNotes.setCancel_reason_replace("");
				
			} else if (readingNotes.getApprove_status_modify().equals("Y")){
				readingNotes.setApprove_status_replace("Y");
				readingNotes.setCancel_reason_replace("");
				
			} else if (readingNotes.getApprove_status_modify().equals("N")) {
				readingNotes.setApprove_status_replace("N");
				readingNotes.setCancel_reason_replace(cancel_reason_arr[i]);
			}
			readingNotes.setReading_notes_idx(reading_notes_idx_arr[i]);
			readingNotes.setMember_id(member_id_arr[i]);
			dao.modifyReadingNotesStatusOne(readingNotes);
		}

		return 1;
	}

	public List<ReadingNotes> getReadingNotesExcelList(ReadingNotes readingNotes) {
		return dao.getReadingNotesExcelList(readingNotes);
	}

}
