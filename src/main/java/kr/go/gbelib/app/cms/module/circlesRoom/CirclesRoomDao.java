package kr.go.gbelib.app.cms.module.circlesRoom;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CirclesRoomDao {

	public int getCirclesRoomCount(CirclesRoom circlesRoom);

	public List<CirclesRoom> getCirclesRoomList(CirclesRoom circlesRoom);
	
	public List<CirclesRoom> getCirclesRoomReqView(CirclesRoom circlesRoom);
	
	public List<CirclesRoom> getCirclesRoomMyList(CirclesRoom circlesRoom);

	public int addCirclesRoom(CirclesRoom circlesRoom);

	public int deleteCirclesRoom(CirclesRoom circlesRoom);

	public int modifyStatus(CirclesRoom circlesRoom);

	public int deleteCirclesRoomList(CirclesRoom circlesRoom);

	public int addCheckData(CirclesRoom circlesRoom);

	public List<CirclesRoom> getCirclesRoomRss(CirclesRoom circlesRoom);

	CirclesRoom getCirclesRoomUserInfo(CirclesRoom circlesRoom);

    public int getMonthCount(CirclesRoom circlesRoom);

	public int getWeekCount(CirclesRoom circlesRoom);

	public CirclesRoom getCirclesRoomTodayUserInfo(@Param("user_id") String user_id, @Param("circles_div") String facility_id);

    public int getCirclesRoomDateTotalCount(@Param("homepage_id") String homepage_id, @Param("circles_div") String room_id, @Param("visit_date") String reserve_date);

	List<CirclesRoom> getCirclesRoomReserveList(@Param("homepage_id") String homepage_id, @Param("circles_div") String room_id, @Param("visit_date") String reserve_date);

    CirclesRoom getCirclesRoomOne(CirclesRoom circlesRoom);
}
