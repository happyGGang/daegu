package kr.go.gbelib.app.cms.module.readingNotes;

import java.util.List;

public interface ReadingNotesDao {

	int getReadingNotesCount(ReadingNotes readingNotes);

	List<ReadingNotes> getReadingNotesList(ReadingNotes readingNotes);

	int addReadingNotes(ReadingNotes readingNotes);

	ReadingNotes getReadingNotesOne(ReadingNotes readingNotes);

	int modifyReadingNotes(ReadingNotes readingNotes);

	int deleteReadingNotes(ReadingNotes readingNotes);

	int modifyReadingNotesStatusOne(ReadingNotes readingNotes);

	List<ReadingNotes> getReadingNotesExcelList(ReadingNotes readingNotes);

}
